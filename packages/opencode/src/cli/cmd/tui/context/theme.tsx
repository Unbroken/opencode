import { CliRenderEvents, SyntaxStyle, RGBA, type TerminalColors } from "@opentui/core"
import path from "path"
import { createEffect, createMemo, onCleanup, onMount } from "solid-js"
import { createSimpleContext } from "./helper"
import { Glob } from "@opencode-ai/core/util/glob"
import aura from "./theme/aura.json" with { type: "json" }
import ayu from "./theme/ayu.json" with { type: "json" }
import catppuccin from "./theme/catppuccin.json" with { type: "json" }
import catppuccinFrappe from "./theme/catppuccin-frappe.json" with { type: "json" }
import catppuccinMacchiato from "./theme/catppuccin-macchiato.json" with { type: "json" }
import cobalt2 from "./theme/cobalt2.json" with { type: "json" }
import cursor from "./theme/cursor.json" with { type: "json" }
import dracula from "./theme/dracula.json" with { type: "json" }
import everforest from "./theme/everforest.json" with { type: "json" }
import flexoki from "./theme/flexoki.json" with { type: "json" }
import github from "./theme/github.json" with { type: "json" }
import gruvbox from "./theme/gruvbox.json" with { type: "json" }
import kanagawa from "./theme/kanagawa.json" with { type: "json" }
import malterlib from "./theme/malterlib.json" with { type: "json" }
import material from "./theme/material.json" with { type: "json" }
import matrix from "./theme/matrix.json" with { type: "json" }
import mercury from "./theme/mercury.json" with { type: "json" }
import monokai from "./theme/monokai.json" with { type: "json" }
import nightowl from "./theme/nightowl.json" with { type: "json" }
import nord from "./theme/nord.json" with { type: "json" }
import osakaJade from "./theme/osaka-jade.json" with { type: "json" }
import onedark from "./theme/one-dark.json" with { type: "json" }
import opencode from "./theme/opencode.json" with { type: "json" }
import orng from "./theme/orng.json" with { type: "json" }
import lucentOrng from "./theme/lucent-orng.json" with { type: "json" }
import palenight from "./theme/palenight.json" with { type: "json" }
import rosepine from "./theme/rosepine.json" with { type: "json" }
import solarized from "./theme/solarized.json" with { type: "json" }
import synthwave84 from "./theme/synthwave84.json" with { type: "json" }
import tokyonight from "./theme/tokyonight.json" with { type: "json" }
import vercel from "./theme/vercel.json" with { type: "json" }
import vesper from "./theme/vesper.json" with { type: "json" }
import zenburn from "./theme/zenburn.json" with { type: "json" }
import carbonfox from "./theme/carbonfox.json" with { type: "json" }
import { useKV } from "./kv"
import { useRenderer } from "@opentui/solid"
import { createStore, produce } from "solid-js/store"
import { Global } from "@opencode-ai/core/global"
import { Filesystem } from "@/util/filesystem"
import { useTuiConfig } from "./tui-config"
import { isRecord } from "@/util/record"
import type { TuiThemeCurrent } from "@opencode-ai/plugin/tui"

type Theme = TuiThemeCurrent & {
  _hasSelectedListItemText: boolean
  _style: Partial<Record<ThemeColor, Gate>>
}
type ThemeColor = Exclude<keyof TuiThemeCurrent, "thinkingOpacity" | "styleBold" | "styleItalic">
type SyntaxStyleOverrides = Record<string, { italic?: boolean }>

export function selectedForeground(theme: Theme, bg?: RGBA): RGBA {
  // If theme explicitly defines selectedListItemText, use it
  if (theme._hasSelectedListItemText) {
    return theme.selectedListItemText
  }

  // For transparent backgrounds, calculate contrast based on the actual bg (or fallback to primary)
  if (theme.background.a === 0) {
    const targetColor = bg ?? theme.primary
    const { r, g, b } = targetColor
    const luminance = 0.299 * r + 0.587 * g + 0.114 * b
    return luminance > 0.5 ? RGBA.fromInts(0, 0, 0) : RGBA.fromInts(255, 255, 255)
  }

  // Fall back to background color
  return theme.background
}

type HexColor = `#${string}`
type RefName = string
type Variant = {
  dark: HexColor | RefName
  light: HexColor | RefName
}
type ColorValue = HexColor | RefName | Variant | RGBA
type Gate = {
  bold?: boolean
  italic?: boolean
}
type Entry =
  | ColorValue
  | (Gate & {
      value: ColorValue
    })
type RequiredThemeColor = "primary" | "secondary" | "accent" | "text" | "textMuted" | "background"
export type ThemeJson = {
  $schema?: string
  defs?: Record<string, HexColor | RefName>
  theme: Partial<Record<ThemeColor, Entry>> &
    Pick<Record<RequiredThemeColor, Entry>, RequiredThemeColor> & {
      styleBold?: boolean
      styleItalic?: boolean
      thinkingOpacity?: number
    }
}

const THEME_FALLBACKS: Partial<Record<ThemeColor, ThemeColor>> = {
  syntaxLanguage: "syntaxKeyword",
  syntaxKeywordType: "syntaxType",
  syntaxKeywordStorage: "syntaxKeyword",
  syntaxKeywordAccess: "syntaxKeyword",
  syntaxKeywordQualifier: "syntaxKeyword",
  syntaxBuiltinType: "error",
  syntaxConstant: "syntaxNumber",
  syntaxConstantTemplate: "syntaxConstant",
  syntaxConstantBuiltin: "syntaxConstant",
  syntaxConstantBuiltinPrivate: "syntaxConstantBuiltin",
  syntaxConstantTemplateFunction: "syntaxConstantTemplate",
  syntaxCharacter: "syntaxString",
  syntaxNamespace: "accent",
  syntaxTypeTemplate: "syntaxType",
  syntaxTypeTemplateFunction: "syntaxTypeTemplate",
  syntaxTypeAuto: "syntaxType",
  syntaxFunctorParam: "syntaxParameter",
  syntaxFunctorOutput: "syntaxParameterOutput",
  syntaxFunctor: "syntaxVariable",
  syntaxFunctorMember: "syntaxMember",
  syntaxFunctorMemberPrivate: "syntaxMemberPrivate",
  syntaxFunctionMember: "syntaxFunction",
  syntaxFunctionGlobal: "syntaxFunction",
  syntaxFunctionPrivate: "syntaxFunction",
  syntaxParameter: "syntaxVariable",
  syntaxParameterOutput: "syntaxParameter",
  syntaxConcept: "warning",
  syntaxMember: "syntaxVariable",
  syntaxMemberPrivate: "syntaxMember",
  syntaxMacro: "syntaxKeyword",
  syntaxMacroParam: "syntaxMacro",
  syntaxGlobalStatic: "syntaxMember",
  syntaxGlobal: "syntaxVariable",
  syntaxGlobalStaticPrivate: "syntaxMemberPrivate",
  syntaxCommentDoc: "syntaxComment",
  syntaxCommentDocKeyword: "syntaxKeyword",
  syntaxCommentDocLink: "markdownLink",
  syntaxCommentBg: "background",
  syntaxCommentDocBg: "syntaxCommentBg",
}

