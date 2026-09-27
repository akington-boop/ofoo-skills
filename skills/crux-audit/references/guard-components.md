# Guard Components

A guard component controls access to a subtree. It accepts a `Fallback` prop for the restricted state and renders `children` when the guard passes.

## Rules

- Name guard components with a `Guard` suffix (e.g. `SponsorLevelGuard`, `AuthGuard`).
- The fallback prop is always named `Fallback`.
- Pass the fallback as an inline arrow at the call site: `Fallback={() => <MyFallback />}`.
- Extract the fallback UI as a named `function` in the same file — do not inline JSX directly in the prop value.
- The fallback function follows [component-declarations.md](component-declarations.md).

## Example

```tsx
// CORRECT
<SponsorLevelGuard SponsorId={sponsorId} Fallback={() => <RestrictedToSponsor />}>
    <SponsorAdminRouter />
</SponsorLevelGuard>

// WRONG — fallback prop named differently, JSX inlined in the prop
<SponsorLevelGuard SponsorId={sponsorId} fallback={<div>Not allowed</div>}>
    <SponsorAdminRouter />
</SponsorLevelGuard>
```
