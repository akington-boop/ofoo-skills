# Tagging Rules

`MuiComponentDecoratorPlugin` injects the `GlobalLinkNoTx` class at build time.
The class is not present in source code; verify it in compiled DOM output when
runtime confirmation is required.

Use `component-decorator.config.js` at the project root to assess coverage:

- `target` injects the class into a component prop path, for example
  `className`, `inputProps.className`, or `slotProps.htmlInput.className`.
- `wrapWith` covers components that do not forward `className` by wrapping
  them in an element such as `span`.
- `whenProp` rules only apply when their guard matches the actual prop value.
- Wildcard `match` patterns may cover multiple elements or import paths.
- Bare package matches use package mode and can cover a third-party package's
  compiled output.

When `useCoreRules` is enabled, native `input`, `textarea`, and `select`, plus
MUI `TextField`, `Input`, `OutlinedInput`, `FilledInput`, `InputBase`, and
`NativeSelect` have built-in coverage. MUI v5 and v6 prop paths are supported
in parallel.

Unmatched decorator rules can produce build warnings. A warning is useful
evidence that a purported rule does not cover the intended component.