const DEFAULT_THEME = "malterlib"

export const DEFAULT_THEMES: Record<string, ThemeJson> = {
  aura,
  ayu,
  catppuccin,
  ["catppuccin-frappe"]: catppuccinFrappe,
  ["catppuccin-macchiato"]: catppuccinMacchiato,
  cobalt2,
  cursor,
  dracula,
  everforest,
  flexoki,
  github,
  gruvbox,
  kanagawa,
  malterlib,
  material,
  matrix,
  mercury,
  monokai,
  nightowl,
  nord,
  ["one-dark"]: onedark,
  ["osaka-jade"]: osakaJade,
  opencode,
  orng,
  ["lucent-orng"]: lucentOrng,
  palenight,
  rosepine,
  solarized,
  synthwave84,
  tokyonight,
  vesper,
  vercel,
  zenburn,
  carbonfox,
}

type State = {
  themes: Record<string, ThemeJson>
  mode: "dark" | "light"
  lock: "dark" | "light" | undefined
  active: string
  ready: boolean
}

const pluginThemes: Record<string, ThemeJson> = {}
let customThemes: Record<string, ThemeJson> = {}
let systemTheme: ThemeJson | undefined

function listThemes() {
  // Priority: defaults < plugin installs < custom files < generated system.
  const themes = {
    ...DEFAULT_THEMES,
    ...pluginThemes,
    ...customThemes,
  }
  if (!systemTheme) return themes
  return {
    ...themes,
    system: systemTheme,
  }
}

function syncThemes() {
  setStore("themes", listThemes())
}

const [store, setStore] = createStore<State>({
  themes: listThemes(),
  mode: "dark",
  lock: undefined,
  active: DEFAULT_THEME,
  ready: false,
})

export function allThemes() {
  return store.themes
}

function isTheme(theme: unknown): theme is ThemeJson {
  if (!isRecord(theme)) return false
  if (!isRecord(theme.theme)) return false
  return true
}

export function hasTheme(name: string) {
  if (!name) return false
  return allThemes()[name] !== undefined
}

export function addTheme(name: string, theme: unknown) {
  if (!name) return false
  if (!isTheme(theme)) return false
  if (hasTheme(name)) return false
  pluginThemes[name] = theme
  syncThemes()
  return true
}

export function upsertTheme(name: string, theme: unknown) {
  if (!name) return false
  if (!isTheme(theme)) return false
  if (customThemes[name] !== undefined) {
    customThemes[name] = theme
  } else {
    pluginThemes[name] = theme
  }
  syncThemes()
  return true
}

export function resolveTheme(theme: ThemeJson, mode: "dark" | "light") {
  const defs = theme.defs ?? {}
  const meta: Partial<Record<ThemeColor, Gate>> = {}

  function pick(c: Entry | ColorValue): ColorValue {
    if (c instanceof RGBA) return c
    if (!isRecord(c)) return c as ColorValue
    if ("value" in c) return c.value as ColorValue
    return c as ColorValue
  }

  function gate(c: Entry | ColorValue) {
    if (c instanceof RGBA) return
    if (!isRecord(c)) return
    const obj = c as Record<string, unknown>
    const bold = typeof obj.bold === "boolean" ? obj.bold : undefined
    const italic = typeof obj.italic === "boolean" ? obj.italic : undefined
    if (bold === undefined && italic === undefined) return
    return {
      ...(bold !== undefined ? { bold } : {}),
      ...(italic !== undefined ? { italic } : {}),
    }
  }

  function resolveColor(c: Entry | ColorValue, chain: string[] = []): RGBA {
    const value = pick(c)
    if (value instanceof RGBA) return value
    if (typeof value === "string") {
      if (value === "transparent" || value === "none") return RGBA.fromInts(0, 0, 0, 0)

      if (value.startsWith("#")) return RGBA.fromHex(value)

      if (chain.includes(value)) {
        throw new Error(`Circular color reference: ${[...chain, value].join(" -> ")}`)
      }

      const next = defs[value] ?? theme.theme[value as ThemeColor]
      if (next === undefined) {
        throw new Error(`Color reference "${value}" not found in defs or theme`)
      }
      return resolveColor(next, [...chain, value])
    }
    if (typeof value === "number") {
      return ansiToRgba(value)
    }
    return resolveColor(value[mode], chain)
  }

  const resolved = Object.fromEntries(
    Object.entries(theme.theme)
      .filter(
        ([key]) =>
          key !== "selectedListItemText" &&
          key !== "backgroundMenu" &&
          key !== "styleBold" &&
          key !== "styleItalic" &&
          key !== "thinkingOpacity",
      )
      .map(([key, value]) => {
        const style = gate(value as Entry)
        if (style) meta[key as ThemeColor] = style
        return [key, resolveColor(value as Entry)]
      }),
  ) as Partial<Record<ThemeColor, RGBA>>

  // Handle selectedListItemText separately since it's optional
  const hasSelectedListItemText = theme.theme.selectedListItemText !== undefined
  if (hasSelectedListItemText) {
    resolved.selectedListItemText = resolveColor(theme.theme.selectedListItemText!)
  } else {
    // Backward compatibility: if selectedListItemText is not defined, use background color
    // This preserves the current behavior for all existing themes
    resolved.selectedListItemText = resolved.background
  }

  // Handle backgroundMenu - optional with fallback to backgroundElement
  if (theme.theme.backgroundMenu !== undefined) {
    resolved.backgroundMenu = resolveColor(theme.theme.backgroundMenu)
  } else {
    resolved.backgroundMenu = resolved.backgroundElement
  }

  function fill(key: ThemeColor): RGBA | undefined {
    if (resolved[key]) return resolved[key]
    const next = THEME_FALLBACKS[key]
    if (!next) return undefined
    const value = fill(next)
    if (!value) return undefined
    resolved[key] = value
    return value
  }

  function pull(key: ThemeColor): Gate | undefined {
    if (meta[key]) return meta[key]
    const next = THEME_FALLBACKS[key]
    if (!next) return undefined
    const value = pull(next)
    if (!value) return undefined
    meta[key] = value
    return value
  }

  Object.keys(THEME_FALLBACKS).forEach((key) => {
    fill(key as ThemeColor)
    pull(key as ThemeColor)
  })

  const styleBold = theme.theme.styleBold ?? true
  const styleItalic = theme.theme.styleItalic ?? true

  // Handle thinkingOpacity - optional with default of 0.6
  const thinkingOpacity = theme.theme.thinkingOpacity ?? 0.6

  return {
    ...resolved,
    _hasSelectedListItemText: hasSelectedListItemText,
    _style: meta,
    styleBold,
    styleItalic,
    thinkingOpacity,
  } as Theme
}

