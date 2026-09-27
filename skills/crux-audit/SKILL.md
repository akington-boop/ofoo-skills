---
name: crux-audit
description: Use when the user says "/crux-audit" or wants a full coding-convention review of generated or existing TS/TSX code against all fourteen rule docs (the four post-code-audit judgment rules plus the ten path-scoped/global mechanical rules). Also use when the user says "/crux-audit install" to wire this skill's bundled routing table into a project or global CLAUDE.md for inline, path-scoped enforcement. Audit mode is report-only and never edits code or extracts classes unprompted; install is the one action permitted to create or edit a CLAUDE.md/CLAUDE.local.md file.
argument-hint: "[full | <path> | install] (default: staged)"
---

# crux-audit

Audit code against all fourteen coding-convention rule docs: the four `post-code-audit`
rules that need judgment across a whole file/class (complexity, architecture, directory
structure, naming) plus the ten `path-scoped`/`global` rules that are normally enforced
inline while editing but are re-checked here in full for a comprehensive pass. Produce a
markdown report only — see **Output** for the no-edit rule.

## Rule source

All fourteen rules ship bundled in [references/](references/) alongside this file, so
this skill has no dependency on any path outside its own directory. Read them fresh on
every invocation:

- [references/complexity-and-refactoring.md](references/complexity-and-refactoring.md)
- [references/component-architecture.md](references/component-architecture.md)
- [references/directory-structure.md](references/directory-structure.md)
- [references/naming-conventions.md](references/naming-conventions.md)
- [references/async-patterns.md](references/async-patterns.md)
- [references/component-declarations.md](references/component-declarations.md)
- [references/guard-components.md](references/guard-components.md)
- [references/http-response-patterns.md](references/http-response-patterns.md)
- [references/language-idioms.md](references/language-idioms.md)
- [references/shared-code.md](references/shared-code.md)
- [references/state-observables-react.md](references/state-observables-react.md)
- [references/state-service-classes.md](references/state-service-classes.md)
- [references/string-checks.md](references/string-checks.md)
- [references/styling-strategy.md](references/styling-strategy.md)

[references/universal-baseline.md](references/universal-baseline.md) is an index/checklist
file with no enforceable rules of its own — skip it here. (It's bundled for a different
consumer: a project's own `CLAUDE.md` can use [references/INDEX.md](references/INDEX.md)
as a markdown-file router — reading `universal-baseline.md` plus whichever of the docs
above match the file being edited — so the same rule content backs both a full audit and
inline path-scoped enforcement, without duplicating it.)

## Inputs

`/crux-audit [target]` — `target` is optional, one of:

- *(absent)* — audit **staged changes** (`git diff --staged`), restricted to `*.ts`/`*.tsx`
  files. If nothing is staged, fall back to `git diff` (unstaged) and note that in the
  report. If neither has changes, report "no changes to audit" and stop before writing
  a report file.
- `full` — audit the full repository's `*.ts`/`*.tsx` files, excluding `node_modules`,
  test/spec files, and generated output.
- **`install`** — do not treat as a path. Runs the install flow in **Install** below
  instead of auditing anything.
- anything else — treat it as a path (relative or absolute). Search up to 10 levels
  deep from the current directory or from the root if an absolute path. Skip
  `node_modules`. If the path is not found, report the miss and stop.

For staged/unstaged mode, read the full current file content for each changed file
(not just diff lines), so whole-class judgments (single-responsibility, naming
consistency) can be evaluated with full context.

## Execution steps

