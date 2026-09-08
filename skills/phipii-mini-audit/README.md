# phipii-mini-audit

Audits staged Git changes for PII/PHI rendered, logged, or transmitted without
translation-blocking coverage from `MuiComponentDecoratorPlugin` and
`component-decorator.config.js`. It is report-only and never changes code or
configuration.

## What it does

Use `/phipii-mini-audit` before committing changes to form fields, user
profiles, logs, analytics, or API payloads. It reads `git diff --staged`,
checks UI paths against configured decorator rules, and reports missing UI
coverage, logging exposure, and potential data leaks.

Tagging is injected at compile time as `GlobalLinkNoTx`, not written into
source files. The audit therefore checks configuration rules instead of
literal tag text.

## Usage

```text
/phipii-mini-audit
```

Stage the intended changes first. If `component-decorator.config.js` is not
available, findings are reported as unverified rather than violations.