function ansiToRgba(code: number): RGBA {
  // Standard ANSI colors (0-15)
  if (code < 16) {
    const ansiColors = [
      "#000000", // Black
      "#800000", // Red
      "#008000", // Green
      "#808000", // Yellow
      "#000080", // Blue
      "#800080", // Magenta
      "#008080", // Cyan
      "#c0c0c0", // White
      "#808080", // Bright Black
      "#ff0000", // Bright Red
      "#00ff00", // Bright Green
      "#ffff00", // Bright Yellow
      "#0000ff", // Bright Blue
      "#ff00ff", // Bright Magenta
      "#00ffff", // Bright Cyan
      "#ffffff", // Bright White
    ]
    return RGBA.fromHex(ansiColors[code] ?? "#000000")
  }

  // 6x6x6 Color Cube (16-231)
  if (code < 232) {
    const index = code - 16
    const b = index % 6
    const g = Math.floor(index / 6) % 6
    const r = Math.floor(index / 36)

    const val = (x: number) => (x === 0 ? 0 : x * 40 + 55)
    return RGBA.fromInts(val(r), val(g), val(b))
  }

  // Grayscale Ramp (232-255)
  if (code < 256) {
    const gray = (code - 232) * 10 + 8
    return RGBA.fromInts(gray, gray, gray)
  }

  // Fallback for invalid codes
  return RGBA.fromInts(0, 0, 0)
}

export const { use: useTheme, provider: ThemeProvider } = createSimpleContext({
  name: "Theme",
  init: (props: { mode: "dark" | "light" }) => {
    const renderer = useRenderer()
    const config = useTuiConfig()
    const kv = useKV()
    const pick = (value: unknown) => {
      if (value === "dark" || value === "light") return value
      return
    }

    setStore(
      produce((draft) => {
        const lock = pick(kv.get("theme_mode_lock"))
        const mode = lock ?? pick(renderer.themeMode) ?? props.mode
        if (!lock && pick(kv.get("theme_mode")) !== undefined) {
          kv.set("theme_mode", undefined)
        }
        draft.mode = mode
        draft.lock = lock
        const active = config.theme ?? kv.get("theme", DEFAULT_THEME)
        draft.active = typeof active === "string" ? active : DEFAULT_THEME
        draft.ready = false
      }),
    )

    createEffect(() => {
      const theme = config.theme
      if (theme) setStore("active", theme)
    })

    function init() {
      void Promise.allSettled([
        resolveSystemTheme(store.mode),
        getCustomThemes()
          .then((custom) => {
            customThemes = custom
            syncThemes()
          })
          .catch(() => {
            setStore("active", DEFAULT_THEME)
          }),
      ]).finally(() => {
        setStore("ready", true)
      })
    }

    onMount(init)

    function resolveSystemTheme(mode: "dark" | "light" = store.mode) {
      return renderer
        .getPalette({
          size: 16,
        })
        .then((colors: TerminalColors) => {
          if (!colors.palette[0]) {
            systemTheme = undefined
            syncThemes()
            if (store.active === "system") {
              setStore("active", DEFAULT_THEME)
            }
            return
          }
          systemTheme = generateSystem(colors, mode)
          syncThemes()
        })
        .catch(() => {
          systemTheme = undefined
          syncThemes()
          if (store.active === "system") {
            setStore("active", DEFAULT_THEME)
          }
        })
    }

    function apply(mode: "dark" | "light") {
      if (store.lock !== undefined) kv.set("theme_mode", mode)
      if (store.mode === mode) return
      setStore("mode", mode)
      renderer.clearPaletteCache()
      void resolveSystemTheme(mode)
    }

    function pin(mode: "dark" | "light" = store.mode) {
      setStore("lock", mode)
      kv.set("theme_mode_lock", mode)
      apply(mode)
    }

    function free() {
      setStore("lock", undefined)
      kv.set("theme_mode_lock", undefined)
      kv.set("theme_mode", undefined)
      const mode = renderer.themeMode
      if (mode) apply(mode)
    }

    const handle = (mode: "dark" | "light") => {
      if (store.lock) return
      apply(mode)
    }
    renderer.on(CliRenderEvents.THEME_MODE, handle)

    const refresh = () => {
      renderer.clearPaletteCache()
      init()
    }
    process.on("SIGUSR2", refresh)

    onCleanup(() => {
      renderer.off(CliRenderEvents.THEME_MODE, handle)
      process.off("SIGUSR2", refresh)
    })

    const values = createMemo(() => {
      const active = store.themes[store.active]
      if (active) {
        return resolveTheme(active, store.mode)
      }

      const saved = kv.get("theme")
      if (typeof saved === "string") {
        const theme = store.themes[saved]
        if (theme) {
          return resolveTheme(theme, store.mode)
        }
      }

      return resolveTheme(store.themes[DEFAULT_THEME], store.mode)
    })

    createEffect(() => {
      renderer.setBackgroundColor(values().background)
    })

    const syntax = createMemo(() => generateSyntax(values()))
    const subtleSyntax = createMemo(() => generateSubtleSyntax(values()))

    return {
      theme: new Proxy(values(), {
        get(_target, prop) {
          // @ts-expect-error
          return values()[prop]
        },
      }),
      get selected() {
        return store.active
      },
      all() {
        return allThemes()
      },
      has(name: string) {
        return hasTheme(name)
      },
      syntax,
      subtleSyntax,
      mode() {
        return store.mode
      },
      locked() {
        return store.lock !== undefined
      },
      lock() {
        pin(store.mode)
      },
      unlock() {
        free()
      },
      setMode(mode: "dark" | "light") {
        pin(mode)
      },
      set(theme: string) {
        if (!hasTheme(theme)) return false
        setStore("active", theme)
        kv.set("theme", theme)
        return true
      },
      get ready() {
        return store.ready
      },
    }
  },
})

