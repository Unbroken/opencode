import * as vscode from "vscode"

export function file(): string | undefined {
  const editor = vscode.window.activeTextEditor
  if (!editor) return undefined

  const doc = editor.document
  if (!vscode.workspace.getWorkspaceFolder(doc.uri)) return undefined

  return `@${vscode.workspace.asRelativePath(doc.uri)}`
}

export function selection(): string | undefined {
  const editor = vscode.window.activeTextEditor
  if (!editor) return undefined

  const doc = editor.document
  if (!vscode.workspace.getWorkspaceFolder(doc.uri)) return undefined

  const text = `@${vscode.workspace.asRelativePath(doc.uri)}`
  if (editor.selection.isEmpty) return text

  const start = editor.selection.start.line + 1
  const end = editor.selection.end.line + 1
  if (start === end) return `${text}#L${start}`
  return `${text}#L${start}-${end}`
}
