# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

An [agentskills.io](agentskills.io)-compatible collection of Agent Skills. There is no build, lint, or test tooling (no `package.json` or scripts) — the content of this repo *is* the product.

## Layout

- `skills/` — the actual skills in this collection. Each skill is its own directory containing a `SKILL.md`:
  - `changelog/` — generates or updates Keep a Changelog entries from Git history or staged changes.
  - `commit-message/` — drafts an issue-prefixed Git commit message from staged changes without committing.
  - `cve-table/` — renders npm audit advisories as a compact Markdown table without remediation.
  - `upscale-markdown/` — decorates eligible Markdown H2 and H3 headings with semantic emoji.
  - `wcag-audit/` — produces report-only WCAG 2.2 AA accessibility audits of UI code.
  New skills go here.
- `refs/agentskills/` — the Agent Skills format reference docs (not skills themselves — don't put these under `skills/`). Start at `refs/agentskills/index.md`, which routes to the right doc for the task at hand:
  - `quickstart.mdx` — required `SKILL.md` structure, minimal example, discovery/activation basics.
  - `best-practices.mdx` — scoping, context budget, gotchas sections, templates, checklists, validation loops, progressive disclosure for large skills.
  - `using-scripts.mdx` — bundling scripts under `scripts/`, CLI contracts, safety.
  - `optimizing-descriptions.mdx` — tuning the frontmatter `description` for reliable activation.
  - `evaluating-skills.mdx` — test cases, baselines, grading, iteration.

## Skill format (from refs/agentskills)

- A skill is a directory containing `SKILL.md`; its frontmatter `name` matches the directory name.
- Frontmatter `description` drives activation — write it around user intent, not a feature list.
- Keep `SKILL.md` itself lean (target: under 500 lines / 5,000 tokens) — only the non-obvious, project/domain-specific guidance the agent needs on every run. Push detailed reference material to `references/`, templates to `assets/`, and reusable logic to `scripts/`, each loaded only when `SKILL.md` tells the agent to.
- Favor a clear default procedure over a menu of options.

When authoring or editing a skill in `skills/`, consult the matching doc in `refs/agentskills/` rather than relying on general knowledge of the format.