async function getCustomThemes() {
  const directories = [
    Global.Path.config,
    ...(await Array.fromAsync(
      Filesystem.up({
        targets: [".opencode"],
        start: process.cwd(),
      }),
    )),
  ]

  const result: Record<string, ThemeJson> = {}
  for (const dir of directories) {
    for (const item of await Glob.scan("themes/*.json", {
      cwd: dir,
      absolute: true,
      dot: true,
      symlink: true,
    })) {
      const name = path.basename(item, ".json")
      const theme = await Filesystem.readJson(item)
      if (isTheme(theme)) result[name] = theme
    }
  }
  return result
}

export function tint(base: RGBA, overlay: RGBA, alpha: number): RGBA {
  const r = base.r + (overlay.r - base.r) * alpha
  const g = base.g + (overlay.g - base.g) * alpha
  const b = base.b + (overlay.b - base.b) * alpha
  return RGBA.fromInts(Math.round(r * 255), Math.round(g * 255), Math.round(b * 255))
}

export function generateSystem(colors: TerminalColors, mode: "dark" | "light"): ThemeJson {
  const bg = RGBA.fromHex(colors.defaultBackground ?? colors.palette[0]!)
  const fg = RGBA.fromHex(colors.defaultForeground ?? colors.palette[7]!)
  const transparent = RGBA.fromValues(bg.r, bg.g, bg.b, 0)
  const isDark = mode == "dark"

  const col = (i: number) => {
    const value = colors.palette[i]
    if (value) return RGBA.fromHex(value)
    return ansiToRgba(i)
  }

  // Generate gray scale based on terminal background
  const grays = generateGrayScale(bg, isDark)
  const textMuted = generateMutedTextColor(bg, isDark)

  // ANSI color references
  const ansiColors = {
    black: col(0),
    red: col(1),
    green: col(2),
    yellow: col(3),
    blue: col(4),
    magenta: col(5),
    cyan: col(6),
    white: col(7),
    redBright: col(9),
    greenBright: col(10),
  }

  const diffAlpha = isDark ? 0.22 : 0.14
  const diffAddedBg = tint(bg, ansiColors.green, diffAlpha)
  const diffRemovedBg = tint(bg, ansiColors.red, diffAlpha)
  const diffContextBg = grays[2]
  const diffAddedLineNumberBg = tint(diffContextBg, ansiColors.green, diffAlpha)
  const diffRemovedLineNumberBg = tint(diffContextBg, ansiColors.red, diffAlpha)
  const diffLineNumber = textMuted

  return {
    theme: {
      // Primary colors using ANSI
      primary: ansiColors.cyan,
      secondary: ansiColors.magenta,
      accent: ansiColors.cyan,

      // Status colors using ANSI
      error: ansiColors.red,
      warning: ansiColors.yellow,
      success: ansiColors.green,
      info: ansiColors.cyan,

      // Text colors
      text: fg,
      textMuted,
      selectedListItemText: bg,

      // Background colors - use transparent to respect terminal transparency
      background: transparent,
      backgroundPanel: grays[2],
      backgroundElement: grays[3],
      backgroundMenu: grays[3],

      // Border colors
      borderSubtle: grays[6],
      border: grays[7],
      borderActive: grays[8],

      // Diff colors
      diffAdded: ansiColors.green,
      diffRemoved: ansiColors.red,
      diffContext: grays[7],
      diffHunkHeader: grays[7],
      diffHighlightAdded: ansiColors.greenBright,
      diffHighlightRemoved: ansiColors.redBright,
      diffAddedBg,
      diffRemovedBg,
      diffContextBg,
      diffLineNumber,
      diffAddedLineNumberBg,
      diffRemovedLineNumberBg,

      // Markdown colors
      markdownText: fg,
      markdownHeading: fg,
      markdownLink: ansiColors.blue,
      markdownLinkText: ansiColors.cyan,
      markdownCode: ansiColors.green,
      markdownBlockQuote: ansiColors.yellow,
      markdownEmph: ansiColors.yellow,
      markdownStrong: fg,
      markdownHorizontalRule: grays[7],
      markdownListItem: ansiColors.blue,
      markdownListEnumeration: ansiColors.cyan,
      markdownImage: ansiColors.blue,
      markdownImageText: ansiColors.cyan,
      markdownCodeBlock: fg,

      // Syntax colors
      syntaxComment: textMuted,
      syntaxKeyword: ansiColors.magenta,
      syntaxFunction: ansiColors.blue,
      syntaxVariable: fg,
      syntaxString: ansiColors.green,
      syntaxNumber: ansiColors.yellow,
      syntaxType: ansiColors.cyan,
      syntaxOperator: ansiColors.cyan,
      syntaxPunctuation: fg,
      syntaxLanguage: fg,
      syntaxKeywordType: ansiColors.cyan,
      syntaxKeywordStorage: textMuted,
      syntaxKeywordAccess: ansiColors.magenta,
      syntaxKeywordQualifier: ansiColors.yellow,
      syntaxBuiltinType: ansiColors.red,
      syntaxConstant: ansiColors.yellow,
      syntaxConstantTemplate: ansiColors.magenta,
      syntaxConstantBuiltin: ansiColors.yellow,
      syntaxConstantBuiltinPrivate: ansiColors.yellow,
      syntaxConstantTemplateFunction: ansiColors.magenta,
      syntaxCharacter: ansiColors.green,
      syntaxNamespace: ansiColors.magenta,
      syntaxTypeTemplate: ansiColors.cyan,
      syntaxTypeTemplateFunction: ansiColors.cyan,
      syntaxTypeAuto: ansiColors.cyan,
      syntaxFunctorParam: ansiColors.cyan,
      syntaxFunctorOutput: ansiColors.cyan,
      syntaxFunctor: fg,
      syntaxFunctorMember: ansiColors.blue,
      syntaxFunctorMemberPrivate: ansiColors.blue,
      syntaxFunctionMember: ansiColors.blue,
      syntaxFunctionGlobal: ansiColors.blue,
      syntaxFunctionPrivate: ansiColors.blue,
      syntaxParameter: fg,
      syntaxParameterOutput: fg,
      syntaxConcept: ansiColors.yellow,
      syntaxMember: fg,
      syntaxMemberPrivate: fg,
      syntaxMacro: ansiColors.magenta,
      syntaxMacroParam: ansiColors.magenta,
      syntaxGlobalStatic: fg,
      syntaxGlobal: fg,
      syntaxGlobalStaticPrivate: fg,
      syntaxCommentDoc: textMuted,
      syntaxCommentDocKeyword: ansiColors.magenta,
      syntaxCommentDocLink: ansiColors.cyan,
      syntaxCommentBg: transparent,
      syntaxCommentDocBg: transparent,
      styleBold: true,
      styleItalic: true,
    },
  }
}

