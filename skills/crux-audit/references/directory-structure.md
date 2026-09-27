# Directory Structure

Replace the loose global wildcard (`"paths": { "*": ["*"] }`) with a scoped prefix alias (e.g. `"@/*": ["./src/client/*"]`) under `moduleResolution: "Bundler"`. Mirror the same prefix in Webpack `resolve.alias` so runtime resolution matches TypeScript. This prevents TS from crawling `node_modules`, config dirs, and build artifacts during module resolution.

Isolate the Node server in `server/` and point `package.json` `main` at it.

Group files by type-suffix (`…AdminDetails.ts`, `…AdminEditor.tsx`) in `<Feature>/<TypeName>/` (e.g. `ProgramCriteria/AdminDetails/`).
