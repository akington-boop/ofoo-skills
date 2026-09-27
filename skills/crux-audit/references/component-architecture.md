# Component Architecture

See [component-declarations.md](component-declarations.md) for component declaration style.

Service classes hold business logic; components are purely presentational. A service is a focused business-logic, view-data-shaping, or factory class — not a grab-bag of UI handlers.

New and extracted service classes take dependencies as constructor parameters typed to interfaces or contracts, so dependencies remain explicit and replaceable in tests. Composition roots — entry points, UI providers, app setup — construct services and pass dependencies in; see [naming-conventions.md](naming-conventions.md) for `Store.Instance` scoping. Resolve dependencies at construction, never through a runtime service locator. Use React context when the resource's lifetime, configuration, or test replacement is scoped to a component subtree.

## Patterns

**`RouterLinkTo` factory** — adapts MUI `component` prop to react-router:

```ts
export function RouterLinkTo(to: string): React.ElementType { /* … */ }
```

**Type-dispatch factory** — shared interface `IDataPointTypeService` with per-type implementers and a facade resolver at runtime.

**Builder** — see [naming-conventions.md](naming-conventions.md) for the naming rule.

**Context + `useX` hook** — co-locate in the same file. The class holds state/logic; the hook wraps Observable subscription.

**Slot props** — a generic table accepts per-column components (`HeaderComponent`, `DataComponent`).