type Style = {
  foreground?: RGBA
  background?: RGBA
  bold?: boolean
  italic?: boolean
  underline?: boolean
}

function style(theme: Theme, key: ThemeColor, opts: Style): Style {
  const gate = theme._style[key]
  return {
    ...opts,
    ...(opts.bold === true && !(gate?.bold ?? theme.styleBold) ? { bold: false } : {}),
    ...(opts.italic === true && !(gate?.italic ?? theme.styleItalic) ? { italic: false } : {}),
  }
}

function generateGrayScale(bg: RGBA, isDark: boolean): Record<number, RGBA> {
  const grays: Record<number, RGBA> = {}

  // RGBA stores floats in range 0-1, convert to 0-255
  const bgR = bg.r * 255
  const bgG = bg.g * 255
  const bgB = bg.b * 255

  const luminance = 0.299 * bgR + 0.587 * bgG + 0.114 * bgB

  for (let i = 1; i <= 12; i++) {
    const factor = i / 12.0

    let grayValue: number
    let newR: number
    let newG: number
    let newB: number

    if (isDark) {
      if (luminance < 10) {
        grayValue = Math.floor(factor * 0.4 * 255)
        newR = grayValue
        newG = grayValue
        newB = grayValue
      } else {
        const newLum = luminance + (255 - luminance) * factor * 0.4

        const ratio = newLum / luminance
        newR = Math.min(bgR * ratio, 255)
        newG = Math.min(bgG * ratio, 255)
        newB = Math.min(bgB * ratio, 255)
      }
    } else {
      if (luminance > 245) {
        grayValue = Math.floor(255 - factor * 0.4 * 255)
        newR = grayValue
        newG = grayValue
        newB = grayValue
      } else {
        const newLum = luminance * (1 - factor * 0.4)

        const ratio = newLum / luminance
        newR = Math.max(bgR * ratio, 0)
        newG = Math.max(bgG * ratio, 0)
        newB = Math.max(bgB * ratio, 0)
      }
    }

    grays[i] = RGBA.fromInts(Math.floor(newR), Math.floor(newG), Math.floor(newB))
  }

  return grays
}

function generateMutedTextColor(bg: RGBA, isDark: boolean): RGBA {
  // RGBA stores floats in range 0-1, convert to 0-255
  const bgR = bg.r * 255
  const bgG = bg.g * 255
  const bgB = bg.b * 255

  const bgLum = 0.299 * bgR + 0.587 * bgG + 0.114 * bgB

  let grayValue: number

  if (isDark) {
    if (bgLum < 10) {
      // Very dark/black background
      grayValue = 180 // #b4b4b4
    } else {
      // Scale up for lighter dark backgrounds
      grayValue = Math.min(Math.floor(160 + bgLum * 0.3), 200)
    }
  } else {
    if (bgLum > 245) {
      // Very light/white background
      grayValue = 75 // #4b4b4b
    } else {
      // Scale down for darker light backgrounds
      grayValue = Math.max(Math.floor(100 - (255 - bgLum) * 0.2), 60)
    }
  }

  return RGBA.fromInts(grayValue, grayValue, grayValue)
}

export function generateSyntax(theme: Theme) {
  return SyntaxStyle.fromTheme(getSyntaxRules(theme))
}

export function generateSubtleSyntax(theme: Theme, overrides?: SyntaxStyleOverrides) {
  const rules = getSyntaxRules(theme)
  return SyntaxStyle.fromTheme(
    rules.map((rule) => {
      const override = rule.scope.reduce((acc, scope) => ({ ...acc, ...overrides?.[scope] }), {})
      if (rule.style.foreground) {
        const fg = rule.style.foreground
        return {
          ...rule,
          style: {
            ...rule.style,
            ...override,
            foreground: RGBA.fromInts(
              Math.round(fg.r * 255),
              Math.round(fg.g * 255),
              Math.round(fg.b * 255),
              Math.round(theme.thinkingOpacity * 255),
            ),
          },
        }
      }
      return rule
    }),
  )
}

