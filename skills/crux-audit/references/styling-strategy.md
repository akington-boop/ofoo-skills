# Styling Strategy

Use the `sx` prop with `SystemStyleObject<Theme>` on MUI v6/v7:

```ts
const Styles = (_theme: Theme): SystemStyleObject<Theme> => ({ /* … */ });
```

Theme comes from the shared internal WebMD base package, not vanilla MUI / Material-UI defaults. Use `@webmdhs/mui-theme` (v6/v7/v9).

Wrap the root with `ScopedCssBaseline`. When multiple React versions share a page, pair `ScopedCssBaseline` with an Emotion `CacheProvider` to isolate styles and avoid cross-version bleed.

Use `GlobalStyles` for global CSS overrides that cannot be scoped.

Per-icon imports using the `Rounded` variant. Import MUI components via default imports, not barrels. Merge themes via `deepmerge` from `@mui/utils`.

Use `clsx` for conditional `className` composition.

Use TypeScript module augmentation to declare custom MUI component variants.
