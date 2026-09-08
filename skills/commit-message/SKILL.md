---
name: commit-message
description: Use when asked to draft or generate a Git commit message, especially from staged changes or via /commit-message. Inspects only the staged diff and returns a concise message, optionally prefixed with an issue ID; it never stages files or creates a commit.
---

# Commit Message

Draft a Git commit message from the currently staged changes.

## Inspect the staged change

1. Confirm the current directory is a Git repository. If it is not, say so and
   stop.
2. Run `git status --porcelain` to confirm that changes are staged. If no
   staged changes exist, report that there is nothing staged to summarize and
   stop.
3. Inspect `git diff --cached --stat` and `git diff --cached`. Read relevant
   surrounding files only when the diff does not establish the intent.

## Draft the message

1. Use an issue ID from the user's request when one is provided, such as
   `ABC-123` or `for ABC-123`. Do not invent or infer an issue ID.
2. Write a concise imperative subject that explains the purpose of the change,
   not just implementation mechanics. Prefer the user- or developer-visible
   outcome when the diff supports it.
3. Use one of these formats:

   ```text
   ABC-123 | Add validation for missing account IDs
   Add validation for missing account IDs
   ```

4. Add a short body only when one subject line cannot accurately explain the
   change. Wrap body text clearly and separate it from the subject with a blank
   line.
5. Do not claim behavior, motivation, or impact that the staged diff does not
   demonstrate.

## Report

Render the proposed commit message in a fenced `text` block with no extra
alternatives unless the staged changes support genuinely distinct messages.
Never run `git add` or `git commit`; only the user chooses whether to stage or
commit the work.