# State Management — Consuming Observables in React

Subscribe to `Observable`, `ObservableArray`, or `ObservableObject` (`@residualeffect/reactor`) via the single generic `useObservable` (`@residualeffect/rereactor`). The component re-renders whenever the observable notifies.

For `ObservableArray`, `useObservable` returns `.Value` (`readonly T[]`). Mutators (`push`, `splice`, `sort`, etc.) mutate the underlying array **in place** and just call `NotifyObservers()` — they do NOT produce a new array reference. Do not rely on referential identity of the returned array for `useMemo`/`useCallback`/`React.memo` deps; use `service.Items.Value.length`, a derived primitive, or a manual deep check instead.

```tsx
import { useObservable } from "@residualeffect/rereactor";

export function ItemList({ service }: { service: ItemService }): JSX.Element {
    const items = useObservable(service.Items); // readonly Item[]
    return (
        <ul>
            {items.map((item) => (
                <li key={item.Id}>{item.Name}</li>
            ))}
        </ul>
    );
}
```
