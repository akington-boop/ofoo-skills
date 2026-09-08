# ofoo skills

An [agentskills.io](https://agentskills.io)-compatible collection of reusable AI skills.

## Included skills

| Skill | Use it for |
| --- | --- |
| [changelog](skills/changelog/SKILL.md) | Generating or updating Keep a Changelog entries from staged changes or Git history. |
| [commit-message](skills/commit-message/SKILL.md) | Drafting concise Git commit messages from staged changes, with an optional issue ID. |
| [cve-table](skills/cve-table/SKILL.md) | Reporting npm dependency advisories in a compact Markdown table. |
| [phipii-mini-audit](skills/phipii-mini-audit/SKILL.md) | Auditing staged PII/PHI changes for translation-blocking coverage and exposure risks. |
| [upscale-markdown](skills/upscale-markdown/SKILL.md) | Adding semantically appropriate emoji to eligible Markdown H2 and H3 headings while preserving all other content. |
| [wcag-audit](skills/wcag-audit/SKILL.md) | Report-only WCAG 2.2 AA accessibility audits of staged UI changes, a repository, or a focused source path. |

## Install via skills.sh

Install globally `-g`   
Install for agent `-a`
Install individial skills `--skill <name>`

```bash
npx skills add akington-boop/ofoo-skills -g -a claude-code \
  --skill changelog \
  --skill commit-message \
  --skill cve-table \
  --skill phipii-mini-audit \
  --skill upscale-markdown \
  --skill wcag-audit
```

## Repository layout

- [`skills/`](skills/) contains one directory per skill. Each skill directory must contain a `SKILL.md` whose frontmatter `name` matches its directory name.
- [`refs/agentskills/`](refs/agentskills/) contains the local Agent Skills format reference material used when authoring or improving skills.

## Creating a skill

Start with [`refs/agentskills/index.md`](refs/agentskills/index.md) and follow the smallest applicable reference. Keep each `SKILL.md` focused on the operating procedure, use intent-oriented descriptions for activation, and move large or conditional material into sibling reference files.
