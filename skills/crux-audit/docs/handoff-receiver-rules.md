# Handoff: Receiver rules and page-component pattern (BulletinAdmin / Bulletin / SponsorPosts)

Repo: `~/build/ui-home`, branch `feature/cxp-bulletin-setup`. Research only; **nothing has been edited**, no `CONTEXT.md` exists, no ADR changed.

## Next session focus
Turn the two research goals below into a written rule set (and then stories). The user wants to standardize:
1. **Load methods** across services: use `Receiver` + `<Loading>` from `@webmdhs/react-loading-component` where possible.
2. **Page component pattern**: follow the Personas shape across BulletinList and BulletinEditor; do **not** force `<BulletinList/>` > `<BulletinListView list={list} />` (hook-returns-flat-bag into pure view).

## Key finding: ADR 0005 is stale
`BulletinAdmin/docs/adr/0005-react-loading-component-no-abort-no-upgrade.md` (June 2026) says the project is pinned to react-loading-component **1.0.2** and cannot get abort. `package.json` declares `^1.4.1` (+ `rereactor ^3.0.0`, `reactor ^4.3.0`) and 1.4.1 is installed. `Receiver.Start(promise?: (abortController?) => Promise<T>, isBackgroundRefresh?)` already supports abort. The ADR's premise no longer holds.

