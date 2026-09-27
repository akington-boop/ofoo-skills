# HTTP Response Patterns

The `json-http-request` library defines a `ResultOf<T>` wrapper for API responses:

```ts
// API response shape (from json-http-request)
interface ResultOf<T> {
	Success: boolean;
	ErrorMessage: string | null;
	Data: T | null;
}
```

New `json-http-request` code uses the `ResultOf<T>` contract with `JsonHttpRequest.PostResult()` or `GetResult()`. These helpers unwrap the `Data` field and return it directly.

When `PostResult`/`GetResult` receives `Success: false`, it throws `InvalidResultStateError` with the response `ErrorMessage`. Callers should handle that error and surface an appropriate message to the user.

Existing APIs retain their established response envelope; do not reshape them solely to adopt this standard. Document any existing response shape in the API file's interface.
