# changelog

Generates or updates a project's `CHANGELOG.md` from staged changes or Git
history, following the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
format.

## What it does

- Reads the current changelog to identify the latest recorded release.
- Uses staged diffs when requested, otherwise collects commits since the last
  matching Git tag.
- Excludes merges and purely mechanical changes.
- Categorizes meaningful changes as Added, Changed, Deprecated, Removed, Fixed,
  or Security.
- Writes concise entries about user-visible outcomes and inserts them newest
  first without rewriting existing history.

## Usage

```text
/changelog
```

Run it from the target repository root. Ask explicitly to document staged
changes when that is the intended source.

## Boundaries

The skill adds a new entry; it does not reformat historical changelog content
or create a Git commit. If a recorded version does not match a Git tag, it asks
for an explicit history boundary to avoid duplicate entries.