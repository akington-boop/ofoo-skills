# Handoff: "destructive" button does not mean red — add a crux-audit convention counter

## Goal for the next session

Add a coding-convention rule to the crux-audit skill (`~/ofoo-skills/skills/crux-audit/references/`) that counters an agent inferring "style this button red / `color="error"`" from the word "destructive" (or similar) in a spec. Button colour comes from the design mock / theme, not from the semantic label of the action.

## What happened (the incident)

- Story CXP-4575 (ui-home, `src/client/BulletinAdmin/Personas/`), "Basic delete a persona workflow". Spec: `~/work-tracker/10_stories/CXP-4575/CXP-4575-spec.md`.
- The spec said (user story 8): "I want the Delete confirm button styled as a destructive action, so that its consequence is visually clear." The Implementation Decisions section repeated it: shared `BulletinConfirmDialog` with `primaryCtaColor` `error`.
- The implementing agent took "destructive" literally and passed `primaryCtaColor="error"` to `BulletinConfirmDialog` in `PersonasView.tsx`. That renders the confirm button red (MUI `color="error"`).
- The user's reaction: "why is the button red? it should be theme primary like the mock". The Figma mock (`delete-persona-confirm-dialog.png` in the story folder) shows the default theme-primary button.
- Fix applied: removed `primaryCtaColor="error"`. Button now uses the default `primary`. The spec was not edited, so it still says "destructive"; it is stale and contradicts the mock.

## Root cause / lesson to encode

1. **"Destructive" is a semantic label for the action, not a styling instruction.** It does not imply red / `error` colour. In this codebase's designs, destructive confirms (here, Delete) use theme primary.
2. **Source-of-truth order for visual treatment:** design mock / theme tokens first. When the spec's wording ("destructive", "danger", "warning style") and the mock disagree, or the spec infers a colour from a word, the agent must not choose `error`/red on its own. Follow the mock, or ask.
3. Existing precedent in the same repo: the spec's own brief said "where mock and story conflict, ask the user." The agent resolved the conflict silently instead of asking. The convention should say the same for colour.
4. The shared component exposes the knob (`BulletinConfirmDialog.primaryCtaColor?: "primary" | "error"`, `src/client/BulletinAdmin/CommonComponents/BulletinConfirmDialog.tsx`), which makes the wrong choice easy. Using `"error"` should require explicit evidence (mock shows red, or user said so).

## Suggested rule shape (for the counter)

Candidate home: `references/styling-strategy.md` (colour/theme usage) — check it first and add there; only create a new reference doc if it does not fit, and then register it in `references/INDEX.md` and the router in `SKILL.md`/README.

Draft wording to adapt (keep the file's existing tone and format, with a CORRECT / WRONG example like sibling docs):

- Do not set `color="error"` (or red/`palette.error` styling) on a button because the action is described as destructive, dangerous, or irreversible. Colour follows the design mock and theme; default is theme primary.
- Use `error` colour only when the mock shows it or the user explicitly asks for it.
- If a spec's wording about an action's severity conflicts with, or is not backed by, the mock, ask the user instead of picking a colour.
- Audit hook (for `/crux-audit` mode): flag `color="error"` / `primaryCtaColor="error"` / `variant`-based red styling on buttons in diffs, and verify against the mock or spec evidence.

Open questions to settle with the user before writing the rule:
- Is "destructive actions are theme primary" a project-wide design-system rule, or specific to this dialog/mock? (Scope of the rule: all buttons vs. confirm dialogs.)
- Are there legitimate `error`-coloured buttons elsewhere (e.g. other dialogs in `BulletinAdmin`)? Grep `primaryCtaColor="error"` and `color="error"` in `~/build/ui-home/src/client` to see current usage before declaring a hard rule.
- Should the crux-audit also be told to treat a spec's "styled as X" phrases as hints to verify against the mock?

## Where things live

- Skill to edit: `~/ofoo-skills/skills/crux-audit/` (`SKILL.md`, `README.md`, `CHANGELOG.md`, `references/`, `docs/`). Existing sibling handoffs in `docs/` show the expected handoff/rule-writing style: `handoff-extract-refactoring.md`, `handoff-receiver-rules.md`; `docs/TODO.md` may track rule work.
- The installed copy the user's CLAUDE.md router points at is `~/.claude/skills/crux-audit/references/`; confirm whether it is a symlink/copy of `~/ofoo-skills/...` so the change takes effect (do not assume).
- The CXP-4575 implementation is in the ui-home working tree (uncommitted by the spec's "do not stage or commit" directive). Nothing in that repo needs to change for this task; the red→primary fix is already applied.

## Constraints / user preferences

- Add a `CHANGELOG.md` entry for the crux-audit skill change, following its existing format.
- Skill docs should be terse and follow the writing-for-agents guidance.
- Do not stage or commit in the ui-home repo. For the ofoo-skills repo, ask before committing.

## Suggested skills

- `writing-for-agents` — editing skill reference docs and SKILL.md/README for agent consumption.
- `crux-audit` — read it first to understand the router, the rule-doc format, and how audit mode reports findings.
- `cc` — only if verifying the new rule by auditing the CXP-4575 diff (`/cc audit`) after the rule is written.
