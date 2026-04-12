import { fileURLToPath } from "node:url"
import { exact, special } from "./malterlib-cpp-exact"

const upper = "[A-Z0-9]"
const lead = "(?:[A-Z0-9]|[binpfro][A-Z0-9])"

const id = ["identifier", "field_identifier"]
const type = ["identifier", "type_identifier", "namespace_identifier"]
const wide = ["identifier", "field_identifier", "type_identifier", "namespace_identifier"]

function cap(scope: string) {
  return scope.replaceAll("-", ".")
}

const map = {
  "malterlib-variable": cap("malterlib-variable"),
  "malterlib-type": cap("malterlib-type"),
  "malterlib-function": cap("malterlib-function"),
  "malterlib-type-function": cap("malterlib-type-function"),
  "malterlib-type-interface": cap("malterlib-type-interface"),
  "malterlib-namespace": cap("malterlib-namespace"),
  "malterlib-template-type": cap("malterlib-template-type"),
  "malterlib-template-type-interface": cap("malterlib-template-type-interface"),
  "malterlib-function-parameter": cap("malterlib-function-parameter"),
  "malterlib-function-parameter-functor": cap("malterlib-function-parameter-functor"),
  "malterlib-function-parameter-output": cap("malterlib-function-parameter-output"),
  "malterlib-function-parameter-output-functor": cap("malterlib-function-parameter-output-functor"),
  "malterlib-concept": cap("malterlib-concept"),
  "malterlib-constant-variable": cap("malterlib-constant-variable"),
  "malterlib-macro": cap("malterlib-macro"),
  "malterlib-macro-parameter": cap("malterlib-macro-parameter"),
  "malterlib-variable-functor": cap("malterlib-variable-functor"),
  "malterlib-member-function-public": cap("malterlib-member-function-public"),
  "malterlib-member-function-public-recursive": cap("malterlib-member-function-public-recursive"),
  "malterlib-member-function-private": cap("malterlib-member-function-private"),
  "malterlib-member-function-private-recursive": cap("malterlib-member-function-private-recursive"),
  "malterlib-member-static-function-public": cap("malterlib-member-static-function-public"),
  "malterlib-member-static-function-public-recursive": cap("malterlib-member-static-function-public-recursive"),
  "malterlib-member-static-function-private": cap("malterlib-member-static-function-private"),
  "malterlib-member-static-function-private-recursive": cap("malterlib-member-static-function-private-recursive"),
  "malterlib-static-function": cap("malterlib-static-function"),
  "malterlib-static-function-recursive": cap("malterlib-static-function-recursive"),
  "malterlib-function-recursive": cap("malterlib-function-recursive"),
  "malterlib-global-variable": cap("malterlib-global-variable"),
  "malterlib-global-variable-functor": cap("malterlib-global-variable-functor"),
  "malterlib-global-constant": cap("malterlib-global-constant"),
  "malterlib-global-static-variable": cap("malterlib-global-static-variable"),
  "malterlib-global-static-variable-functor": cap("malterlib-global-static-variable-functor"),
  "malterlib-enum": cap("malterlib-enum"),
  "malterlib-enumerator": cap("malterlib-enumerator"),
  "malterlib-member-variable-public": cap("malterlib-member-variable-public"),
  "malterlib-member-variable-public-functor": cap("malterlib-member-variable-public-functor"),
  "malterlib-member-constant-public": cap("malterlib-member-constant-public"),
  "malterlib-member-constant-private": cap("malterlib-member-constant-private"),
  "malterlib-member-variable-private": cap("malterlib-member-variable-private"),
  "malterlib-member-variable-private-functor": cap("malterlib-member-variable-private-functor"),
  "malterlib-member-static-variable-public": cap("malterlib-member-static-variable-public"),
  "malterlib-member-static-variable-public-functor": cap("malterlib-member-static-variable-public-functor"),
  "malterlib-member-static-variable-private": cap("malterlib-member-static-variable-private"),
  "malterlib-member-static-variable-private-functor": cap("malterlib-member-static-variable-private-functor"),
  "malterlib-function-parameter-pack": cap("malterlib-function-parameter-pack"),
  "malterlib-function-parameter-pack-functor": cap("malterlib-function-parameter-pack-functor"),
  "malterlib-function-parameter-output-pack": cap("malterlib-function-parameter-output-pack"),
  "malterlib-function-parameter-output-pack-functor": cap("malterlib-function-parameter-output-pack-functor"),
  "malterlib-static-variable": cap("malterlib-static-variable"),
  "malterlib-static-variable-functor": cap("malterlib-static-variable-functor"),
  "malterlib-template-non-type-param": cap("malterlib-template-non-type-param"),
  "malterlib-template-type-param-class": cap("malterlib-template-type-param-class"),
  "malterlib-template-type-param-function": cap("malterlib-template-type-param-function"),
  "malterlib-template-template-param": cap("malterlib-template-template-param"),
  "malterlib-function-template-non-type-param": cap("malterlib-function-template-non-type-param"),
  "malterlib-function-template-type-param-class": cap("malterlib-function-template-type-param-class"),
  "malterlib-function-template-type-param-function": cap("malterlib-function-template-type-param-function"),
  "malterlib-function-template-template-param": cap("malterlib-function-template-template-param"),
  "malterlib-function-template-non-type-param-pack": cap("malterlib-function-template-non-type-param-pack"),
  "malterlib-function-template-type-param-class-pack": cap("malterlib-function-template-type-param-class-pack"),
  "malterlib-function-template-type-param-function-pack": cap("malterlib-function-template-type-param-function-pack"),
  "malterlib-function-template-template-param-pack": cap("malterlib-function-template-template-param-pack"),
  "malterlib-template-non-type-param-pack": cap("malterlib-template-non-type-param-pack"),
  "malterlib-template-type-param-class-pack": cap("malterlib-template-type-param-class-pack"),
  "malterlib-template-type-param-function-pack": cap("malterlib-template-type-param-function-pack"),
  "malterlib-template-template-param-pack": cap("malterlib-template-template-param-pack"),
} as const