function malterlibRules(theme: Theme) {
  const rule = (scope: string[], color: ThemeColor, opts: Omit<Style, "foreground" | "background"> = {}) => ({
    scope,
    style: style(theme, color, {
      foreground: theme[color],
      ...opts,
    }),
  })

  return [
    rule(["malterlib.variable"], "syntaxVariable"),
    rule(
      [
        "malterlib.type",
        "malterlib.type.interface",
        "malterlib.type.function",
        "malterlib.template.type",
        "malterlib.template.type.interface",
        "malterlib.enum",
      ],
      "syntaxType",
    ),
    rule(["malterlib.namespace"], "syntaxNamespace"),
    rule(["malterlib.preprocessor.directive"], "syntaxLanguage"),
    rule(["malterlib.keyword.access"], "syntaxKeywordAccess"),
    rule(["malterlib.keyword.auto"], "syntaxTypeAuto"),
    rule(["malterlib.keyword.property.modifiers", "malterlib.keyword.typename"], "syntaxKeywordStorage"),
    rule(
      [
        "malterlib.keyword.builtin.character.types",
        "malterlib.keyword.builtin.float.types",
        "malterlib.keyword.builtin.integer.types",
        "malterlib.keyword.builtin.type.modifiers",
        "malterlib.keyword.builtin.types",
        "malterlib.keyword.builtin.vector.types",
      ],
      "syntaxBuiltinType",
    ),
    rule(["malterlib.keyword.builtin.constants"], "syntaxConstantBuiltin"),
    rule(["malterlib.keyword.this"], "syntaxLanguage"),
    rule(["malterlib.operator.reference"], "syntaxOperator"),
    rule(["malterlib.keyword.operator"], "syntaxOperator"),
    rule(["malterlib.keyword.storage.class"], "syntaxLanguage"),
    rule(["malterlib.keyword.qualifier"], "syntaxKeywordQualifier"),
    {
      scope: ["malterlib.keyword.property.modifiers.brackets"],
      style: {
        foreground: theme.textMuted,
      },
    },
    rule(["malterlib.keyword.type.specification"], "syntaxKeywordType", { bold: true, italic: true }),
    rule(
      [
        "malterlib.keyword.casts",
        "malterlib.keyword.introspection",
        "malterlib.keyword.namespace",
        "malterlib.keyword.new.delete",
        "malterlib.keyword.optimization",
        "malterlib.keyword.other",
        "malterlib.keyword.pure",
        "malterlib.keyword.static.assert",
        "malterlib.keyword.template",
        "malterlib.keyword.typedef",
        "malterlib.keyword.using",
        "malterlib.keyword.virtual",
      ],
      "syntaxLanguage",
    ),
    rule(
      ["malterlib.keyword.clr", "malterlib.keyword.control.statement", "malterlib.keyword.exception.handling"],
      "syntaxLanguage",
      { italic: true },
    ),
    rule(
      [
        "malterlib.template.type.param.class",
        "malterlib.template.type.param.class.pack",
        "malterlib.template.template.param",
        "malterlib.template.template.param.pack",
      ],
      "syntaxTypeTemplate",
    ),
    rule(
      [
        "malterlib.template.type.param.function",
        "malterlib.template.type.param.function.pack",
        "malterlib.function.template.type.param.class",
        "malterlib.function.template.type.param.class.pack",
        "malterlib.function.template.type.param.function",
        "malterlib.function.template.type.param.function.pack",
        "malterlib.function.template.template.param",
        "malterlib.function.template.template.param.pack",
      ],
      "syntaxTypeTemplateFunction",
    ),
    rule(["malterlib.template.non.type.param", "malterlib.template.non.type.param.pack"], "syntaxConstantTemplate"),
    rule(
      ["malterlib.function.template.non.type.param", "malterlib.function.template.non.type.param.pack"],
      "syntaxConstantTemplateFunction",
    ),
    rule(["malterlib.function.parameter", "malterlib.function.parameter.pack"], "syntaxParameter"),
    rule(["malterlib.function.parameter.functor", "malterlib.function.parameter.pack.functor"], "syntaxFunctorParam"),
    rule(["malterlib.function.parameter.output", "malterlib.function.parameter.output.pack"], "syntaxParameterOutput"),
    rule(
      ["malterlib.function.parameter.output.functor", "malterlib.function.parameter.output.pack.functor"],
      "syntaxFunctorOutput",
    ),
    rule(["malterlib.concept"], "syntaxConcept"),
    rule(
      [
        "malterlib.constant.variable",
        "malterlib.global.constant",
        "malterlib.enumerator",
        "malterlib.member.constant.public",
      ],
      "syntaxConstant",
    ),
    rule(["malterlib.member.constant.private"], "syntaxConstantBuiltinPrivate"),
    rule(["malterlib.macro"], "syntaxMacro", { italic: true }),
    rule(["malterlib.macro.parameter"], "syntaxMacroParam"),
    rule(["malterlib.variable.functor"], "syntaxFunctor"),
    rule(
      [
        "malterlib.function",
        "malterlib.function.recursive",
        "malterlib.static.function",
        "malterlib.static.function.recursive",
      ],
      "syntaxFunctionGlobal",
    ),
    rule(
      [
        "malterlib.member.function.public",
        "malterlib.member.function.public.recursive",
        "malterlib.member.static.function.public",
        "malterlib.member.static.function.public.recursive",
      ],
      "syntaxFunctionMember",
    ),
    rule(
      [
        "malterlib.member.function.private",
        "malterlib.member.function.private.recursive",
        "malterlib.member.static.function.private",
        "malterlib.member.static.function.private.recursive",
      ],
      "syntaxFunctionPrivate",
    ),
    rule(["malterlib.global.variable", "malterlib.global.variable.functor"], "syntaxGlobal"),
    rule(
      [
        "malterlib.global.static.variable",
        "malterlib.global.static.variable.functor",
        "malterlib.static.variable",
        "malterlib.static.variable.functor",
        "malterlib.member.static.variable.public",
        "malterlib.member.static.variable.public.functor",
      ],
      "syntaxGlobalStatic",
    ),
    rule(["malterlib.member.variable.public"], "syntaxMember"),
    rule(["malterlib.member.variable.public.functor"], "syntaxFunctorMember"),
    rule(
      ["malterlib.member.static.variable.private", "malterlib.member.static.variable.private.functor"],
      "syntaxGlobalStaticPrivate",
    ),
    rule(["malterlib.member.variable.private"], "syntaxMemberPrivate"),
    rule(["malterlib.member.variable.private.functor"], "syntaxFunctorMemberPrivate"),
  ]
}

