# Changelog

## [1] - 2026-10-02

### Added

- `/crux-audit` skill: report-only review of TS/TSX code against fourteen coding-convention rule docs, written to a dated Markdown report. Audits staged files by default, or `full` / a given path.
- `/crux-audit install`: wires the bundled path-scoped routing table into a project or global `CLAUDE.md`.
- Bundled rule docs under `references/` with an `INDEX.md` routing table, covering complexity, component architecture, state, async, HTTP responses, naming, styling, and more.
- README with usage and install instructions.
- `docs/handoff-extract-refactoring.md` preserving the removed extraction-proposal workflow as seed material for a separate refactoring agent.

### Changed

- Complexity rule slimmed to flag single-responsibility violations and cognitive/cyclomatic complexity thresholds; findings name the unrelated concerns found as evidence.
- Audit is strictly report-only: findings state the issue alone, with remedies left to a dedicated refactoring agent.

### Removed

- Extraction proposals from audit reports; `references/complexity-and-refactoring.md` replaced by `references/complexity.md`.