const typed = new Set([
  map["malterlib-type"],
  map["malterlib-type-function"],
  map["malterlib-type-interface"],
  map["malterlib-namespace"],
  map["malterlib-template-type"],
  map["malterlib-template-type-interface"],
  map["malterlib-template-type-param-class"],
  map["malterlib-template-type-param-function"],
  map["malterlib-template-template-param"],
  map["malterlib-function-template-type-param-class"],
  map["malterlib-function-template-type-param-function"],
  map["malterlib-function-template-template-param"],
  map["malterlib-function-template-type-param-class-pack"],
  map["malterlib-function-template-type-param-function-pack"],
  map["malterlib-function-template-template-param-pack"],
  map["malterlib-template-type-param-class-pack"],
  map["malterlib-template-type-param-function-pack"],
  map["malterlib-template-template-param-pack"],
  map["malterlib-enum"],
])

const raw = [
  { pre: "CF", cap: map["malterlib-type"], re: "^CF(?:Str|UStr|WStr)$" },
  { pre: "CF", cap: map["malterlib-type"], re: "^CF[A-Z0-9].*Ref$" },
  { pre: "CFWStr", cap: map["malterlib-type"] },
  { pre: "CFUStr", cap: map["malterlib-type"] },
  { pre: "CFStr", cap: map["malterlib-type"] },
  { pre: "msp_f", cap: map["malterlib-member-static-variable-private-functor"] },
  { pre: "msp_", cap: map["malterlib-member-static-variable-private"], variable: true },
  { pre: "mcp_", cap: map["malterlib-member-constant-private"], variable: true },
  { pre: "ms_f", cap: map["malterlib-member-static-variable-public-functor"] },
  { pre: "ms_", cap: map["malterlib-member-static-variable-public"], variable: true },
  { pre: "mp_f", cap: map["malterlib-member-variable-private-functor"] },
  { pre: "mp_", cap: map["malterlib-member-variable-private"], variable: true },
  { pre: "mc_", cap: map["malterlib-member-constant-public"], variable: true },
  { pre: "m_f", cap: map["malterlib-member-variable-public-functor"] },
  { pre: "m_", cap: map["malterlib-member-variable-public"], variable: true },
  { pre: "gs_f", cap: map["malterlib-global-static-variable-functor"] },
  { pre: "gs_", cap: map["malterlib-global-static-variable"], variable: true },
  { pre: "gc_", cap: map["malterlib-global-constant"], variable: true },
  { pre: "g_f", cap: map["malterlib-global-variable-functor"] },
  { pre: "g_", cap: map["malterlib-global-variable"], variable: true },
  { pre: "fspr_", cap: map["malterlib-member-static-function-private-recursive"] },
  { pre: "fsp_r", cap: map["malterlib-member-static-function-private-recursive"] },
  { pre: "fsp_", cap: map["malterlib-member-static-function-private"] },
  { pre: "fsgr_", cap: map["malterlib-static-function-recursive"] },
  { pre: "fsg_r", cap: map["malterlib-static-function-recursive"] },
  { pre: "fsg_", cap: map["malterlib-static-function"] },
  { pre: "fsr_", cap: map["malterlib-member-static-function-public-recursive"] },
  { pre: "fs_r", cap: map["malterlib-member-static-function-public-recursive"] },
  { pre: "fs_", cap: map["malterlib-member-static-function-public"] },
  { pre: "fpr_", cap: map["malterlib-member-function-private-recursive"] },
  { pre: "fp_r", cap: map["malterlib-member-function-private-recursive"] },
  { pre: "fp_", cap: map["malterlib-member-function-private"] },
  { pre: "fgr_", cap: map["malterlib-function-recursive"] },
  { pre: "fg_r", cap: map["malterlib-function-recursive"] },
  { pre: "fg_", cap: map["malterlib-function"] },
  { pre: "fr_", cap: map["malterlib-member-function-public-recursive"] },
  { pre: "f_r", cap: map["malterlib-member-function-public-recursive"] },
  { pre: "f_", cap: map["malterlib-member-function-public"] },
  { pre: "fl_", cap: map["malterlib-variable-functor"] },
  { pre: "po_f", cap: map["malterlib-function-parameter-output-pack-functor"] },
  { pre: "po_", cap: map["malterlib-function-parameter-output-pack"], variable: true },
  { pre: "p_of", cap: map["malterlib-function-parameter-output-pack-functor"] },
  { pre: "p_o", cap: map["malterlib-function-parameter-output-pack"], variable: true },
  { pre: "p_f", cap: map["malterlib-function-parameter-pack-functor"] },
  { pre: "p_", cap: map["malterlib-function-parameter-pack"], variable: true },
  { pre: "o_f", cap: map["malterlib-function-parameter-output-functor"] },
  { pre: "o_", cap: map["malterlib-function-parameter-output"], variable: true },
  { pre: "_of", cap: map["malterlib-function-parameter-output-functor"] },
  { pre: "_o", cap: map["malterlib-function-parameter-output"], variable: true },
  { pre: "_f", cap: map["malterlib-function-parameter-functor"] },
  { pre: "_", cap: map["malterlib-function-parameter"], variable: true },
  { pre: "tfp_TC", cap: map["malterlib-function-template-template-param-pack"] },
  { pre: "tfp_TF", cap: map["malterlib-function-template-template-param-pack"] },
  { pre: "tfp_C", cap: map["malterlib-function-template-type-param-class-pack"] },
  { pre: "tfp_F", cap: map["malterlib-function-template-type-param-function-pack"] },
  { pre: "tfp_", cap: map["malterlib-function-template-non-type-param-pack"], variable: true },
  { pre: "tf_TC", cap: map["malterlib-function-template-template-param"] },
  { pre: "tf_TF", cap: map["malterlib-function-template-template-param"] },
  { pre: "tf_C", cap: map["malterlib-function-template-type-param-class"] },
  { pre: "tf_F", cap: map["malterlib-function-template-type-param-function"] },
  { pre: "tf_", cap: map["malterlib-function-template-non-type-param"], variable: true },
  { pre: "tp_TC", cap: map["malterlib-template-template-param-pack"] },
  { pre: "tp_TF", cap: map["malterlib-template-template-param-pack"] },
  { pre: "tp_C", cap: map["malterlib-template-type-param-class-pack"] },
  { pre: "tp_F", cap: map["malterlib-template-type-param-function-pack"] },
  { pre: "tp_", cap: map["malterlib-template-non-type-param-pack"], variable: true },
  { pre: "t_TC", cap: map["malterlib-template-template-param"] },
  { pre: "t_TF", cap: map["malterlib-template-template-param"] },
  { pre: "t_C", cap: map["malterlib-template-type-param-class"] },
  { pre: "t_F", cap: map["malterlib-template-type-param-function"] },
  { pre: "t_", cap: map["malterlib-template-non-type-param"], variable: true },
  { pre: "TIC", cap: map["malterlib-template-type-interface"] },
  { pre: "TF", cap: map["malterlib-template-type"] },
  { pre: "TC", cap: map["malterlib-template-type"] },
  { pre: "UI", cap: map["malterlib-type"] },
  { pre: "NS", cap: map["malterlib-type"] },
  { pre: "IC", cap: map["malterlib-type-interface"] },
  { pre: "CF", cap: map["malterlib-function"], no: ["^CF[A-Z0-9].*Ref$", "^CF(?:Str|UStr|WStr)$"] },
  { pre: "C", cap: map["malterlib-type"] },
  { pre: "D", cap: map["malterlib-macro"] },
  { pre: "N", cap: map["malterlib-namespace"] },
  { pre: "F", cap: map["malterlib-type-function"] },
  { pre: "E", cap: map["malterlib-enum"], re: "^E[A-Z0-9][^_]*$" },
  { pre: "E", cap: map["malterlib-enumerator"], re: "^E[A-Z0-9].*_.*$" },
  { pre: "k", cap: map["malterlib-enumerator"] },
  { pre: "c_", cap: map["malterlib-constant-variable"], variable: true },
  { pre: "c", cap: map["malterlib-concept"] },
  { pre: "d_", cap: map["malterlib-macro-parameter"], variable: true },
  { pre: "s_f", cap: map["malterlib-static-variable-functor"] },
  { pre: "s_", cap: map["malterlib-static-variable"], variable: true },
  { pre: "f", cap: map["malterlib-variable-functor"] },
  { pre: "", cap: map["malterlib-variable"], variable: true },
]

