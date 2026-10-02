# crux-audit

Audits TS/TSX code against fourteen coding-convention rule docs: four that need
whole-file/class judgment (complexity, architecture, directory structure, naming) plus
ten path-scoped/global rules normally enforced inline while editing. Report-only: surfaces
issues, never edits code or proposes remedies.

## What it does

Use `/crux-audit` before committing, or `/crux-audit full` / `/crux-audit <path>` for a
wider pass. It writes a dated markdown report (`audit<MMDD-HHMM>.md`) to the current
directory listing findings per rule category.

The fourteen rule docs are bundled in [`references/`](references/) — the skill has no
dependency on any path outside its own directory. [`references/INDEX.md`](references/INDEX.md)
is a bonus routing table: a project's own `CLAUDE.md` can use it to wire the same rule
docs into inline, path-triggered enforcement while editing (e.g. "writing a React
component → these three docs"), so one set of rule content backs both the full audit
and a lighter always-on router, without duplicating anything.

`/crux-audit install` automates that wiring: it asks whether to update your global
`CLAUDE.md`, the current repo's `CLAUDE.md`, or its `CLAUDE.local.md`, creates the file
if needed, and — if a router section already exists there — checks whether it's still
current before touching it.

## Usage

```text
/crux-audit
/crux-audit full
/crux-audit src/some/path
/crux-audit install
```
