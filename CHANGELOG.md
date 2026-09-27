# Changelog

## [1.0.0] - 2026-09-26

### Added

- `changelog` skill: generate or update a project's `CHANGELOG.md` in Keep a Changelog format from staged changes or commit history.
- `commit-message` skill: draft a commit message from the staged diff.
- `crux-audit` skill: full coding-convention review of TS/TSX code against the fourteen rule docs, plus a bundled install mode for wiring the routing table into a project's CLAUDE.md.
- `cve-table` skill: list current npm dependency advisories in a compact Markdown table.
- `phipii-mini-audit` skill: audit staged form fields, logging, analytics, and API payload changes for PII/PHI compliance.
- `upscale-markdown` skill: add semantically appropriate emoji to Markdown H2/H3 headings.
- `wcag-audit` skill: report-only WCAG 2.2 AA accessibility audit of UI code or staged changes.
- `wcag-audit` skill: report-only WCAG 2.2 AA accessibility audit of UI code or staged changes.
- README instructions for installing skills via `npx skills add` (skills.sh).

### Fixed

- Broken `agentskills.io` link in README (missing `https://` scheme).
