# Complexity and Refactoring

Flag a class or file handling multiple unrelated concerns (single-responsibility violation) as a refactor candidate instead of accreting more logic onto it.

Investigate a method when cognitive complexity exceeds 15 or cyclomatic complexity exceeds 10. These are review triggers, not automatic extraction requirements; use the single-responsibility audit to determine whether refactoring is warranted.

Before refactoring, audit the target for extractable sub-concerns and estimate each sub-concern's complexity.

Proposal format required before extraction:

1. Sub-concern and estimated complexity
2. The new class's interface and dependency-injection plan
3. How testability improves without breaking the original class's private encapsulation

Present the extraction proposal and wait for approval — do not extract or refactor files unprompted.

Once approved, extract the sub-concern via composition, not inheritance. Use the dependency boundary defined in [component-architecture.md](component-architecture.md) for new or extracted logic classes.