1. Resolve the target per **Inputs** above.
2. Read all fourteen reference files in full.
3. Gather candidate `*.ts`/`*.tsx` files per the resolved target.
4. For each file, evaluate it against all fourteen rules:
   - **Complexity and refactoring** — flag single-responsibility violations, and methods
     whose cognitive complexity exceeds 15 or cyclomatic complexity exceeds 10. These are
     review triggers, not automatic extraction requirements.
   - **Component architecture** — flag business logic embedded in components instead of
     service classes, service constructors that resolve dependencies via a locator instead
     of taking them as typed parameters, and misuse of the documented patterns (factory,
     builder, context+hook, slot props).
   - **Directory structure** — flag loose `"paths": { "*": ["*"] }` wildcards, a Node
     server not isolated under `server/`, and files not grouped by type-suffix under
     `<Feature>/<TypeName>/`.
   - **Naming conventions** — flag bare generic type params (`T`, `U`, `K`), incorrect
     `*Service`/`*Store` naming, `Store.Instance` access outside composition roots,
     non-fluent builders, and `ObservableX` classes misnamed `*Fields`/`*State`.
   - **Async patterns** — flag `async` functions that mix `await` with a trailing
     `.then`/`.catch` chain, or a `.then`/`.catch` chain used where a later step depends
     on its result instead of `async`/`await`.
   - **Component declarations** — flag arrow-function components, `React.FC`, default
     exports, a missing/incorrect `JSX.Element` (or `JSX.Element | null`) return type, or
     `forwardRef` used without a named inner function.
   - **Guard components** — flag a guard component missing the `Guard` suffix, a fallback
     prop not named `Fallback`, JSX inlined directly in `Fallback` instead of an arrow
     returning a named function, or that named function not following
     `component-declarations.md`.
   - **HTTP response patterns** — flag manual unwrapping of a `ResultOf<T>.Data` field
     instead of `PostResult`/`GetResult`, a missing/incorrect catch for
     `InvalidResultStateError`, or an existing API's response envelope reshaped without
     being documented on its interface.
   - **Language idioms** — flag `Record<string, T | undefined>` where `Dictionary<T>`
     (`@webmdhs/general-data-structures`) applies.
   - **Shared code** — flag reimplementations of array/string/dictionary/loading-state
     helpers already provided by `@webmdhs/general-data-structures`,
     `@webmdhs/json-http-request`, or `@webmdhs/react-loading-component`.
   - **State — observables in React** — flag a component reading an `Observable`/
     `ObservableArray`/`ObservableObject` without `useObservable`, or a
     `useMemo`/`useCallback`/`React.memo` dependency relying on `ObservableArray`
     referential identity instead of `.length`, a derived primitive, or a manual deep
     check.
   - **State — service classes** — flag domain state (derived from or affecting domain
     data) kept in `React.useState` instead of a service class's `Observable`/
     `ObservableList`, or a `ValidatableField` not reachable from its class's
     `ValidatableFields`/`AllValidatableFields`.
   - **String checks** — flag manual non-empty string checks (`str != null && str.length
     > 0`, `!!str`, `str?.length > 0`, `str !== ""`, etc.) instead of `HasString`
     (`@webmdhs/general-data-structures`).
   - **Styling strategy** — flag styling that bypasses the `sx` prop /
     `SystemStyleObject<Theme>`, a theme sourced from vanilla MUI instead of
     `@webmdhs/mui-theme`, barrel imports of MUI components, non-`Rounded` icon variants,
     or conditional `className` composition not using `clsx`.
5. For any complexity-and-refactoring finding that would require extracting a class,
   propose the extraction (never perform it — see **Output**). Include: the sub-concern
   and its estimated complexity, the new class's interface and dependency-injection
   plan, and how testability improves without breaking the original class's private
   encapsulation.
6. Skip files with no findings silently in the violations section, but still count them
   as scanned.

## Install

`/crux-audit install` wires this skill's bundled routing table
([references/INDEX.md](references/INDEX.md)) into a `CLAUDE.md`-style router, so
day-to-day editing gets inline, path-scoped enforcement without invoking the full audit.
This is the one action in this skill permitted to create or edit a file other than a
report.

1. Resolve this skill's own installed directory — the directory containing this
   `SKILL.md` — call it `<skill-dir>`. The router points at `<skill-dir>/references/`.
2. Ask the user which single file to update:
   - **Global** — `~/.claude/CLAUDE.md`
   - **Current repository** — `<repo-root>/CLAUDE.md` (repo root via `git rev-parse
     --show-toplevel`, or the current directory if not a Git repo)
   - **CLAUDE.local.md** — `<repo-root>/CLAUDE.local.md`
3. If the chosen file doesn't exist, create it as part of the write in step 5/6.
4. Check the chosen file's existing content (if any) for a "prefer `rg` (ripgrep) over
   `grep`" style instruction. Install doesn't introduce this preference on its own — only
   act if the file already states one:
   - If found, check whether `rg` is actually installed (`command -v rg`).
   - If it's missing, ask the user to choose: install ripgrep now (suggest the
     OS-appropriate command — e.g. `brew install ripgrep`, `apt install ripgrep`,
     `dnf install ripgrep`, `winget install BurntSushi.ripgrep` — and run it only after
     explicit confirmation), or edit that instruction to fall back to `grep` instead so
     the file stops assuming a tool that isn't present.
   - If `rg` is already installed, leave the instruction as-is.
