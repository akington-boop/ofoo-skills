# Language Idioms

See [string-checks.md](string-checks.md) for the canonical string-presence check.

Use `Dictionary<T>` from `@webmdhs/general-data-structures` instead of `Record<string, T | undefined>` when keys are strings and values are `T | undefined`.
