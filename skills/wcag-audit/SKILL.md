---
name: wcag-audit
description: Use when asked to audit a web app, UI code, staged changes, or a source folder for WCAG 2.2 AA accessibility issues, including React, Angular, Vue, HTML, CSS, and SCSS. Produces a report-only accessibility review with actionable, severity-ranked findings; invoke for /wcag-audit.
---

# WCAG 2.2 Accessibility Auditor

Audit code against WCAG 2.2 AA. Produce findings only; never edit code or apply automatic fixes.

## Determine scope

Interpret the invocation as follows:

- `/wcag-audit`: audit staged changes with `git diff --staged`.
- `/wcag-audit full`: audit the full repository.
- `/wcag-audit full <path>`: audit that path recursively.

For staged mode, run `git diff --staged`. If the command reports that this is not a Git repository, report `Not a git repository` and stop. If its output is empty, respond exactly:

> No staged changes found. Stage files first, or use `/wcag-audit full` to scan the repo.

For a full scan, continue even outside a Git repository. Restrict the scan to `*.tsx`, `*.jsx`, `*.html`, `*.vue`, `*.css`, and `*.scss`; exclude test and spec files, configuration files, generated output, and dependencies. In staged mode, inspect changed UI code in every staged file type, but only report findings relevant to UI code.

For a full scan with 100 or more UI files, explain that a focused path is needed and ask the user to scope the scan. Do not silently sample files.

## Audit

1. Read [rules/a11y.md](rules/a11y.md) in full before inspecting code. It is the source of truth for rule definitions, severities, and WCAG criteria.
2. Inspect every collected file line by line in a single pass. Check all applicable semantic HTML, media, visual, keyboard/focus, form, ARIA, and framework-specific rules together. Do not use sub-agents or split categories across reviewers.
3. Apply framework-specific rules only where the file type and syntax support them: React/Next.js for JSX/TSX, Angular for Angular templates, and Vue for Vue files.
4. Report an issue only when the code provides sufficient evidence. Do not infer inaccessible behavior from missing surrounding context; state an uncertainty or omit the finding instead.
5. Deduplicate findings by `(file, line, rule ID)`. When one code construct violates more than one rule, report each applicable rule once.

## Report

Group findings in this exact order: CRITICAL, IMPORTANT, SUGGESTION. Within a group, sort by file path and then line number. Use this format, omitting empty severity sections:

```markdown
## WCAG Audit - [staged diff | full repo | full scan: <path>]

### CRITICAL ([count])

- **S8** `src/Button.tsx:42` - Interactive div with onClick but no role or keyboard handler

### IMPORTANT ([count])

- **K4** `src/App.tsx:5` - No skip link as first focusable element

### SUGGESTION ([count])

- **V5** `src/Card.css:12` - Animation without prefers-reduced-motion guard

No findings in: Perceivable, Operable
```

Use the rule IDs and severities exactly as defined in the reference. The `No findings in:` line is required when one or more POUR categories have no findings across the entire audit; list only those categories.

## Final check

Before responding, verify that every finding has a rule ID, reference-defined severity, file path, line number, and concise evidence-based description. Confirm that no source files were edited.