5. Read the chosen file (if it exists) and look for an existing coding-convention router
   section — any heading or paragraph telling the reader to consult a routing table /
   `INDEX.md` for path-scoped rule docs, regardless of exact wording or which skill it
   names (e.g. a personal setup pointed at a different `docs/INDEX.md`).
   - **Not found** → after confirming with the user, append:

     ```markdown
     ## Coding Convention Router (crux-audit)

     Before starting work on `**/*.{ts,tsx}`, read `<skill-dir>/references/INDEX.md`
     and follow its routing table to pick which `crux-audit` rule docs (same
     `references/` folder) apply.
     ```

   - **Found** → verify it's current instead of skipping blindly. Compare its
     referenced path and trigger list against this skill's actual
     `references/INDEX.md`:
     - Same resolved path, same triggers → report "router already up to date in
       `<file>`" and change nothing.
     - Different (stale trigger list, points at a renamed/different skill, points at a
       path that no longer exists, etc.) → report exactly what differs and ask the user
       whether to replace it, append a second section, or leave it. Never rewrite it
       without that confirmation.
6. Report which file(s) were created, appended to, replaced, or left alone, and why,
   plus what happened with the `rg` check from step 4 (if it applied).

## Report

Write a markdown file to the **current working directory root** named:

```
audit<shortdate-shorttime>.md
```

e.g. `audit0916-1430.md` (MMDD-HHMM, 24h clock, single dash as shown).

Report structure:

```markdown
# Coding Convention Audit — <human-readable timestamp>

**Target:** <staged changes | unstaged changes | full repo | path: <path>>
**Files scanned:** <n>
**Findings:** <n> total — <n> complexity, <n> architecture, <n> directory-structure,
<n> naming, <n> async-patterns, <n> component-declarations, <n> guard-components,
<n> http-response-patterns, <n> language-idioms, <n> shared-code,
<n> state-observables, <n> state-service-classes, <n> string-checks, <n> styling

## Complexity and Refactoring

### `path/to/file.ts:12` — <Class/method name>
**Issue:** <single-responsibility violation | cognitive/cyclomatic complexity score>
**Extraction proposal** (if applicable, pending approval — not yet applied):
- Sub-concern: …
- New class interface & DI plan: …
- Testability improvement: …

## Component Architecture

### `path/to/file.tsx:8`
**Issue:** <finding>

## Directory Structure

### `path/to/tsconfig.json`
**Issue:** <finding>

## Naming Conventions

### `path/to/file.ts:20`
**Issue:** <finding>

## Async Patterns

### `path/to/file.ts:14`
**Issue:** <finding>

## Component Declarations

### `path/to/file.tsx:5`
**Issue:** <finding>

## Guard Components

### `path/to/file.tsx:10`
**Issue:** <finding>

## HTTP Response Patterns

### `path/to/file.ts:22`
**Issue:** <finding>

## Language Idioms

### `path/to/file.ts:7`
**Issue:** <finding>

## Shared Code

### `path/to/file.ts:30`
**Issue:** <finding>

## State — Observables in React

### `path/to/file.tsx:18`
**Issue:** <finding>

## State — Service Classes

### `path/to/file.ts:40`
**Issue:** <finding>

## String Checks

### `path/to/file.ts:9`
**Issue:** <finding>

## Styling Strategy

### `path/to/file.tsx:15`
**Issue:** <finding>

## Clean files
<list files scanned with zero findings, or "All scanned files had findings.">
```

Omit any section with zero findings. If zero findings across all fourteen categories:
report "✅ No coding-convention findings." with the scan summary still included.

## Output

Report the absolute path to the generated markdown file and a one-line summary of
findings. Report-only: never edit a source file as part of this skill, including
approved extraction proposals — even a follow-up turn applies those as a separate,
explicit step outside this skill. (The `install` target is the sole exception — see
**Install**.)

## Triggers

- `/crux-audit`
- `/crux-audit full`
- `/crux-audit <path>`
- `/crux-audit install`
