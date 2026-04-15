import * as vscode from "vscode"
import { TERMINAL_NAME } from "./common"
import { selection, file } from "./editor"
import { start } from "./bridge"

let stop: (() => void) | undefined

export function deactivate() {
  stop?.()
}

export async function activate(context: vscode.ExtensionContext) {
  const bridge = await start(context)
  stop = bridge.stop

  const openNewTerminalDisposable = vscode.commands.registerCommand("opencode.openNewTerminal", async () => {
    await openTerminal()
  })

  const openTerminalDisposable = vscode.commands.registerCommand("opencode.openTerminal", async () => {
    const existingTerminal = await bridge.registered(vscode.window.activeTerminal)
    if (existingTerminal) {
      bridge.log("showing registered opencode terminal")
      existingTerminal.show()
      return
    }
    await openTerminal()
  })

  const addFilepathDisposable = vscode.commands.registerCommand("opencode.addFilepathToTerminal", async () => {
    const fileRef = file()
    if (!fileRef) return

    await appendToPrompt(fileRef)
  })

  const addSelectionDisposable = vscode.commands.registerCommand("opencode.addSelectionToTerminal", async () => {
    const fileRef = selection()
    if (!fileRef) return

    await appendToPrompt(fileRef)
  })

  const openDisposable = vscode.window.onDidOpenTerminal((terminal) => {
    void bridge.track(terminal)
  })

  const closeDisposable = vscode.window.onDidCloseTerminal((terminal) => {
    void bridge.untrack(terminal)
  })

  const activeTerminalDisposable = vscode.window.onDidChangeActiveTerminal((terminal) => {
    void bridge.active(terminal)
  })

  const terminalStateDisposable = vscode.window.onDidChangeTerminalState((terminal) => {
    if (!terminal.state.isInteractedWith) return
    void bridge.active(terminal)
  })

  context.subscriptions.push(
    openNewTerminalDisposable,
    openTerminalDisposable,
    addFilepathDisposable,
    addSelectionDisposable,
    openDisposable,
    closeDisposable,
    activeTerminalDisposable,
    terminalStateDisposable,
    {
      dispose() {
        stop?.()
        stop = undefined
      },
    },
  )

  async function appendToPrompt(text: string) {
    // Intentionally do not fall back to terminal.sendText(). Mixed-version compatibility
    // with the older env/HTTP integration is a non-goal; add-file/add-selection should
    // only target registered bridge-backed instances.
    const pid = await bridge.target(vscode.window.activeTerminal)
    const terminal = pid ? await bridge.append(pid, text) : undefined
    if (terminal !== undefined) {
      bridge.log("text sent to registered instance", { pid })
      terminal?.show()
      return
    }
  }

  async function openTerminal() {
    bridge.log("creating opencode terminal")
    const terminal = vscode.window.createTerminal({
      name: TERMINAL_NAME,
      iconPath: {
        light: vscode.Uri.file(context.asAbsolutePath("images/button-dark.svg")),
        dark: vscode.Uri.file(context.asAbsolutePath("images/button-light.svg")),
      },
      location: {
        viewColumn: vscode.ViewColumn.Beside,
        preserveFocus: false,
      },
    })

    terminal.show()
    terminal.sendText("opencode")
    bridge.log("launched opencode in terminal")

    const fileRef = selection()
    if (!fileRef) return

    const pid = await terminal.processId
    if (!pid) return
    if (!(await bridge.join(pid))) {
      bridge.log("registration missing", { pid })
      terminal.show()
      return
    }
    if (!(await bridge.ready(pid))) {
      bridge.log("instance not ready", { pid })
      terminal.show()
      return
    }
    if ((await bridge.append(pid, `In ${fileRef}`)) === undefined) {
      bridge.log("append failed after launch", { pid })
    }
    terminal.show()
  }
}
