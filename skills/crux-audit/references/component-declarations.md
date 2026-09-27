# Component Declarations

- `function` declaration + named export. No `React.FC`, no default exports.
- For components that require ref forwarding, use `export const MyComponent = React.forwardRef<RefType, PropsType>(function MyComponent(...) { ... })` and name the inner function for stack traces. This is the only exception to the function declaration rule.
- New JSX transform: omit `import * as React` unless the file references any type or value accessed via the `React.` namespace (e.g., `React.RefObject`, `React.MouseEvent`, `React.CSSProperties`, `React.ReactNode`).
- Return type: `JSX.Element`.

    - If the component may return `null` (for example, conditional renders that render nothing), declare the return type as `JSX.Element | null`.
