
## Removed content (verbatim from `references/complexity-and-refactoring.md`, pre-change)

```markdown
# Complexity and Refactoring

Flag a class or file handling multiple unrelated concerns (single-responsibility violation) as a refactor candidate instead of accreting more logic onto it.

Investigate a method when cognitive complexity exceeds 15 or cyclomatic complexity exceeds 10. These are review triggers, not automatic extraction requirements; use the single-responsibility audit to determine whether refactoring is warranted.

Before refactoring, audit the target for extractable sub-concerns and estimate each sub-concern's complexity.

Proposal format required before extraction:

1. Sub-concern and estimated complexity
2. The new class's interface and dependency-injection plan
3. How testability improves without breaking the original class's private encapsulation

Present the extraction proposal and wait for approval — do not extract or refactor files unprompted.

Once approved, extract the sub-concern via composition, not inheritance. Use the dependency boundary defined in [component-architecture.md](component-architecture.md) for new or extracted logic classes.
```

Also removed from `SKILL.md` (old step 5 text): for any complexity finding needing class extraction, propose it (never perform it) with: sub-concern and estimated complexity; the new class's interface and DI plan; how testability improves without breaking private encapsulation. The report template carried a matching "Extraction proposal (pending approval — not yet applied)" block with those three bullets.

## Future work: refactoring analysis agent

The user wants refactoring analysis to live in a separate, specialized agent/skill, not in `crux-audit`. Use the removed content above as seed material: audit for extractable sub-concerns, estimated complexity per sub-concern, proposal format, approval gate, composition over inheritance, DI via the `component-architecture.md` dependency boundary.

**Consider existing skills before writing one from scratch**, such as Matt Pocock's skills (plugin `mattpocock-skills`, installed under `~/.claude/plugins/cache/claude-plugins-official/mattpocock-skills/1.2.3/skills/`). Candidates seen in the listing, to be read before deciding (I haven't opened any of them):
- `engineering/improve-codebase-architecture`
- `engineering/codebase-design`
- `engineering/code-review`
- `engineering/domain-modeling`
- `engineering/tdd`: relevant to the testability angle.
- `in-progress/setup-ts-deep-modules`

The open question is whether `crux-audit` findings should feed one of these, or a thin custom skill should wrap the removed proposal format. This is the user's call, so ask before building.
