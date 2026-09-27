# Shared Code

Prefer these internal shared modules over reimplementing equivalent logic.

## @webmdhs/general-data-structures

- `ArrayEquals`, `ArrayIntersect`, `ChunkArray`, `CopyArray`, `DistinctFilter`, `FindNextIndex`, `RemoveFromArray`
- `CoalesceStrings`
- `CommifyValue`
- `DictionaryForEach`, `DictionaryValues`
- `GetValueOrDefault`
- `PluralizedWord`, `PluralizeValueString`, `PluralizeWord`
- `Range`, `RangeEquals`
- `SortBoolean`, `SortBooleanFor`
- `SortByObjects`, `SortByObjectsFunc`
- `SortNumber`, `SortNumberFor`
- `SortStringByAlphabetical`, `SortStringByAlphabeticalFor`

Canonical usage rules: [string checks](string-checks.md) and [string-keyed dictionaries](language-idioms.md).

## @webmdhs/json-http-request

- `Get`, `Post`, `Put`, `Patch`, `Delete` — JSON fetch requests with optional response transform, abort, and error-code data passthrough
- `SetAntiForgeryToken`, `GetParams`, `RequestParams` — request setup
- `ConsoleError`, `MaybeTransformResponseWithFunc`, `HandleRequestPromise`, `PhmAuthorizationFailureDetected`, `ThrowAndLogForDebugging`, `HydrateError`
- Errors: `AbortedRequestError`, `FailedRequestError`, `ResponseError`, `InvalidResponseStatusCodeError`, `NotAuthorizedForToolError`, `FailedResponseFormatError`, `FailedInTransformError`
- `GetResult`, `PostResult`, `HandleResultResponse` (JsonResultHttpRequest) — `Result`/`ResultOf<T>` contract handling
- Errors: `InvalidResultFormatError`, `InvalidResultStateError`

## @webmdhs/react-loading-component

- `Receiver<T>` — manages load state/data for a long-running task: `Start`, `Received`, `Failed`, `Reset`, `Data`
- `ReceiverQueue` — throttled loading of many receivers: `TryLoad`, `Dispose`
- `ReceiverQueueItem<T>`
- `LoadState` — enum: `NotStarted`, `Loading`, `Received`, `Failed`, `Unloaded`
- `DetermineLoadState` — `Default`, `FindCountsByState`
- `Loading` (`LoadingComponent`) — React switch component for rendering by receiver state
- `isBusy`
