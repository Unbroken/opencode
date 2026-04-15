import { BusEvent } from "@/bus/bus-event"
import { Schema } from "effect"
import { NamedError } from "@opencode-ai/core/util/error"
import * as Log from "@opencode-ai/core/util/log"
import { Process } from "@/util/process"
import { createSignal } from "solid-js"
import { randomBytes } from "node:crypto"

const SUPPORTED_IDES = [
  { name: "Unbroken Code" as const, cmd: "uc" },
  { name: "Windsurf" as const, cmd: "windsurf" },
  { name: "Visual Studio Code - Insiders" as const, cmd: "code-insiders" },
  { name: "Visual Studio Code" as const, cmd: "code" },
  { name: "Cursor" as const, cmd: "cursor" },
  { name: "VSCodium" as const, cmd: "codium" },
]

const log = Log.create({ service: "ide" })

export type Status =
  | { status: "disconnected" }
  | { status: "connecting" }
  | { status: "connected" }
  | { status: "error"; error: string }

type Msg =
  | {
      type: "register"
      pids: number[]
      port: number
      host: string
      authorization?: string
    }
  | {
      type: "active"
    }

type Auth = {
  username: string
  password: string
  authorization: string
}

type Env = {
  auth: string
  port: number
}

const [state, setState] = createSignal<Status | undefined>(undefined)

export const Event = {
  Installed: BusEvent.define(
    "ide.installed",
    Schema.Struct({
      ide: Schema.String,
    }),
  ),
}

export const AlreadyInstalledError = NamedError.create("AlreadyInstalledError", {})

export const InstallFailedError = NamedError.create("InstallFailedError", {
  stderr: Schema.String,
})

function boot() {
  if (!alreadyInstalled()) return { status: "disconnected" } as const
  if (!env()) {
    return {
      status: "error" as const,
      error: "IDE bridge environment missing",
    }
  }
  return { status: "connecting" } as const
}

function env(): Env | undefined {
  const auth = process.env["_EXTENSION_OPENCODE_AUTH"]
  const port = Number.parseInt(process.env["_EXTENSION_OPENCODE_PORT"] ?? "", 10)
  if (!auth || !Number.isSafeInteger(port) || port <= 0) return
  return { auth, port }
}

function basic(input: { username: string; password: string }) {
  return `Basic ${btoa(`${input.username}:${input.password}`)}`
}

async function parentWindows(pid: number) {
  const cmd = `(Get-CimInstance Win32_Process -Filter \"ProcessId = ${pid}\").ParentProcessId`
  for (const exe of ["powershell.exe", "pwsh.exe", "pwsh", "powershell"]) {
    const out = await Process.text([exe, "-NoProfile", "-NonInteractive", "-Command", cmd], {
      nothrow: true,
    })
    if (out.code !== 0) continue
    const next = Number.parseInt(out.text.trim(), 10)
    if (!Number.isSafeInteger(next) || next <= 0) continue
    return next
  }
}

async function parent(pid: number) {
  const out =
    process.platform === "win32"
      ? await parentWindows(pid).then((value) => ({ code: value ? 0 : 1, text: String(value ?? "") }))
      : await Process.text(["ps", "-o", "ppid=", "-p", String(pid)], {
          nothrow: true,
        })
  if (out.code !== 0) return
  const next = Number.parseInt(out.text.trim(), 10)
  if (!Number.isSafeInteger(next) || next <= 0) return
  return next
}

async function pids() {
  const list = [process.pid]
  let pid = process.ppid
  for (let i = 0; i < 5; i++) {
    if (!Number.isSafeInteger(pid) || pid <= 0 || list.includes(pid)) break
    list.push(pid)
    pid = (await parent(pid)) ?? 0
  }
  return list
}

export function name() {
  if (process.env["TERM_PROGRAM"] === "vscode") {
    const v = process.env["GIT_ASKPASS"]
    for (const ide of SUPPORTED_IDES) {
      if (v?.includes(ide.name)) return ide.name
    }
  }
  return "unknown"
}

export function alreadyInstalled() {
  return process.env["OPENCODE_CALLER"] === "vscode" || process.env["OPENCODE_CALLER"] === "vscode-insiders"
}

export function status() {
  return state() ?? boot()
}

export function summary() {
  const ide = name()
  const item = status()
  return {
    name: ide === "unknown" ? "IDE" : ide,
    status: item.status,
    note:
      item.status === "connected"
        ? "Connected"
        : item.status === "connecting"
          ? "Connecting"
          : item.status === "error"
            ? item.error
            : "Not connected",
  }
}

export function connecting() {
  setState({ status: "connecting" })
}

export function connected() {
  setState({ status: "connected" })
}

export function error(error: string) {
  setState({ status: "error", error })
}

export function reset() {
  setState(undefined)
}

export function serverAuth(external: boolean): Auth | undefined {
  if (external || !env()) return
  const username = "opencode"
  const password = randomBytes(24).toString("hex")
  return {
    username,
    password,
    authorization: basic({ username, password }),
  }
}

export function link(input: { host: string; port: number; authorization?: string }) {
  const cfg = env()
  if (!cfg) {
    if (alreadyInstalled()) error("IDE bridge environment missing")
    return
  }

  const url = `ws://127.0.0.1:${cfg.port}/connect?auth=${encodeURIComponent(cfg.auth)}`
  let ws: WebSocket | undefined
  let settled = false
  let opened = false
  let stopped = false

  function send(msg: Msg) {
    if (ws?.readyState !== WebSocket.OPEN) return
    ws.send(JSON.stringify(msg))
  }

  return {
    async open() {
      connecting()
      const list = await pids()
      await new Promise<void>((resolve) => {
        const sock = new WebSocket(url)
        const finish = () => {
          if (settled) return
          settled = true
          resolve()
        }
        sock.addEventListener("open", () => {
          ws = sock
          opened = true
          connected()
          send({
            type: "register",
            pids: list,
            port: input.port,
            host: input.host,
            authorization: input.authorization,
          })
          finish()
        })
        sock.addEventListener(
          "close",
          (evt) => {
            ws = undefined
            if (!opened) error("Failed to connect to IDE bridge")
            else if (!stopped) error(evt.reason || "Lost connection to IDE bridge")
            finish()
          },
          { once: true },
        )
        sock.addEventListener(
          "error",
          () => {
            if (!opened) error("Failed to connect to IDE bridge")
            finish()
          },
          { once: true },
        )
      })
    },
    active() {
      if (ws?.readyState !== WebSocket.OPEN) return error("IDE bridge unavailable")
      connected()
      send({ type: "active" })
    },
    close() {
      stopped = true
      ws?.close()
    },
  }
}

export async function install(ide: (typeof SUPPORTED_IDES)[number]["name"]) {
  const cmd = SUPPORTED_IDES.find((i) => i.name === ide)?.cmd
  if (!cmd) throw new Error(`Unknown IDE: ${ide}`)

  const p = await Process.run([cmd, "--install-extension", "sst-dev.opencode"], {
    nothrow: true,
  })
  const stdout = p.stdout.toString()
  const stderr = p.stderr.toString()

  log.info("installed", {
    ide,
    stdout,
    stderr,
  })

  if (p.code !== 0) {
    throw new InstallFailedError({ stderr })
  }
  if (stdout.includes("already installed")) {
    throw new AlreadyInstalledError({})
  }
}

export * as Ide from "."
