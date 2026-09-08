# Agent Skills Reference Index

Use this index to select the smallest relevant guide when creating, improving, or validating an Agent Skill.

## Route by intent

| Need | Read | Use it when |
| --- | --- | --- |
| Create a first skill | [Quickstart](quickstart.mdx) | You need the required `SKILL.md` structure, a minimal example, or discovery and activation basics. |
| Improve a skill's instructions | [Best practices](best-practices.mdx) | You need to set scope, conserve context, add gotchas, choose instruction specificity, define validation, or structure large skills. |
| Bundle or invoke tooling | [Using scripts](using-scripts.mdx) | The workflow needs shell commands or reusable scripts, including dependency handling and agent-friendly CLI design. |
| Make activation reliable | [Optimizing descriptions](optimizing-descriptions.mdx) | You need to improve the frontmatter `description`, reduce false triggers, or test should-trigger and should-not-trigger prompts. |
| Measure skill value | [Evaluating skills](evaluating-skills.mdx) | You need realistic test cases, baselines, assertions, grading, benchmarks, or an iteration loop. |

## Recommended workflow

1. Start with [Quickstart](quickstart.mdx) to create a discoverable `SKILL.md`.
2. Apply [Best practices](best-practices.mdx) to encode project-specific expertise as concise, reusable procedures.
3. Use [Using scripts](using-scripts.mdx) when the agent repeats logic or a command has become fragile or complex.
4. Use [Optimizing descriptions](optimizing-descriptions.mdx) to verify the skill activates for the right user intents.
5. Use [Evaluating skills](evaluating-skills.mdx) to compare the skill against a baseline, grade outcomes, and iterate from evidence.

## Core rules at a glance

- A skill is a directory containing `SKILL.md`; its `name` matches the directory name.
- The `description` determines activation, so write it around user intent and test positive and near-miss prompts.
- Put only non-obvious, domain- or project-specific guidance in `SKILL.md`; move detailed material behind explicit conditional references.
- Prefer a clear default and a reusable procedure over a menu of options or a one-off answer.
- Scripts must be non-interactive, expose concise `--help`, return actionable errors, use structured stdout, and send diagnostics to stderr.
- Validate skill changes with realistic tasks and compare quality, time, and token cost with a baseline.

## Document map

- [Quickstart](quickstart.mdx): layout, frontmatter, registration, discovery, activation, progressive disclosure.
- [Best practices](best-practices.mdx): expertise extraction, scope, context budget, control level, gotchas, templates, checklists, validation, and reusable scripts.
- [Using scripts](using-scripts.mdx): one-off package runners, relative script paths, self-contained dependencies, CLI contracts, safety, and output design.
- [Optimizing descriptions](optimizing-descriptions.mdx): trigger behavior, query sets, repeated runs, train/validation splits, and description iteration.
- [Evaluating skills](evaluating-skills.mdx): `evals.json`, isolated runs, baselines, assertions, grading evidence, benchmarks, human review, and iterative improvement.
