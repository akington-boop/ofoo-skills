# String Checks

Use `HasString` (`@webmdhs/general-data-structures`) for non-empty string guards.

```ts
import { HasString } from "@webmdhs/general-data-structures";

HasString(str)           // CORRECT
str != null && str.length > 0  // WRONG
!!str                          // WRONG
str?.length > 0                // WRONG
str !== null && str !== undefined && str.length > 0  // WRONG
str !== ""                     // WRONG
```

`HasString` is imported from `@webmdhs/general-data-structures`.
