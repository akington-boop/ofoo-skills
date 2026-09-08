# upscale-markdown

Decorates Markdown section headings with semantically matched emoji so READMEs and reports scan faster. It is a formatting-only pass: wording, code, links, lists, tables, and document structure remain unchanged.

## 📌 What It Does

- Adds one fitting emoji to eligible undecorated H2 and H3 headings.
- Leaves H1 headings, H4-H6 headings, already-decorated headings, generic headings without a clear match, and all non-heading content unchanged.
- Uses README vocabulary such as Overview, Installation, Usage, Testing, and Contributing, or report vocabulary such as Objectives, Methodology, Findings, and References.
- Uses a clear, universally recognized fallback emoji for other unambiguous headings.

## 🔍 Heading Rules

The skill decorates only ATX headings that start at column 1 with exactly `##` or `###` followed by whitespace. It skips headings in fenced code blocks, block quotes, lists, and Setext-style headings.

```markdown
## Installation
### Data Analysis ###
```

becomes:

```markdown
## 📦 Installation
### 📊 Data Analysis ###
```

## 🚀 When To Use It

- You have written or restructured a README, plugin document, or report and want its section headings decorated before committing.
- You want consistent semantic heading emoji without choosing each one manually.

It is not for prose or content edits; it changes only eligible heading prefixes.

## 🛠️ Usage

Provide either a file reference or pasted Markdown.

**File reference**

```text
/upscale-markdown @README.md
```

The skill reads the referenced Markdown file, edits it in place, and reports a short list of the changed headings and their emoji. With more than one possible target file, it asks which file to process.

**Pasted Markdown**

```text
/upscale-markdown

## Installation
## Usage
```

The skill returns the full decorated Markdown in a `markdown` fenced code block and does not write a file.

## ✅ Guarantees

- Exactly one ASCII space separates the inserted emoji from the heading text.
- The emoji appears after the heading's `#` markers.
- Existing heading text and optional closing `#` markers are preserved.
- Before returning a result, the skill checks that only eligible heading prefixes changed.