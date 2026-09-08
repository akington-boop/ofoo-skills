---
name: phipii-mini-audit
description: Use when the user invokes /phipii-mini-audit, asks for a PII/PHI compliance audit, or wants to check staged form fields, logging, analytics, or API payload changes for GlobalLinkNoTx coverage before commit. Audits the staged diff and reports findings only; it never edits code or configuration.
---

# PII/PHI Mini Audit

Audit staged changes for user-identifiable data (PII) or health data (PHI)
that is rendered, logged, or transmitted without translation-blocking coverage.

## Establish coverage rules

1. Read [references/tagging-rules.md](references/tagging-rules.md) before
   auditing. Tagging happens at compile time, so never search source for a
   literal `GlobalLinkNoTx` tag.
2. Look for `component-decorator.config.js` at the project root. Its rules,
   together with enabled built-in rules, determine UI coverage.
3. If the config is absent, categorize every PII/PHI hit as `Unverified - no
   config found`; do not assert that it is a violation.

## Audit the staged diff

1. Run `git diff --staged`. If it has no output, say: `No staged changes
   found. Stage files first.` and stop.
2. Inspect added or modified lines only: lines prefixed with `+`, excluding
   `+++` file headers. Work file by file.
3. Skip `*.test.*`, `*.spec.*`, `__mocks__/`, `__fixtures__/`, and
   `*.stories.*`, unless they contain clearly real data copied into the test.
4. Identify PII such as names, email or IP addresses, phone numbers, SSNs,
   physical addresses, user or device IDs, and dates of birth. Identify PHI
   such as conditions, insurance, prescriptions, treatment notes, doctor
   details, test results, and appointment records.
5. For each hit, determine whether it renders through a component or element,
   or flows to a logger, analytics call, local storage, or API payload.

## Classify findings

- `Missing Tag Violation`: PII/PHI renders through a component without a
  matching config or built-in rule. Account for `whenProp` guards and their
  actual staged prop values.
- `Logging Exposure`: PII/PHI reaches `console`, a logger, or analytics. This
  is always a violation because decorator rules cannot cover these paths.
- `Potential Data Leak`: PII/PHI reaches local storage, an API payload, or a
  different path outside tagged rendering.
- A component with no prop path a rule can target is a real gap; explain that
  it needs `wrapWith` or a new rule rather than only a config adjustment.

Use `HIGH` for logging, analytics, or off-device data exposure; `MEDIUM` for
uncovered UI rendering; and `LOW` when an existing rule nearly covers the
component and likely needs a small configuration adjustment.

## Report

Use this format, omitting the findings section when there are none:

````markdown
## PII/PHI Compliance Audit Report

### Summary

- **Files Audited:** [count]
- **Potential Violations Found:** [count]
- **Status:** [PASS / ACTION REQUIRED]

### Findings Breakdown

#### 1. [File Path] (Line [line number])

- **Severity:** [HIGH / MEDIUM / LOW]
- **Category:** [classification]
- **Snippet:**
  ```[language]
  [offending staged line]
  ```
- **Why:** [missing rule or data path explanation]
````

State when the configuration was absent. Report only: do not edit code, add
tags, patch configuration, stage files, or create a commit.