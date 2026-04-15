- To regenerate the JavaScript SDK, run `./packages/sdk/js/script/build.ts`.
- The default branch in this repo is `dev`.
- Local `main` ref may not exist; use `dev` or `origin/dev` for diffs.

## Commits and PR Titles

Use conventional commit-style messages and PR titles: `type(scope): summary`.

Valid types are `feat`, `fix`, `docs`, `chore`, `refactor`, and `test`. Scopes are optional; use the affected package or area when helpful, e.g. `core`, `opencode`, `tui`, `app`, `desktop`, `sdk`, or `plugin`.

Examples: `fix(tui): simplify thinking toggle styling`, `docs: update contributing guide`, `chore(sdk): regenerate types`.

## Style Guide

### General Principles

- Keep things in one function unless composable or reusable
- Do not extract single-use helpers preemptively. Inline the logic at the call site unless the helper is reused, hides a genuinely complex boundary, or has a clear independent name that improves the caller.
- Avoid `try`/`catch` where possible
- Avoid using the `any` type
- Use Bun APIs when possible, like `Bun.file()`
- Rely on type inference when possible; avoid explicit type annotations or interfaces unless necessary for exports or clarity
- Prefer functional array methods (flatMap, filter, map) over for loops; use type guards on filter to maintain type inference downstream
- In `src/config`, follow the existing self-export pattern at the top of the file (for example `export * as ConfigAgent from "./agent"`) when adding a new config module.

Reduce total variable count by inlining when a value is only used once.

```ts
// Good
const journal = await Bun.file(path.join(dir, "journal.json")).json()

// Bad
const journalPath = path.join(dir, "journal.json")
const journal = await Bun.file(journalPath).json()
```

### Destructuring

Avoid unnecessary destructuring. Use dot notation to preserve context.

```ts
// Good
obj.a
obj.b

// Bad
const { a, b } = obj
```

### Variables

Prefer `const` over `let`. Use ternaries or early returns instead of reassignment.

```ts
// Good
const foo = condition ? 1 : 2

// Bad
let foo
if (condition) foo = 1
else foo = 2
```

### Control Flow

Avoid `else` statements. Prefer early returns.

```ts
// Good
function foo() {
  if (condition) return 1
  return 2
}

// Bad
function foo() {
  if (condition) return 1
  else return 2
}
```

### Complex Logic

When a function has several validation branches or supporting details, make the main function read as the happy path and move supporting details into small helpers below it.

```ts
// Good
export function loadThing(input: unknown) {
  const config = requireConfig(input)
  const metadata = readMetadata(input)
  return createThing({ config, metadata })
}

function requireConfig(input: unknown) {
  ...
}
```

- Keep helpers close to the code they support, below the main export when that improves readability.
- Do not over-abstract simple expressions into many single-use helpers; extract only when it names a real concept like `requireConfig` or `readMetadata`.
- Do not return `Effect` from helpers unless they actually perform effectful work. Synchronous parsing, validation, and option building should stay synchronous.
- Prefer Effect schema helpers such as `Schema.UnknownFromJsonString` and `Schema.decodeUnknownOption` over manual `JSON.parse` wrapped in `Effect.try` when parsing untrusted JSON strings.
- Add comments for non-obvious constraints and surprising behavior, not for obvious assignments or control flow.

### Schema Definitions (Drizzle)

Use snake_case for field names so column names don't need to be redefined as strings.

```ts
// Good
const table = sqliteTable("session", {
  id: text().primaryKey(),
  project_id: text().notNull(),
  created_at: integer().notNull(),
})

// Bad
const table = sqliteTable("session", {
  id: text("id").primaryKey(),
  projectID: text("project_id").notNull(),
  createdAt: integer("created_at").notNull(),
})
```

## Testing

- Avoid mocks as much as possible
- Test actual implementation, do not duplicate logic into tests
- Tests cannot run from repo root (guard: `do-not-run-tests-from-root`); run from package dirs like `packages/opencode`.

## Type Checking

- Always run `bun typecheck` from package directories (e.g., `packages/opencode`), never `tsc` directly.

## Code Review with Codex

Use the `codex` CLI to get a second-opinion review from a different model. Run it from the directory whose changes you want reviewed — `codex review` reads `git diff` relative to its working directory.

When instructing the codex agent don't try to steer it to specific sort of code review, let it use it's default instructions.

```bash
# Review unstaged + staged + untracked changes in the current directory
codex review --uncommitted

# Review changes against a base branch (e.g. before opening a PR)
codex review --base master

# Review a specific commit
codex review --commit <sha>

# Review with a custom prompt (no scope flag — codex picks the diff)
codex review "Review this commit."
```

**CRITICAL — waiting for codex results:**

**Use the harness's native backgrounding support if it exists. If the Bash tool exposes `run_in_background: true`, launch `codex review` that way, then immediately return control to the user and STOP. Do NOT issue ANY follow-up tool calls — no `wc`, no `ls`, no `cat`, no `Read`, no `ps`, no `Bash` of any kind. Do not check the output file size. Do not check if the process is running. Do not poll. Do not sleep. Do not "just quickly check". End your message and WAIT. The harness will deliver a background-task-completed notification automatically. Only then may you read the output and continue. Violating this wastes the user's time and context window.**

**If the Bash tool does not expose native backgrounding support, do not try to simulate it with shell backgrounding like `&`. Instead, run `codex review` in the foreground with a timeout large enough to let it finish (or no timeout if the harness allows that), redirect stdout/stderr to a log file, wait for the command result in the same turn, and only then analyze the output by reading the end of that log. In that mode there is no later completion notification to wait for because the command itself should return the finished review.**

Notes:
- **Prefer the harness's native background mode when available.** Codex reviews can take minutes for large diffs.
- **When native background mode is unavailable, run `codex review` in the foreground, redirect it to a log file, and increase or disable the timeout so the tool can wait for completion.** Do not append `&` or otherwise detach the process yourself.
- The scope flags `--uncommitted`, `--base`, and `--commit` are **mutually exclusive with the `[PROMPT]` argument**. Passing both fails with `error: the argument '--<flag>' cannot be used with '[PROMPT]'`. Use a scope flag with no prompt, or a prompt with no scope flag — never both.
- `codex review --uncommitted` includes staged + unstaged + untracked. There is no built-in way to scope to *just* unstaged; you'd have to stash the staged changes first, or accept that all three are reviewed.
- Run from inside the relevant sub-repo (e.g. `Malterlib/BuildSystem`) to scope the review and let codex resolve paths correctly.
- Codex output is noisy and large — easily 50–500 KB of exec traces before the actual findings. Prefer redirecting stdout/stderr to a log file (or using the harness's persisted output file when background mode provides one), then inspect only the end of that file to find the final findings block. Do not read the whole transcript unless you need extra context.
- Codex runs read-only and sandboxed — it will not modify files.
