import { describe, expect, test, beforeEach, afterAll } from "bun:test"
import { Ide } from "../../src/ide"

describe("ide", () => {
  const original = { ...process.env }

  beforeEach(() => {
    Object.keys(process.env).forEach((key) => {
      delete process.env[key]
    })
    Ide.reset()
  })

  afterAll(() => {
    Object.keys(process.env).forEach((key) => {
      delete process.env[key]
    })
    Object.assign(process.env, original)
  })

  test("should detect Visual Studio Code", () => {
    process.env["TERM_PROGRAM"] = "vscode"
    process.env["GIT_ASKPASS"] = "/path/to/Visual Studio Code.app/Contents/Resources/app/extensions/git/dist/askpass.sh"

    expect(Ide.name()).toBe("Visual Studio Code")
  })

  test("should detect Visual Studio Code Insiders", () => {
    process.env["TERM_PROGRAM"] = "vscode"
    process.env["GIT_ASKPASS"] =
      "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/extensions/git/dist/askpass.sh"

    expect(Ide.name()).toBe("Visual Studio Code - Insiders")
  })

  test("should detect Cursor", () => {
    process.env["TERM_PROGRAM"] = "vscode"
    process.env["GIT_ASKPASS"] = "/path/to/Cursor.app/Contents/Resources/app/extensions/git/dist/askpass.sh"

    expect(Ide.name()).toBe("Cursor")
  })

  test("should detect Unbroken Code from vscode env", () => {
    process.env["TERM_PROGRAM"] = "vscode"
    process.env["GIT_ASKPASS"] = "/Applications/Unbroken Code.app/Contents/Resources/app/extensions/git/dist/askpass.sh"

    expect(Ide.name()).toBe("Unbroken Code")
  })

  test("should detect VSCodium", () => {
    process.env["TERM_PROGRAM"] = "vscode"
    process.env["GIT_ASKPASS"] = "/path/to/VSCodium.app/Contents/Resources/app/extensions/git/dist/askpass.sh"

    expect(Ide.name()).toBe("VSCodium")
  })

  test("should detect Windsurf", () => {
    process.env["TERM_PROGRAM"] = "vscode"
    process.env["GIT_ASKPASS"] = "/path/to/Windsurf.app/Contents/Resources/app/extensions/git/dist/askpass.sh"

    expect(Ide.name()).toBe("Windsurf")
  })

  test("should return unknown when TERM_PROGRAM is not vscode", () => {
    process.env["TERM_PROGRAM"] = "iTerm2"
    process.env["GIT_ASKPASS"] =
      "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/extensions/git/dist/askpass.sh"

    expect(Ide.name()).toBe("unknown")
  })

  test("should return unknown when GIT_ASKPASS does not contain IDE name", () => {
    process.env["TERM_PROGRAM"] = "vscode"
    process.env["GIT_ASKPASS"] = "/path/to/unknown/askpass.sh"

    expect(Ide.name()).toBe("unknown")
  })

  test("should recognize vscode-insiders OPENCODE_CALLER", () => {
    process.env["OPENCODE_CALLER"] = "vscode-insiders"

    expect(Ide.alreadyInstalled()).toBe(true)
  })

  test("should recognize vscode OPENCODE_CALLER", () => {
    process.env["OPENCODE_CALLER"] = "vscode"

    expect(Ide.alreadyInstalled()).toBe(true)
  })

  test("should return false for unknown OPENCODE_CALLER", () => {
    process.env["OPENCODE_CALLER"] = "unknown"

    expect(Ide.alreadyInstalled()).toBe(false)
  })

  test("should report missing bridge env for vscode caller", () => {
    process.env["OPENCODE_CALLER"] = "vscode"

    expect(Ide.status()).toEqual({
      status: "error",
      error: "IDE bridge environment missing",
    })
  })

  test("should allow runtime ide status updates", () => {
    Ide.connecting()
    expect(Ide.status()).toEqual({ status: "connecting" })

    Ide.error("Lost connection to IDE bridge")
    expect(Ide.status()).toEqual({
      status: "error",
      error: "Lost connection to IDE bridge",
    })
  })
})
