# State Management — Service Classes

Domain state lives in a service class with `Observable` / `ObservableList` properties (`@residualeffect/reactor`). See [component-architecture.md](component-architecture.md) for the service/component boundary.

Simple UI-only state (open/close toggles, hover, local display flags) may use `React.useState`. Decision rule: if the state is derived from domain data, affects domain data, or needs to be tested independently of React, it belongs in a service class instead.

```ts
// CORRECT — business logic in a service class
import { Observable, ObservableList } from "@residualeffect/reactor";

class MyService {
    public Items = new ObservableList<Item>([]);
    public Selected = new Observable<Item | null>(null);

    Select = (item: Item): void => { this.Selected.Value = item; };
}

// CORRECT — trivial UI state stays in the component
const [dialogOpen, setDialogOpen] = useState(false);

// WRONG — business logic inside the component
const [items, setItems] = React.useState<Item[]>([]);
```
## Wiring a service class into a React component

See [state-observables-react.md](state-observables-react.md) for subscribing to a service's `Observable` / `ObservableList` properties via `useObservable`.

## Form validation

Form validation uses `ValidatableFieldOf<T>` Observables with `Computed` derivations (`IsValid`, `ValidationMessage`, `HasChanged`, `CanSave`).

Every `Observable{Domain}` class exposes `ValidatableFields: ValidatableField[]` listing **all** validatable fields it owns, including derived / cross-field validators (e.g. a missing-property check spanning siblings) — not just 1:1 form-input fields.

A parent owning `Observable{Domain}` children exposes `AllValidatableFields: ValidatableField[]` = its own fields flattened with each child's `ValidatableFields`.

Violation: a new `ValidatableField` not added to its class's `ValidatableFields`, or a `ValidatableFields` not reachable from the nearest `AllValidatableFields`. Generic save-gating (`AllValidatableFields.every(f => f.IsValid.Value)`) and server-error field-matching (`by FieldId`) both iterate this array — an omitted field silently stops participating in both, with no compile error.

## Data fetch and response envelopes

Data fetch uses `@webmdhs/json-http-request` promise-based `Get` / `Post` / `Result`.

See [http-response-patterns.md](http-response-patterns.md) for response-envelope rules.

## Singleton store

See [naming-conventions.md](naming-conventions.md) for the rules governing application-global stores and `Instance` access.
