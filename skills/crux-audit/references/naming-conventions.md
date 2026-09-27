# Naming Conventions

- Generic type params: T-prefixed PascalCase (`TDataPoint`, `ValidatableFieldOf<T>`), never bare letters (`T`, `U`, `K`).
- Public methods and properties: PascalCase (.NET-style), even in TS/TSX. Suggested, not required, when matching an existing file that already uses camelCase.
- Services: `<Feature>Service` class name. New application-global data stores use the `<Feature>Store` name and may expose a static `Instance` getter; services and utilities do not. Access `Store.Instance` only in composition roots: entry points, UI providers, and app setup. Existing non-`*Store` classes with `Instance` are legacy: match the file when editing it, but do not copy the pattern into new code. See [component-architecture.md](component-architecture.md).
- Builders: `Builder` suffix with fluent `With*` methods.
- Class grouping a domain entity's validatable state into `ValidatableField` / `ValidatableFieldOf<T>` instances: `Observable{DomainName}` (e.g. `ObservableHealthDataAttribute`) — never `*Fields` or `*State`. `DomainName` must not equal a `@residualeffect/reactor` export (`Observable`, `ObservableArray`, `ObservableObject`, `ObservableList`, `Computed`, `FilteredObservable`, `RateLimiter`, `RateLimitType`), to avoid shadowing the library import.
