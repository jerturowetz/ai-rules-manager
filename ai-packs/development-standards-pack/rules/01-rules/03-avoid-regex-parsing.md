---
id: avoid_regex_parsing
scope: global
category: code_quality
description: "Never use regular expressions for parsing structured text formats"
tools_excluded: []
---

# Avoid Regex for Structured Data Parsing

Never use regular expressions for parsing or transforming structured text formats (like Markdown, HTML, JSON, YAML, or code).

Always use well-maintained, officially supported libraries that are purpose-built for the format you're working with.

## Examples

✅ **DO USE:**
- `remark` to modify Markdown documents
- `turndown` (mixmark-io) to convert HTML to Markdown
- YAML parser to handle frontmatter
- JSON.parse() for JSON data
- DOM parser for HTML manipulation

❌ **AVOID:**
- `text.replace(/#+ (.+)/g, ...)` to parse headings
- `htmlString.match(/<h[1-6]>(.*?)<\/h[1-6]>/g)` for DOM parsing
- Regex patterns for extracting YAML frontmatter
- Complex regex for code parsing

## Why This Matters

- **Reliability**: Regex is brittle and error-prone when applied to structured formats
- **Readability**: Parser libraries make your intent clearer to collaborators
- **Maintainability**: Purpose-built libraries handle edge cases and evolution of formats
- **Bug Prevention**: Reduces risk of subtle parsing errors and security vulnerabilities

## When Regex Is Appropriate

Regex should be used for:
- Simple string validation (email format, phone numbers)
- Find-and-replace operations on plain text
- Pattern matching in unstructured text
- Log parsing for specific known patterns