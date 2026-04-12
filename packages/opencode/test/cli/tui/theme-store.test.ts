import { expect, test } from "bun:test"
import { RGBA } from "@opentui/core"

const { DEFAULT_THEMES, allThemes, addTheme, hasTheme, resolveTheme } =
  await import("../../../src/cli/cmd/tui/context/theme")

test("addTheme writes into module theme store", () => {
  const name = `plugin-theme-${Date.now()}`
  expect(addTheme(name, DEFAULT_THEMES.opencode)).toBe(true)

  expect(allThemes()[name]).toBeDefined()
})

test("addTheme keeps first theme for duplicate names", () => {
  const name = `plugin-theme-keep-${Date.now()}`
  const one = structuredClone(DEFAULT_THEMES.opencode)
  const two = structuredClone(DEFAULT_THEMES.opencode)
  one.theme.primary = "#101010"
  two.theme.primary = "#fefefe"

  expect(addTheme(name, one)).toBe(true)
  expect(addTheme(name, two)).toBe(false)

  expect(allThemes()[name]).toBeDefined()
  expect(allThemes()[name]!.theme.primary).toBe("#101010")
})

test("addTheme ignores entries without a theme object", () => {
  const name = `plugin-theme-invalid-${Date.now()}`
  expect(addTheme(name, { defs: { a: "#ffffff" } })).toBe(false)
  expect(allThemes()[name]).toBeUndefined()
})

test("hasTheme checks theme presence", () => {
  const name = `plugin-theme-has-${Date.now()}`
  expect(hasTheme(name)).toBe(false)
  expect(addTheme(name, DEFAULT_THEMES.opencode)).toBe(true)
  expect(hasTheme(name)).toBe(true)
})

test("resolveTheme rejects circular color refs", () => {
  const item = structuredClone(DEFAULT_THEMES.opencode)
  item.defs = {
    ...item.defs,
    one: "two",
    two: "one",
  }
  item.theme.primary = "one"

  expect(() => resolveTheme(item, "dark")).toThrow("Circular color reference")
})

test("resolveTheme fills extended syntax fallbacks", () => {
  const resolved = resolveTheme(structuredClone(DEFAULT_THEMES.opencode), "dark")

  expect(resolved.syntaxNamespace).toBe(resolved.accent)
  expect(resolved.syntaxLanguage).toBe(resolved.syntaxKeyword)
  expect(resolved.syntaxParameter).toBe(resolved.syntaxVariable)
  expect(resolved.syntaxFunctionGlobal).toBe(resolved.syntaxFunction)
  expect(resolved.syntaxCommentBg).toBe(resolved.background)
  expect(resolved.styleBold).toBe(true)
  expect(resolved.styleItalic).toBe(true)
})

test("malterlib keeps syntax styles disabled per entry", () => {
  const resolved = resolveTheme(structuredClone(DEFAULT_THEMES.malterlib), "dark")
  const meta = Reflect.get(resolved, "_style") as Record<string, { bold?: boolean; italic?: boolean }>

  expect(resolved.styleBold).toBe(true)
  expect(resolved.styleItalic).toBe(true)
  expect(meta.syntaxKeyword).toEqual({ bold: false, italic: false })
  expect(meta.syntaxKeywordType).toEqual({ bold: false, italic: false })
  expect(meta.syntaxComment).toEqual({ bold: false, italic: false })
})

test("resolveTheme keeps per-entry style overrides", () => {
  const item = structuredClone(DEFAULT_THEMES.opencode)
  item.theme.styleBold = false
  item.theme.styleItalic = false
  item.theme.markdownStrong = {
    value: "text",
    bold: true,
  }
  item.theme.markdownEmph = {
    value: "warning",
    italic: true,
  }
  item.theme.syntaxType = {
    value: "accent",
    bold: false,
  }
  delete item.theme.syntaxKeywordType

  const resolved = resolveTheme(item, "dark")
  const meta = Reflect.get(resolved, "_style") as Record<string, { bold?: boolean; italic?: boolean }>

  expect(resolved.styleBold).toBe(false)
  expect(resolved.styleItalic).toBe(false)
  expect(meta.markdownStrong).toEqual({ bold: true })
  expect(meta.markdownEmph).toEqual({ italic: true })
  expect(meta.syntaxKeywordType).toEqual({ bold: false })
})

test("malterlib keeps constants distinct from numbers", () => {
  const resolved = resolveTheme(structuredClone(DEFAULT_THEMES.malterlib), "dark")

  expect(resolved.syntaxNumber).not.toBe(resolved.syntaxConstant)
  expect(resolved.syntaxConstant).toEqual(resolved.syntaxConstantBuiltin)
})

test("malterlib keeps doc comments aligned with comment color", () => {
  const resolved = resolveTheme(structuredClone(DEFAULT_THEMES.malterlib), "dark")

  expect(resolved.syntaxCommentDoc).toEqual(resolved.syntaxComment)
  expect(resolved.syntaxCommentDocKeyword).toEqual(resolved.syntaxComment)
  expect(resolved.syntaxCommentDocLink).toEqual(resolved.syntaxComment)
})

test("malterlib uses Merge-style diff colors", () => {
  const resolved = resolveTheme(structuredClone(DEFAULT_THEMES.malterlib), "dark")

  expect(resolved.diffAdded).toEqual(RGBA.fromHex("#2a5912"))
  expect(resolved.diffRemoved).toEqual(RGBA.fromHex("#591212"))
  expect(resolved.diffHunkHeader).toEqual(RGBA.fromHex("#478cd1"))
  expect(resolved.diffAddedBg).toEqual(RGBA.fromHex("#0d2600"))
  expect(resolved.diffRemovedBg).toEqual(RGBA.fromHex("#260000"))
})
