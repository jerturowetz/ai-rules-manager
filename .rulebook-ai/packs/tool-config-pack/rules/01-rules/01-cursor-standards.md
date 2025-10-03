---
id: cursor_standards
scope: domain
category: tooling
description: "Standards for Cursor IDE configuration and rules organization"
domains: ["cursor", "ide", "tooling", "configuration"]
tools_excluded: []
---

# Cursor IDE Standards

Configuration standards and best practices for working with Cursor IDE.

## Rules Directory Structure

- Place Cursor rules files in the `.cursor/rules/` directory
- **Do not** use `cursorrules` or other non-standard directory names
- Organize rules by domain or functionality when you have multiple rule files
- Use descriptive filenames that clearly indicate the rule's purpose

## Examples

✅ **Correct directory structure:**

    .cursor/
      rules/
        general.md
        typescript.md
        testing.md

❌ **Avoid these patterns:**

    cursorrules/          # Wrong directory name
    .cursorrules/         # Wrong directory name
    .cursor/cursorrules   # Wrong nested structure

## File Organization

- Keep rules focused and specific to avoid conflicts
- Use clear, descriptive rule names
- Group related rules together in the same file
- Separate language-specific rules from general coding standards

## Best Practices

- Regularly review and update Cursor rules to match project evolution
- Test rules with actual code to ensure they work as expected
- Document any custom rules that team members should be aware of
- Keep rules version controlled with the rest of your project configuration