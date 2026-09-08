---
name: changelog
description: Use when asked to generate, update, or write a project's CHANGELOG.md, prepare a release changelog, or invoke /changelog. Derives concise Keep a Changelog entries from staged changes or Git history; it adds new entries but does not rewrite existing changelog history.
---

# Changelog

Generate or update the current project's `CHANGELOG.md` using the [Keep a
Changelog](https://keepachangelog.com/en/1.1.0/) format.

## Determine the source

1. Confirm the current directory is a Git repository. If it is not, say so and
   stop; do not create a changelog from assumptions.
2. Read the existing `CHANGELOG.md`, if present. Preserve its title, preamble,
   link references, and all existing entries exactly.
3. Use staged changes when the user explicitly asks to document staged changes.
   Collect both `git diff --staged --stat` and `git diff --staged`.
4. Otherwise, use committed history:
   - Find the latest version recorded in the changelog and its matching Git tag.
   - When it has a matching tag, use `git log <tag>..HEAD --oneline --no-merges`.
   - With no existing version, use at most the latest 50 commits with
     `git log --oneline --no-merges -50`.
    - If the changelog names a version without a matching Git tag, ask the user for the commit or tag boundary instead of guessing and risking duplicates.
5. If the selected source has no meaningful changes, report that no entry was
   added and do not modify `CHANGELOG.md`.

## Draft the entries

1. Exclude merges and purely mechanical work, including typo-only fixes,
   version bumps, formatting-only changes, and work-in-progress commits. Keep
   changes with user- or agent-visible value.
2. Inspect relevant diffs when a commit subject is insufficient to describe the
   change accurately.
3. Assign every included change to exactly one standard category. Do not invent
   custom headings:
   - `Added`: a new capability or feature.
   - `Changed`: an existing behavior changed.
   - `Deprecated`: functionality being phased out.
   - `Removed`: a deleted capability.
   - `Fixed`: a corrected bug or regression.
   - `Security`: a resolved vulnerability.
4. Write one concise, plain-language bullet per distinct user-visible change.
   Favor the outcome over internal implementation details; include a class,
   file, or package name only when it materially improves clarity.
5. Do not claim a behavior or impact that the source does not demonstrate.

## Update the changelog

Use the local date in `YYYY-MM-DD` form. Use `[Unreleased]` unless the user
provides a release version or a version tag clearly identifies this batch.
Omit empty category headings.

```markdown
## [Unreleased] - YYYY-MM-DD

### Added

- Describe the user-visible addition.

### Changed

- Describe the user-visible change.
```

Create `CHANGELOG.md` with `# Changelog` followed by the new block when it does
not exist. Otherwise, insert the new block immediately after the `# Changelog`
header and any directly associated preamble, before the most recent `## [...]`
entry. Keep entries newest first. Do not alter prior entries or make a Git
commit.

## Validate and report

Before responding, reread the inserted block and confirm that it contains only
the six standard category names, has no empty headings, has no duplicate
entries, and preserves the rest of the file unchanged. Report the source used,
the categories written, and whether `CHANGELOG.md` was created or updated.