function getSyntaxRules(theme: Theme) {
  return [
    {
      scope: ["default"],
      style: {
        foreground: theme.text,
      },
    },
    {
      scope: ["prompt"],
      style: {
        foreground: theme.accent,
      },
    },
    {
      scope: ["extmark.file"],
      style: style(theme, "warning", {
        foreground: theme.warning,
        bold: true,
      }),
    },
    {
      scope: ["extmark.agent"],
      style: style(theme, "secondary", {
        foreground: theme.secondary,
        bold: true,
      }),
    },
    {
      scope: ["extmark.paste"],
      style: style(theme, "warning", {
        foreground: selectedForeground(theme, theme.warning),
        background: theme.warning,
        bold: true,
      }),
    },
    {
      scope: ["comment"],
      style: style(theme, "syntaxComment", {
        foreground: theme.syntaxComment,
        background: theme.syntaxCommentBg,
        italic: true,
      }),
    },
    {
      scope: ["comment.documentation"],
      style: style(theme, "syntaxCommentDoc", {
        foreground: theme.syntaxCommentDoc,
        background: theme.syntaxCommentDocBg,
        italic: true,
      }),
    },
    {
      scope: ["comment.documentation.keyword"],
      style: style(theme, "syntaxCommentDocKeyword", {
        foreground: theme.syntaxCommentDocKeyword,
        background: theme.syntaxCommentDocBg,
        italic: true,
      }),
    },
    {
      scope: ["comment.link", "comment.documentation.link"],
      style: {
        foreground: theme.syntaxCommentDocLink,
        background: theme.syntaxCommentDocBg,
        underline: true,
      },
    },
    {
      scope: ["string", "symbol"],
      style: {
        foreground: theme.syntaxString,
      },
    },
    {
      scope: ["number", "float"],
      style: {
        foreground: theme.syntaxNumber,
      },
    },
    {
      scope: ["boolean", "constant.builtin"],
      style: {
        foreground: theme.syntaxConstantBuiltin,
      },
    },
    {
      scope: ["constant"],
      style: {
        foreground: theme.syntaxConstant,
      },
    },
    {
      scope: ["constant.template"],
      style: {
        foreground: theme.syntaxConstantTemplate,
      },
    },
    {
      scope: ["constant.template.function"],
      style: {
        foreground: theme.syntaxConstantTemplateFunction,
      },
    },
    {
      scope: ["constant.builtin.private", "constant.readonly"],
      style: {
        foreground: theme.syntaxConstantBuiltinPrivate,
      },
    },
    {
      scope: ["character.special", "character"],
      style: {
        foreground: theme.syntaxCharacter,
      },
    },
    {
      scope: ["keyword.return", "keyword.conditional", "keyword.repeat", "keyword.coroutine"],
      style: style(theme, "syntaxLanguage", {
        foreground: theme.syntaxLanguage,
        italic: true,
      }),
    },
    {
      scope: ["keyword.type"],
      style: style(theme, "syntaxKeywordType", {
        foreground: theme.syntaxKeywordType,
        bold: true,
        italic: true,
      }),
    },
    {
      scope: ["keyword.storage"],
      style: {
        foreground: theme.syntaxKeywordStorage,
      },
    },
    {
      scope: ["keyword.access"],
      style: {
        foreground: theme.syntaxKeywordAccess,
      },
    },
    {
      scope: ["keyword.qualifier"],
      style: {
        foreground: theme.syntaxKeywordQualifier,
      },
    },
    {
      scope: ["keyword.function"],
      style: {
        foreground: theme.syntaxLanguage,
      },
    },
    {
      scope: ["function.method", "function.method.call"],
      style: {
        foreground: theme.syntaxFunctionMember,
      },
    },
    {
      scope: ["keyword"],
      style: style(theme, "syntaxLanguage", {
        foreground: theme.syntaxLanguage,
        italic: true,
      }),
    },
    {
      scope: ["keyword.import"],
      style: {
        foreground: theme.syntaxLanguage,
      },
    },
    {
      scope: ["operator", "keyword.operator", "punctuation.delimiter"],
      style: {
        foreground: theme.syntaxOperator,
      },
    },
    {
      scope: ["keyword.conditional.ternary"],
      style: {
        foreground: theme.syntaxOperator,
      },
    },
    {
      scope: ["variable"],
      style: {
        foreground: theme.syntaxVariable,
      },
    },
    {
      scope: ["variable.parameter", "parameter"],
      style: {
        foreground: theme.syntaxParameter,
      },
    },
    {
      scope: ["parameter.output"],
      style: {
        foreground: theme.syntaxParameterOutput,
      },
    },
    {
      scope: ["variable.member", "property", "field"],
      style: {
        foreground: theme.syntaxMember,
      },
    },
    {
      scope: ["member.private", "property.private", "field.private"],
      style: {
        foreground: theme.syntaxMemberPrivate,
      },
    },
    {
      scope: ["function", "constructor", "function.call"],
      style: {
        foreground: theme.syntaxFunctionGlobal,
      },
    },
    {
      scope: ["function.private", "function.private.call"],
      style: {
        foreground: theme.syntaxFunctionPrivate,
      },
    },
    {
      scope: ["type", "class"],
      style: {
        foreground: theme.syntaxType,
      },
    },
    {
      scope: ["type.template"],
      style: {
        foreground: theme.syntaxTypeTemplate,
      },
    },
    {
      scope: ["type.template.function"],
      style: {
        foreground: theme.syntaxTypeTemplateFunction,
      },
    },
    {
      scope: ["type.auto"],
      style: {
        foreground: theme.syntaxTypeAuto,
      },
    },
    {
      scope: ["module", "namespace", "module.builtin"],
      style: {
        foreground: theme.syntaxNamespace,
      },
    },
    {
      scope: ["type.builtin"],
      style: {
        foreground: theme.syntaxBuiltinType,
      },
    },
    {
      scope: ["variable.builtin", "variable.super"],
      style: {
        foreground: theme.syntaxConstantBuiltin,
      },
    },
    {
      scope: ["function.builtin"],
      style: {
        foreground: theme.syntaxFunctionGlobal,
      },
    },
    {
      scope: ["string.escape", "string.regexp"],
      style: {
        foreground: theme.syntaxCharacter,
      },
    },
    {
      scope: ["keyword.directive"],
      style: {
        foreground: theme.syntaxLanguage,
      },
    },
    {
      scope: ["macro"],
      style: style(theme, "syntaxMacro", {
        foreground: theme.syntaxMacro,
        italic: true,
      }),
    },
    {
      scope: ["macro.parameter"],
      style: {
        foreground: theme.syntaxMacroParam,
      },
    },
    {
      scope: ["punctuation", "punctuation.bracket"],
      style: {
        foreground: theme.syntaxPunctuation,
      },
    },
    {
      scope: ["punctuation.special"],
      style: {
        foreground: theme.syntaxOperator,
      },
    },
    {
      scope: ["keyword.modifier"],
      style: style(theme, "syntaxKeywordQualifier", {
        foreground: theme.syntaxKeywordQualifier,
        italic: true,
      }),
    },
    {
      scope: ["keyword.exception"],
      style: style(theme, "syntaxLanguage", {
        foreground: theme.syntaxLanguage,
        italic: true,
      }),
    },
    {
      scope: ["functor.parameter"],
      style: {
        foreground: theme.syntaxFunctorParam,
      },
    },
    {
      scope: ["functor.parameter.output"],
      style: {
        foreground: theme.syntaxFunctorOutput,
      },
    },
    {
      scope: ["functor"],
      style: {
        foreground: theme.syntaxFunctor,
      },
    },
    {
      scope: ["functor.member"],
      style: {
        foreground: theme.syntaxFunctorMember,
      },
    },
    {
      scope: ["functor.member.private"],
      style: {
        foreground: theme.syntaxFunctorMemberPrivate,
      },
    },
    {
      scope: ["function.member"],
      style: {
        foreground: theme.syntaxFunctionMember,
      },
    },
    {
      scope: ["function.global"],
      style: {
        foreground: theme.syntaxFunctionGlobal,
      },
    },
    {
      scope: ["concept"],
      style: {
        foreground: theme.syntaxConcept,
      },
    },
    {
      scope: ["global.static"],
      style: {
        foreground: theme.syntaxGlobalStatic,
      },
    },
    {
      scope: ["global"],
      style: {
        foreground: theme.syntaxGlobal,
      },
    },
    {
      scope: ["global.static.private"],
      style: {
        foreground: theme.syntaxGlobalStaticPrivate,
      },
    },
    ...malterlibRules(theme),
    // Markdown specific styles
    {
      scope: ["markup.heading"],
      style: style(theme, "markdownHeading", {
        foreground: theme.markdownHeading,
        bold: true,
      }),
    },
    {
      scope: ["markup.heading.1"],
      style: style(theme, "markdownHeading", {
        foreground: theme.markdownHeading,
        bold: true,
        underline: true,
      }),
    },
    {
      scope: ["markup.heading.2"],
      style: style(theme, "markdownHeading", {
        foreground: theme.markdownHeading,
        bold: true,
      }),
    },
    {
      scope: ["markup.heading.3"],
      style: style(theme, "markdownHeading", {
        foreground: theme.markdownHeading,
        bold: true,
      }),
    },
    {
      scope: ["markup.heading.4"],
      style: style(theme, "markdownHeading", {
        foreground: theme.markdownHeading,
        bold: true,
      }),
    },
    {
      scope: ["markup.heading.5"],
      style: style(theme, "markdownHeading", {
        foreground: theme.markdownHeading,
        bold: true,
      }),
    },
    {
      scope: ["markup.heading.6"],
      style: style(theme, "markdownHeading", {
        foreground: theme.markdownHeading,
        bold: true,
      }),
    },
    {
      scope: ["markup.bold", "markup.strong"],
      style: style(theme, "markdownStrong", {
        foreground: theme.markdownStrong,
        bold: true,
      }),
    },
    {
      scope: ["markup.italic"],
      style: style(theme, "markdownEmph", {
        foreground: theme.markdownEmph,
        italic: true,
      }),
    },
    {
      scope: ["markup.list"],
      style: {
        foreground: theme.markdownListItem,
      },
    },
    {
      scope: ["markup.quote"],
      style: style(theme, "markdownBlockQuote", {
        foreground: theme.markdownBlockQuote,
        italic: true,
      }),
    },
    {
      scope: ["markup.raw", "markup.raw.block"],
      style: {
        foreground: theme.markdownCode,
      },
    },
    {
      scope: ["markup.raw.inline"],
      style: {
        foreground: theme.markdownCode,
        background: theme.background,
      },
    },
    {
      scope: ["markup.link"],
      style: {
        foreground: theme.markdownLink,
        underline: true,
      },
    },
    {
      scope: ["markup.link.label"],
      style: {
        foreground: theme.markdownLinkText,
        underline: true,
      },
    },
    {
      scope: ["markup.link.url"],
      style: {
        foreground: theme.markdownLink,
        underline: true,
      },
    },
    {
      scope: ["label"],
      style: {
        foreground: theme.markdownLinkText,
      },
    },
    {
      scope: ["spell", "nospell"],
      style: {
        foreground: theme.text,
      },
    },
    {
      scope: ["conceal"],
      style: {
        foreground: theme.textMuted,
      },
    },
    // Additional common highlight groups
    {
      scope: ["string.special", "string.special.url"],
      style: {
        foreground: theme.markdownLink,
        underline: true,
      },
    },
    {
      scope: ["character"],
      style: {
        foreground: theme.syntaxCharacter,
      },
    },
    {
      scope: ["float"],
      style: {
        foreground: theme.syntaxNumber,
      },
    },
    {
      scope: ["comment.error"],
      style: style(theme, "error", {
        foreground: theme.error,
        italic: true,
        bold: true,
      }),
    },
    {
      scope: ["comment.warning"],
      style: style(theme, "warning", {
        foreground: theme.warning,
        italic: true,
        bold: true,
      }),
    },
    {
      scope: ["comment.todo", "comment.note"],
      style: style(theme, "info", {
        foreground: theme.info,
        italic: true,
        bold: true,
      }),
    },
    {
      scope: ["namespace"],
      style: {
        foreground: theme.syntaxNamespace,
      },
    },
    {
      scope: ["field"],
      style: {
        foreground: theme.syntaxMember,
      },
    },
    {
      scope: ["type.definition"],
      style: style(theme, "syntaxType", {
        foreground: theme.syntaxType,
        bold: true,
      }),
    },
    {
      scope: ["keyword.export"],
      style: {
        foreground: theme.syntaxLanguage,
      },
    },
    {
      scope: ["attribute", "annotation"],
      style: {
        foreground: theme.syntaxKeywordAccess,
      },
    },
    {
      scope: ["tag"],
      style: {
        foreground: theme.primary,
      },
    },
    {
      scope: ["tag.attribute"],
      style: {
        foreground: theme.syntaxMember,
      },
    },
    {
      scope: ["tag.delimiter"],
      style: {
        foreground: theme.syntaxPunctuation,
      },
    },
    {
      scope: ["markup.strikethrough"],
      style: {
        foreground: theme.textMuted,
      },
    },
    {
      scope: ["markup.underline"],
      style: {
        foreground: theme.text,
        underline: true,
      },
    },
    {
      scope: ["markup.list.checked"],
      style: {
        foreground: theme.success,
      },
    },
    {
      scope: ["markup.list.unchecked"],
      style: {
        foreground: theme.textMuted,
      },
    },
    {
      scope: ["diff.plus"],
      style: {
        foreground: theme.diffAdded,
        background: theme.diffAddedBg,
      },
    },
    {
      scope: ["diff.minus"],
      style: {
        foreground: theme.diffRemoved,
        background: theme.diffRemovedBg,
      },
    },
    {
      scope: ["diff.delta"],
      style: {
        foreground: theme.diffContext,
        background: theme.diffContextBg,
      },
    },
    {
      scope: ["error"],
      style: style(theme, "error", {
        foreground: theme.error,
        bold: true,
      }),
    },
    {
      scope: ["warning"],
      style: style(theme, "warning", {
        foreground: theme.warning,
        bold: true,
      }),
    },
    {
      scope: ["info"],
      style: {
        foreground: theme.info,
      },
    },
    {
      scope: ["debug"],
      style: {
        foreground: theme.textMuted,
      },
    },
  ]
}
