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

When suggesting `HasString`, always include the import statement `import { HasString } from "@webmdhs/general-data-structures";` if it is not already present in the file.
