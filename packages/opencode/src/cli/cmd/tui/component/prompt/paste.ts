import type { PromptInfo } from "./history"

export const PASTE_PREVIEW_LINE_LIMIT = 3
export const PASTE_PREVIEW_LINE_CHAR_LIMIT = 190
export const PASTE_PROMPT_LINE_LIMIT = 3
type PromptPart = PromptInfo["parts"][number]
type SourceRange = { start: number; end: number }
type RangedPart = { part: PromptPart; index: number; range: SourceRange }
const PASTE_PREVIEW_MARKER_PATTERN = /\[\d+ additional pasted (?:characters|lines)\]/g

function pastePreviewLine(line: string) {
  if (line.length <= PASTE_PREVIEW_LINE_CHAR_LIMIT) return line
  return `${line.slice(0, PASTE_PREVIEW_LINE_CHAR_LIMIT)} [${line.length - PASTE_PREVIEW_LINE_CHAR_LIMIT} additional pasted characters]`
}

function isPromptPart(value: unknown): value is PromptPart {
  if (typeof value !== "object" || value === null) return false
  const part = value as { type?: unknown; text?: unknown }
  if (part.type === "text") return typeof part.text === "string"
  return part.type === "file" || part.type === "agent"
}

export function pastePreviewText(text: string) {
  const lines = text.split("\n")
  const previewLines = lines.slice(0, PASTE_PREVIEW_LINE_LIMIT).map(pastePreviewLine)
  if (lines.length <= PASTE_PREVIEW_LINE_LIMIT && previewLines.every((line, index) => line === lines[index])) return text
  return [
    ...previewLines,
    ...(lines.length > PASTE_PREVIEW_LINE_LIMIT ? [`[${lines.length - PASTE_PREVIEW_LINE_LIMIT} additional pasted lines]`] : []),
  ].join("\n")
}

export function pastePromptPlaceholder(text: string) {
  const lines = text.split("\n")
  if (lines.length <= PASTE_PROMPT_LINE_LIMIT) return
  return `[Pasted ~${lines.length} lines]`
}

export function pastePreviewMarkerRanges(text: string, offset = 0) {
  return [...text.matchAll(PASTE_PREVIEW_MARKER_PATTERN)].map((match) => ({
    start: offset + match.index,
    end: offset + match.index + match[0].length,
  }))
}

function isOldPasteSummary(value: string) {
  return /^\[Pasted ~\d+ lines\]$/.test(value)
}

function range(part: PromptPart): SourceRange | undefined {
  if (part.type === "agent" && part.source) return { start: part.source.start, end: part.source.end }
  if ((part.type === "file" || part.type === "text") && part.source?.text) {
    return { start: part.source.text.start, end: part.source.text.end }
  }
}

function hasRange(item: { part: PromptPart; index: number; range: SourceRange | undefined }): item is RangedPart {
  return item.range !== undefined
}

function updateRange(part: PromptPart, start: number, end: number, value?: string): PromptPart {
  if (part.type === "agent") {
    if (!part.source) return part
    return {
      ...part,
      source: {
        ...part.source,
        start,
        end,
      },
    }
  }
  if (part.type === "file") {
    if (!part.source?.text) return part
    return {
      ...part,
      source: {
        ...part.source,
        text: {
          ...part.source.text,
          start,
          end,
          value: value ?? part.source.text.value,
        },
      },
    }
  }
  if (part.type === "text") {
    if (!part.source?.text) return part
    return {
      ...part,
      source: {
        text: {
          ...part.source.text,
          start,
          end,
          value: value ?? part.source.text.value,
        },
      },
    }
  }
  return part
}

export function refreshPastePreviews(prompt: PromptInfo): PromptInfo {
  let input = prompt.input
  let offset = 0
  const sourceParts = Array.isArray(prompt.parts) ? prompt.parts : []
  const promptParts = sourceParts.filter(isPromptPart)
  let changed = promptParts.length !== sourceParts.length
  const parts = [...promptParts]

  promptParts
    .map((part, index) => ({ part, index, range: range(part) }))
    .filter(hasRange)
    .sort((a, b) => a.range.start - b.range.start)
    .forEach((item) => {
      const start = item.range.start + offset
      const end = item.range.end + offset

      if (item.part.type !== "text" || !item.part.source?.text || !isOldPasteSummary(item.part.source.text.value)) {
        parts[item.index] = updateRange(item.part, start, end)
        if (offset !== 0) changed = true
        return
      }

      const value = pastePreviewText(item.part.text)
      input = input.slice(0, start) + value + input.slice(end)
      parts[item.index] = updateRange(item.part, start, start + value.length, value)
      offset += value.length - (end - start)
      changed = changed || value !== item.part.source.text.value || offset !== 0
    })

  if (!changed) return prompt
  return {
    ...prompt,
    input,
    parts,
  }
}
