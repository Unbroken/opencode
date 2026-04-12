import { expect, test } from "bun:test"
import malterlibCppHighlightPath from "../../../src/cli/cmd/tui/query/malterlib-cpp.scm" with { type: "file" }

import { malterlibCppHighlight, malterlibCppHighlightSource } from "../../../src/cli/cmd/tui/query/malterlib-cpp"

test("malterlib cpp overlay splits CF function and type prefixes", () => {
  expect(malterlibCppHighlight).toContain('(#match? @malterlib.function "^CF[A-Z0-9].*$")')
  expect(malterlibCppHighlight).toContain('(#not-match? @malterlib.function "^CF[A-Z0-9].*Ref$")')
  expect(malterlibCppHighlight).toContain('(#match? @malterlib.type "^CF[A-Z0-9].*Ref$")')
})

test("malterlib cpp overlay excludes narrower prefixes from broad matches", () => {
  expect(malterlibCppHighlight).toContain('(#match? @malterlib.variable "^(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")')
  expect(malterlibCppHighlight).toContain('(#not-match? @malterlib.variable "^C[A-Z0-9].*$")')
  expect(malterlibCppHighlight).toContain(
    '(#not-match? @malterlib.function.parameter.pack "^p_o(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")',
  )
})

test("malterlib cpp overlay includes exact-name rules", () => {
  expect(malterlibCppHighlight).toContain('(#eq? @malterlib.function "allocate_shared")')
  expect(malterlibCppHighlight).toContain('(#eq? @malterlib.member.function.public "assign")')
  expect(malterlibCppHighlight).toContain('(#eq? @malterlib.keyword.builtin.integer.types "size_t")')
})

test("malterlib cpp overlay includes special token rules", () => {
  expect(malterlibCppHighlight).toContain('"[[" @malterlib.keyword.property.modifiers.brackets')
  expect(malterlibCppHighlight).toContain('"]]" @malterlib.keyword.property.modifiers.brackets')
  expect(malterlibCppHighlight).toContain("(auto) @malterlib.keyword.auto")
  expect(malterlibCppHighlight).toContain("(this) @malterlib.keyword.this")
  expect(malterlibCppHighlight).toContain('"inline" @malterlib.keyword.property.modifiers')
  expect(malterlibCppHighlight).toContain('"static" @malterlib.keyword.storage.class')
  expect(malterlibCppHighlight).toContain('"private" @malterlib.keyword.access')
  expect(malterlibCppHighlight).toContain('"public" @malterlib.keyword.access')
  expect(malterlibCppHighlight).toContain('"template" @malterlib.keyword.template')
  expect(malterlibCppHighlight).toContain('"namespace" @malterlib.keyword.namespace')
  expect(malterlibCppHighlight).toContain('"#if" @malterlib.preprocessor.directive')
  expect(malterlibCppHighlight).toContain("value: (preproc_arg) @malterlib.macro.parameter")
  expect(malterlibCppHighlight).toContain('"&"\n    "&&"\n  ] @malterlib.operator.reference')
})

test("malterlib cpp overlay exports a local scm path", async () => {
  expect(malterlibCppHighlightPath.endsWith("malterlib-cpp.scm")).toBe(true)
  expect(await Bun.file(malterlibCppHighlightPath).exists()).toBe(true)
  expect(await Bun.file(malterlibCppHighlightPath).text()).toBe(malterlibCppHighlight)
  expect(malterlibCppHighlightSource.endsWith("malterlib-cpp.ts")).toBe(true)
})
