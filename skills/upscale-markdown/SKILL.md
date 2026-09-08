---
name: upscale-markdown
description: Use when asked to add, choose, or decorate emoji for Markdown section headings in a README, report, or other Markdown document. Applies semantic emoji only to undecorated H2 and H3 ATX headings while preserving all other content exactly; accepts a file path or pasted Markdown.
---

Decorate Markdown section headings with semantically appropriate emoji. This is a formatting-only pass: do not alter wording, code, links, lists, tables, whitespace, or any non-heading content.

## Determine the input

1. If the request includes a Markdown file reference (for example, `@README.md` or `docs/report.md`), read that file and edit that same file in place. Do not print the full document.
2. Otherwise, if the request includes pasted Markdown, return the complete decorated text in a `markdown` fenced code block. Do not create or edit a file.
3. If neither is present, ask for a Markdown file or pasted Markdown.

Treat an explicit file reference as the input even when the request also contains explanatory prose. If several file references are present and the target is unclear, ask which file to process.

## Decorate headings

Work line by line. A candidate is an ATX heading that begins at column 1 with exactly two or three `#` characters followed by whitespace. Do not treat these as candidates:

- H1 headings, H4-H6 headings, Setext headings, block quotes, list content, or text inside fenced code blocks.
- A heading whose text already begins with an emoji or other pictographic symbol.
- A generic or ambiguous heading such as `Details` or `Notes` when no universally recognized semantic emoji fits.

For each candidate, insert one chosen emoji and exactly one ASCII space after its hash markers. Preserve the heading text, optional closing `#` markers, and every other character exactly.

```markdown
## Installation
### Data Analysis ###
```

becomes:

```markdown
## 📦 Installation
### 📊 Data Analysis ###
```

Use the document's headings to infer its type: installation, usage, and repository-maintenance language indicates a README; objectives, methodology, findings, and references indicate a report. Prefer the matching vocabulary below. Match equivalent wording and natural variants, not only exact phrases. When no listed term applies, choose the closest universally recognized emoji only when the heading's meaning is clear.

| Context | Meaning | Emoji |
| --- | --- | --- |
| README | Overview, summary | 📌 |
| README | Roadmap | 🗺️ |
| README | Contributors | 👥 |
| README | License | 📄 |
| README | Getting started, quick start | 🚀 |
| README | Installation, setup | 📦 |
| README | Configuration, settings | ⚙️ |
| README | Usage, how to use | 🛠️ |
| README | Architecture, design | 🧬 |
| README | Benchmarks, performance | 📊 |
| README | Testing, tests | 🧪 |
| README | Security | 🛡️ |
| README | Contributing | 🤝 |
| README | Acknowledgments, thanks | 🙌 |
| README | Support, help, FAQ | 💬 |
| Report | Objectives, goals | 🎯 |
| Report | Background, context | 📖 |
| Report | Executive summary | 📝 |
| Report | Methodology, methods | 🔬 |
| Report | Data analysis, analysis | 📊 |
| Report | Limitations | 📉 |
| Report | Key findings, findings, results | 💡 |
| Report | Recommendations | ✅ |
| Report | Future outlook, next steps | 🔮 |
| Report | References, bibliography | 📚 |
| Report | Appendix, appendices | 📎 |

## Validate before responding

Before writing or returning the result, check that:

- Every changed line is an eligible H2 or H3 outside a fenced code block.
- Each changed line has exactly one inserted emoji followed by one space after the opening hash markers.
- No existing emoji-prefixed heading was changed.
- The input and output differ only at inserted heading prefixes.

For file input, report a brief summary naming each changed heading and its emoji. If nothing changed, say so. For pasted Markdown, output only the fenced result unless the user asked for commentary.