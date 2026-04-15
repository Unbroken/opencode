import { randomBytes } from "node:crypto"
import { createServer } from "node:http"
import type { Duplex } from "node:stream"
import * as vscode from "vscode"
import { WebSocketServer, type RawData, type WebSocket } from "ws"
import { HOST, PING, type Link, type Msg } from "./common"

export async function start(context: vscode.ExtensionContext) {
  const out = vscode.window.createOutputChannel("opencode")
  const auth = randomBytes(32).toString("hex")
  const link = new Map<number, Link>()
  const termpid = new Set<number>()
  const termmap = new Map<vscode.Terminal, number>()
  const live = new WeakMap<WebSocket, boolean>()
  const wait = new Map<number, Array<(ok: boolean) => void>>()
  const warm = new Map<number, Array<(ok: boolean) => void>>()
  let last: number | undefined

  function log(msg: string, data?: Record<string, unknown>) {
    const time = new Date().toISOString()
    if (!data) {
      out.appendLine(`[${time}] ${msg}`)
      return
    }
    out.appendLine(`[${time}] ${msg} ${JSON.stringify(data)}`)
  }

  function wake(pool: Map<number, Array<(ok: boolean) => void>>, pid: number, ok: boolean) {
    const list = pool.get(pid)
    if (!list) return
    pool.delete(pid)
    for (const item of list) item(ok)
  }

  function clear(pid: number) {
    const item = link.get(pid)
    if (!item) return
    log("instance cleared", { pid, pids: item.pids, port: item.port, host: item.host })
    for (const alias of item.pids) {
      if (link.get(alias) === item) link.delete(alias)
      if (last === alias) last = undefined
      wake(wait, alias, false)
      wake(warm, alias, false)
    }
  }

  function alive(sock: WebSocket) {
    live.set(sock, true)
  }

  function addr(input?: string) {
    if (!input || input === "0.0.0.0" || input === "::") return HOST
    return input
  }

  function deny(sock: Duplex, code: number, text: string) {
    sock.write(`HTTP/1.1 ${code} ${text}\r\nConnection: close\r\n\r\n`)
    sock.destroy()
  }

  function text(input: RawData) {
    if (typeof input === "string") return input
    if (Array.isArray(input)) return Buffer.concat(input).toString("utf8")
    if (Buffer.isBuffer(input)) return input.toString("utf8")
    return Buffer.from(new Uint8Array(input)).toString("utf8")
  }

  function isMsg(input: unknown): input is Msg {
    if (typeof input !== "object" || input === null || !("type" in input)) return false
    if (input.type === "active") return true
    if (input.type !== "register") return false
    if (!("pids" in input) || !Array.isArray(input.pids) || !input.pids.every((item) => typeof item === "number"))
      return false
    if (!("port" in input) || typeof input.port !== "number") return false
    if ("host" in input && input.host !== undefined && typeof input.host !== "string") return false
    if ("authorization" in input && input.authorization !== undefined && typeof input.authorization !== "string")
      return false
    return true
  }

  function msg(input: RawData) {
    const result: unknown = JSON.parse(text(input))
    if (isMsg(result)) return result
    throw new Error("invalid message")
  }

  async function track(term?: vscode.Terminal): Promise<number | undefined> {
    if (!term) return undefined
    const pid = await term.processId
    if (!pid) return undefined
    const prev = termmap.get(term)
    if (prev === pid) return pid
    if (prev) termpid.delete(prev)
    termmap.set(term, pid)
    termpid.add(pid)
    return pid
  }

  async function untrack(term: vscode.Terminal) {
    const pid = termmap.get(term) ?? (await term.processId)
    termmap.delete(term)
    if (!pid) return
    termpid.delete(pid)
  }

  async function aliases(list: number[]) {
    await Promise.all(vscode.window.terminals.map((term) => track(term)))
    const seen = new Set<number>()
    const pids: number[] = []
    for (const item of list) {
      if (!Number.isSafeInteger(item) || item <= 0 || seen.has(item)) continue
      seen.add(item)
      pids.push(item)
      if (termpid.has(item)) return { pids, term: item }
    }
    return { pids: pids.length > 0 ? [pids[0]] : [] }
  }

  async function join(pid: number, ms = 5000) {
    if (link.has(pid)) return true
    log("waiting for instance registration", { pid, ms })
    return new Promise<boolean>((resolve) => {
      const done = (ok: boolean) => {
        clearTimeout(timer)
        log(ok ? "joined instance" : "join instance timed out", { pid })
        resolve(ok)
      }
      wait.set(pid, [...(wait.get(pid) ?? []), done])
      const timer = setTimeout(() => {
        const next = (wait.get(pid) ?? []).filter((item) => item !== done)
        if (next.length > 0) wait.set(pid, next)
        else wait.delete(pid)
        resolve(false)
      }, ms)
      timer.unref?.()
    })
  }

  async function ready(pid: number, ms = 5000) {
    if (link.get(pid)?.ready) return true
    log("waiting for instance ready", { pid, ms })
    return new Promise<boolean>((resolve) => {
      const done = (ok: boolean) => {
        clearTimeout(timer)
        log(ok ? "instance ready" : "instance ready timed out", { pid })
        resolve(ok)
      }
      warm.set(pid, [...(warm.get(pid) ?? []), done])
      const timer = setTimeout(() => {
        const next = (warm.get(pid) ?? []).filter((item) => item !== done)
        if (next.length > 0) warm.set(pid, next)
        else warm.delete(pid)
        resolve(false)
      }, ms)
      timer.unref?.()
    })
  }

  async function active(term?: vscode.Terminal) {
    let pid = await track(term)
    if (pid && link.has(pid)) {
      pid = link.get(pid)?.pids[0]
      if (last !== pid) {
        last = pid
        log("active terminal switched to registered instance", { pid })
      }
    }
  }

  async function term(pid: number): Promise<vscode.Terminal | undefined> {
    for (const item of vscode.window.terminals) {
      if ((await track(item)) === pid) return item
    }
    return undefined
  }

  async function registered(input?: vscode.Terminal): Promise<vscode.Terminal | undefined> {
    const pid = await target(input)
    if (!pid) return undefined
    const item = link.get(pid)
    if (!item?.term) return undefined
    return term(item.term)
  }

  async function append(pid: number, text: string): Promise<vscode.Terminal | null | undefined> {
    const item = link.get(pid)
    if (!item) {
      log("append skipped, missing instance", { pid })
      return undefined
    }
    try {
      log("append prompt", { pid, port: item.port, host: item.host, text })
      // `item.host` comes from `URL.hostname`; IPv6 stays bracketed (`[::1]`),
      // so this interpolation remains a valid fetch URL.
      const result = await fetch(`http://${item.host}:${item.port}/tui/append-prompt`, {
        method: "POST",
        headers: {
          "content-type": "application/json",
          ...(item.authorization ? { authorization: item.authorization } : {}),
        },
        body: JSON.stringify({ text }),
      })
      if (!result.ok) {
        log("append prompt failed", { pid, status: result.status })
        return undefined
      }
      log("append prompt delivered", { pid })
      if (!item.term) return null
      return term(item.term)
    } catch (error) {
      log("append prompt errored", {
        pid,
        error: error instanceof Error ? error.message : String(error),
      })
      return undefined
    }
  }

  async function target(term?: vscode.Terminal): Promise<number | undefined> {
    if (last && link.has(last)) {
      log("selected last active instance", { pid: last })
      return last
    }
    const pid = await track(term)
    if (pid && link.has(pid)) {
      log("selected active terminal instance", { pid })
      return pid
    }
    log("no registered instance available")
    return undefined
  }

  const server = createServer()
  const ws = new WebSocketServer({ noServer: true })

  server.on("upgrade", (req, sock, head) => {
    const url = new URL(req.url ?? "/", `http://${HOST}`)
    if (url.pathname !== "/connect") {
      log("rejected websocket upgrade", { path: url.pathname, reason: "not_found" })
      deny(sock, 404, "Not Found")
      return
    }
    if (url.searchParams.get("auth") !== auth) {
      log("rejected websocket upgrade", { path: url.pathname, reason: "unauthorized" })
      deny(sock, 401, "Unauthorized")
      return
    }
    log("accepted websocket upgrade")
    ws.handleUpgrade(req, sock, head, (item) => {
      ws.emit("connection", item, req)
    })
  })

  ws.on("connection", (sock) => {
    alive(sock)
    let pid: number | undefined
    log("websocket connected")

    sock.on("pong", () => alive(sock))
    sock.on("message", async (raw) => {
      try {
        const body = msg(raw)
        if (body.type === "register") {
          const all = [...new Set(body.pids)].filter((item) => Number.isSafeInteger(item) && item > 0)
          const match = await aliases(all)
          const pids = match.pids
          if (pids.length === 0) {
            log("rejecting register message", { reason: "terminal_pid_not_found", pids: all, terminals: [...termpid] })
            sock.close(1008, "terminal pid not found")
            return
          }
          if (!match.term) {
            log("registering instance without terminal pid", { pid: pids[0], pids: all, terminals: [...termpid] })
          }
          if (!Number.isSafeInteger(body.port) || body.port <= 0) {
            log("rejecting register message", { pids: all, reason: "invalid_port" })
            sock.close(1008, "invalid port")
            return
          }
          for (const alias of pids) {
            const prev = link.get(alias)
            if (prev && prev.sock !== sock) prev.sock.close()
          }
          pid = pids[0]
          const item = {
            sock,
            pids,
            term: match.term,
            ready: false,
            port: body.port,
            host: addr(body.host),
            authorization: body.authorization,
          }
          for (const alias of pids) link.set(alias, item)
          last = pid
          log("instance registered", { pid, pids, term: match.term, port: body.port, host: addr(body.host) })
          for (const alias of pids) wake(wait, alias, true)
          return
        }
        if (body.type === "active" && pid && link.get(pid)?.sock === sock) {
          const item = link.get(pid)
          if (item && !item.ready) {
            item.ready = true
            for (const alias of item.pids) wake(warm, alias, true)
          }
          if (last !== pid) {
            last = pid
            log("instance marked active", { pid })
          }
        }
      } catch (error) {
        log("invalid websocket message", {
          error: error instanceof Error ? error.message : String(error),
        })
        sock.close(1008, "invalid message")
      }
    })

    sock.on("close", () => {
      log("websocket closed", { pid })
      if (!pid) return
      if (link.get(pid)?.sock !== sock) return
      clear(pid)
    })
  })

  const ping = setInterval(() => {
    for (const item of ws.clients) {
      if (!live.get(item)) {
        log("terminating unresponsive websocket")
        item.terminate()
        continue
      }
      live.set(item, false)
      item.ping()
    }
  }, PING)
  ping.unref?.()

  const port = await new Promise<number>((resolve, reject) => {
    server.once("error", reject)
    server.listen(0, HOST, () => {
      const addr = server.address()
      if (!addr || typeof addr === "string") {
        reject(new Error("Failed to bind opencode extension server"))
        return
      }
      resolve(addr.port)
    })
  })
  log("extension listener started", { host: HOST, port })

  context.environmentVariableCollection.replace("_EXTENSION_OPENCODE_PORT", String(port))
  context.environmentVariableCollection.replace("_EXTENSION_OPENCODE_AUTH", auth)
  context.environmentVariableCollection.replace("OPENCODE_CALLER", "vscode")
  log("terminal environment updated")
  await Promise.all(vscode.window.terminals.map((term) => track(term)))

  function stop() {
    log("extension stopping")
    context.environmentVariableCollection.delete("_EXTENSION_OPENCODE_PORT")
    context.environmentVariableCollection.delete("_EXTENSION_OPENCODE_AUTH")
    context.environmentVariableCollection.delete("OPENCODE_CALLER")
    clearInterval(ping)
    for (const pid of Array.from(link.keys())) clear(pid)
    for (const item of ws.clients) item.terminate()
    for (const list of wait.values()) {
      for (const item of list) item(false)
    }
    wait.clear()
    for (const list of warm.values()) {
      for (const item of list) item(false)
    }
    warm.clear()
    termpid.clear()
    termmap.clear()
    ws.close()
    server.close()
    out.dispose()
  }

  return {
    active,
    append,
    join,
    log,
    ready,
    registered,
    stop,
    target,
    track,
    untrack,
  }
}
