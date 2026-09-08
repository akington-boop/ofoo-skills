# commit-message

Drafts a concise Git commit message from the currently staged changes. It can
prefix the subject with an issue ID supplied in the request:

```text
ABC-123 | Add validation for missing account IDs
```

## What it does

The skill checks the staged status and inspects `git diff --cached` before
writing a message that explains the purpose of the change. It reports when
nothing is staged and does not guess an issue ID.

## Usage

Use `/commit-message` to draft a message, or include an issue ID:

```text
/commit-message ABC-123
```

The skill only proposes text in chat. It never runs `git add` or `git commit`.