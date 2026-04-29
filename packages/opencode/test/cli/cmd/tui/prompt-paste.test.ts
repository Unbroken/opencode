import { describe, expect, test } from "bun:test"
import type { PromptInfo } from "../../../../src/cli/cmd/tui/component/prompt/history"
import {
  pastePromptPlaceholder,
  pastePreviewMarkerRanges,
  pastePreviewText,
  refreshPastePreviews,
} from "../../../../src/cli/cmd/tui/component/prompt/paste"

describe("prompt paste", () => {
  test("pastePreviewText keeps short pasted content intact", () => {
    expect(pastePreviewText("one\ntwo\nthree")).toBe("one\ntwo\nthree")
  })

  test("pastePromptPlaceholder only summarizes pastes over three lines", () => {
    expect(pastePromptPlaceholder("one\ntwo\nthree")).toBeUndefined()
    expect(pastePromptPlaceholder("one\ntwo\nthree\nfour")).toBe("[Pasted ~4 lines]")
  })

  test("pastePreviewText truncates very long preview lines", () => {
    expect(pastePreviewText("a".repeat(200))).toBe(`${"a".repeat(190)} [10 additional pasted characters]`)
  })

  test("pastePreviewText shows first lines and additional count", () => {
    expect(pastePreviewText("one\ntwo\nthree\nfour\nfive\nsix\nseven")).toBe(
      "one\ntwo\nthree\n[4 additional pasted lines]",
    )
  })

  test("pastePreviewMarkerRanges only selects generated bracket markers", () => {
    const text = "one [not a marker]\ntwo\n[3 additional pasted lines]"

    expect(pastePreviewMarkerRanges(text)).toEqual([
      {
        start: 23,
        end: 50,
      },
    ])
  })

  test("refreshPastePreviews expands old one-line paste placeholders", () => {
    const prompt: PromptInfo = {
      input: "before [Pasted ~1 lines] after",
      parts: [
        {
          type: "text",
          text: "a".repeat(200),
          source: {
            text: {
              start: 7,
              end: 24,
              value: "[Pasted ~1 lines]",
            },
          },
        },
      ],
    }

    const refreshed = refreshPastePreviews(prompt)

    expect(refreshed.input).toBe(`before ${"a".repeat(190)} [10 additional pasted characters] after`)
    expect(refreshed.parts[0]?.type === "text" ? refreshed.parts[0].source?.text.value : undefined).toBe(
      `${"a".repeat(190)} [10 additional pasted characters]`,
    )
  })

  test("refreshPastePreviews preserves non-paste text placeholders", () => {
    const prompt: PromptInfo = {
      input: "[SVG: icon.svg]",
      parts: [
        {
          type: "text",
          text: "<svg><path/></svg>",
          source: {
            text: {
              start: 0,
              end: 15,
              value: "[SVG: icon.svg]",
            },
          },
        },
      ],
    }

    const refreshed = refreshPastePreviews(prompt)

    expect(refreshed.input).toBe("[SVG: icon.svg]")
    expect(refreshed.parts[0]?.type === "text" ? refreshed.parts[0].source?.text.value : undefined).toBe(
      "[SVG: icon.svg]",
    )
  })

  test("refreshPastePreviews drops malformed part entries", () => {
    expect(refreshPastePreviews({ input: "", parts: [null] } as unknown as PromptInfo)).toEqual({
      input: "",
      parts: [],
    })
  })

  test("refreshPastePreviews shifts following part ranges", () => {
    const prompt: PromptInfo = {
      input: "[Pasted ~6 lines] @agent",
      parts: [
        {
          type: "text",
          text: "one\ntwo\nthree\nfour\nfive\nsix",
          source: {
            text: {
              start: 0,
              end: 17,
              value: "[Pasted ~6 lines]",
            },
          },
        },
        {
          type: "agent",
          name: "agent",
          source: {
            start: 18,
            end: 24,
            value: "@agent",
          },
        },
      ],
    }

    const refreshed = refreshPastePreviews(prompt)

    expect(refreshed.input).toBe("one\ntwo\nthree\n[3 additional pasted lines] @agent")
    expect(refreshed.parts[1]?.type === "agent" ? refreshed.parts[1].source?.start : undefined).toBe(42)
    expect(refreshed.parts[1]?.type === "agent" ? refreshed.parts[1].source?.end : undefined).toBe(48)
  })
})