## Load inventory (all under `src/client/`)
| Where | Today | Verdict |
|---|---|---|
| `BulletinAdmin/BulletinList/BulletinListService.ts`, `BulletinAdmin/Personas/PersonasService.ts` | `Load(): void` -> `Receiver.Start(() => this.LoadX())`, `<Loading>` in view | Target pattern |
| `Bulletin/BulletinService.ts` | `Receiver` + `AllReceiverQueueItems` + `RetryLoad` | Conforms. Minor: `RetryLoad` passes `this.LoadCards`, `Load` passes `() => this.LoadCards()` |
| `BulletinAdmin/BulletinEditor/BulletinEditorService.ts` `Load(id)` | `async`, `Promise.all` of 4 calls, hand-rolled `FormData = null` + `HasLoadError`, no stale-`Load` guard | Candidate for `Receiver` |
| `BulletinAdmin/BulletinEditor/BulletinImageUploader.ts` `Load(id)` | `async`, no error state; failure bubbles via editor `Promise.all` | See "Undecided" |
| `BulletinAdmin/MemberGroups/MemberGroupStore.ts`, `BulletinAdmin/PublishSettings/BulletinMetadataStore.ts` | Singleton `Promise<void>` caches with in-flight dedupe; `IsLoading` (+ `LoadErrorMessage` on MemberGroupStore) observables not read outside the stores (tests not checked) | Stay promise-returning (composed into other Receivers' fetchers); candidate to delete the unread flags |
| `SponsorPosts/SponsoredPostsBulletinProvider.tsx`, `Community/...`, `Content/...` `Load(): Promise<T[]>` | Pure fetchers consumed by `BulletinService`'s Receiver | Already fit, no change |

Proposed rule (agreed in principle): a **page-level service owns one `Receiver<T>` per page load and exposes `Load(): void` calling `Start`**; stores/providers remain promise-returning fetchers.

## Decisions made (don't re-litigate)
- **`BulletinCreate`** (hand-rolled idle/pending/error, one-shot create+navigate) is an **exception**, out of the standard.
- **`BulletinPreviewService.IsLoading`** (debounced preview refresh) is an **exception**, out of the standard.
- **Uploader row state stays a per-row state machine, not a Receiver.** Reasons (verified in `node_modules/@webmdhs/react-loading-component/lib/Receiver.js`): `Failed()` nulls `ReceivedData` (a failed poll tick would wipe the list; today `BulletinImageUploader.ts` swallows transient poll errors); `Start` no-ops while `IsBusy` (concurrent uploads/deletes would drop); rows mix server data with client-only state (uploading, Failed, IsDeleting, `PollDeadlines`); `Polling` spans many requests and ADR-0008 deliberately made it one shared poll loop; `Uploader.IsBusy` = Loading||IsDeleting (excludes Polling) differs from `Receiver.IsBusy`; the panel never switches whole-view by state. `isBackgroundRefresh` (`Start(fn, true)` skips `Loading` when already `Received`) exists but only helps a whole-list snapshot refresh, not the rows. Rule of thumb: **Receiver for single-result load operations; per-row state machine for ongoing per-item operations.**

## Undecided (user chose to leave out for now)
- Whether the editor's initial image list loads **inside** the page `Receiver` (today: image fetch failure = whole-page error) or in **its own** `Receiver<ImageRow[]>` in the asset manager (form renders sooner; save/publish must then be gated on that receiver's `IsBusy` or `isUploadingMedia`).
- Whether the editor becomes `Receiver<BulletinEditorFormData>` (fetcher returns `new BulletinEditorFormData(post)`; would remove `HasLoadError`, `FormData === null` spinner, `isEditorReady`, and the `noErrors` Computed in `BulletinEditor.tsx`; Receiver's stale-promise ignoring would likely fix the `Load(A)`/`Load(B)` race, untested).
- Whether to supersede ADR 0005 (edit/supersede note: 1.4.1 + rereactor 3 already in use, abort available but unused).
- One story or two (Load standardization vs component pattern).
- Glossary terms, no `CONTEXT.md` written: "Service" (page-scoped, per mount) vs "Store" (singleton cache); what "View" means (Personas: shell taking a service; BulletinList: pure props renderer); name of the page-level component once the hook is gone.

## Component pattern findings
- **Personas (reference):** `Personas.tsx` (18 lines) builds the service, `useEffect(() => service.Load())`, renders `PersonasView service={service}`. View uses `<Loading>`; leaves `PersonasSearch`/`PersonasTable` call `useObservable` themselves.
- **BulletinList:** `useBulletinList()` (~30-field flat result incl. `postsReceiver`, `retry`) -> `BulletinListView list={list}`. Row-menu anchor, `selectedPost`, no-permission message are `useState` in the hook and would need to move into a service or leaf (`BulletinListRowActionsMenu`).
- **BulletinEditor:** `useBulletinEditor(id)` (~40 fields) -> `BulletinEditorView editor hasFieldErrors`. Focus registry + `OnValidationFailed` wiring live in the hook (the `useFocusRegistry` extraction already noted in the CXP-4570 handoff).
- **PersonaCreate:** hybrid (`usePersonaCreate` returns `persona: service.Persona`).
- Tests: `Personas.test.tsx` is page-level; `useBulletinEditor.test.ts` (72 lines) tests the hook and would move.

## Related artifacts (not duplicated here)
- `~/work-tracker/10_stories/CXP-4570/handoff-usepersonas-three-concerns.md` (leaf-subscription split, `TableModel` dedupe, `useFocusRegistry`, dialog-state follow-ups)
- `~/work-tracker/10_stories/CXP-4570/CXP-4570-refactor-usepersonas-spec.md`
- `~/work-tracker/10_stories/refactor-use-bulletin-editor/{spec,handoff,handoff-service-ports}.md`
- ADRs in `~/build/ui-home/src/client/BulletinAdmin/docs/adr/` (0005 Receiver, 0008 image uploader)
- `~/build/ui-home/src/client/BulletinAdmin/CLAUDE.md` (isolation boundary: no sibling-folder imports except SponsorPosts/Community/Content per ADR-0007)

## Suggested skills
- `domain-modeling` (resolve the glossary terms, write `CONTEXT.md`/ADR supersede if warranted)
- `grilling` (stress-test the Undecided items before committing)
- `codebase-design` (seam/deep-module vocabulary for the service/hook/view split)
- `tdd` once a direction is chosen and implementation starts

## Repo conventions
`npm run typecheck`, `npm run lint -- --fix`, `npm run quick-test`; no `npx`. Before editing `**/*.{ts,tsx}`, read `~/.claude/skills/crux-audit/references/INDEX.md` and follow its routing table.
