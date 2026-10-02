# Coding Convention Router

Routing table for a markdown-file router: wire a project's `CLAUDE.md` to read
`universal-baseline.md` plus the docs matching the trigger below — resolved against
wherever this skill is installed (e.g. `~/.claude/skills/crux-audit/references/`).
`/crux-audit install` automates wiring this table into a `CLAUDE.md` for you.
`common` = `shared-code.md`, `string-checks.md`, `naming-conventions.md`,
`component-architecture.md`, `language-idioms.md`.

- **writing a React component** → `component-declarations.md`, `guard-components.md`, `state-observables-react.md`, `state-service-classes.md`, `async-patterns.md`, `styling-strategy.md`, `common`
- **writing a service/domain class** → `state-service-classes.md`, `async-patterns.md`, `http-response-patterns.md`, `common`
- **fetch / `ResultOf` / json-http-request work** → `http-response-patterns.md`, `async-patterns.md`, `shared-code.md`
- **reaching for a shared/internal utility** → `shared-code.md`, `string-checks.md`, `language-idioms.md`
- **MUI theme / `sx` / styling** → `styling-strategy.md`
- **aliases / server isolation / file grouping** → `directory-structure.md`
- **naming / extraction / service-component split** → `naming-conventions.md`, `component-architecture.md`
- **implementing a full story/ticket** → every doc above, all fourteen rule docs except `complexity.md`
