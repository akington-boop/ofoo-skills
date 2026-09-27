# Async Patterns

## async-vs-then
Use `await` when a later step depends on the result. Use `.then`/`.catch`/`.finally` only for outcome-independent teardown (e.g. clearing a timer regardless of success/failure). Never mix paradigms in one function — no `.then`/`.catch` after an `await` in the same `async` function.