function esc(text: string) {
  return text.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")
}

function match(pre: string, variable?: boolean) {
  return `^${esc(pre)}${variable ? lead : upper}.*$`
}

function list(items: string[]) {
  return `[
${items.map((item) => `  (${item})`).join("\n")}
]`
}

function line(item: (typeof raw)[number]) {
  const yes = item.re ?? match(item.pre, item.variable)
  const no = new Set(
    raw
      .filter((next) => next.pre && next.pre.startsWith(item.pre) && next.pre !== item.pre)
      .map((next) => next.re ?? match(next.pre, next.variable))
      .concat(item.no ?? []),
  )

  return `(${list(typed.has(item.cap) ? type : id)} @${item.cap}
  (#match? @${item.cap} "${yes}")${[...no].map((value) => `\n  (#not-match? @${item.cap} "${value}")`).join("")}
)`
}

function exactLine(scope: keyof typeof exact, value: string) {
  const cap = scope.replaceAll("-", ".")
  return `(${list(wide)} @${cap}
  (#eq? @${cap} "${value}")
)`
}

function specialLine(value: keyof typeof special) {
  const item = special[value]
  const cap = item.cap.replaceAll("-", ".")
  return `${item.raw} @${cap}`
}

const preprocRules = [
  `(preproc_function_def
  value: (preproc_arg) @malterlib.macro.parameter
  (#match? @malterlib.macro.parameter "^(?:\\\\\\r?\\n[ \\t]*)?d_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
)`,
]

const operatorRules = [
  `(reference_declarator
  [
    "&"
    "&&"
  ] @malterlib.operator.reference)`,
  `(abstract_reference_declarator
  [
    "&"
    "&&"
  ] @malterlib.operator.reference)`,
]

const rules = raw.toSorted((a, b) => b.pre.length - a.pre.length)
const exactRules = Object.entries(exact).flatMap(([scope, values]) =>
  values.map((value) => exactLine(scope as keyof typeof exact, value)),
)
const specialRules = Object.keys(special).map((value) => specialLine(value as keyof typeof special))

export const malterlibCppHighlight = [
  "; Malterlib naming overlay for tree-sitter-cpp",
  "; Keep the stock cpp query first, then refine identifier classes here.",
  ...rules.map(line),
  "; Recolor reference punctuation that upstream parameter captures mark as parameter text.",
  ...operatorRules,
  "; Best-effort preprocessor body matches for bare macro parameters.",
  ...preprocRules,
  "; Static exact-name overrides from the Malterlib identifier table.",
  ...exactRules,
  "; Static token overrides from the Malterlib identifier table.",
  ...specialRules,
].join("\n\n")
export const malterlibCppHighlightSource = fileURLToPath(import.meta.url)
