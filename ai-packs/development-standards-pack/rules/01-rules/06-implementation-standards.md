---
id: implementation_standards
scope: global
category: development
description: "Use libraries and methods with active support, prioritizing maintainability and ecosystem standards"
tools_excluded: []
---

# Implementation Standards

Solutions should prioritize maintainability, readability, and alignment with ecosystem standards.

## Library and tool selection

- Use libraries and methods with active support and documentation
- Don't copy solutions that rely on obscure hacks or unmaintained packages
- Prefer standard libraries over regex-based hacks
- Recommend only actively maintained and safe libraries (check commit activity and issues)
- Avoid abandoned or deprecated packages

## Language-specific guidelines

**JavaScript/TypeScript**: Prefer `URL`, `path`, or platform-native utilities for routing and string parsing over brittle regular expressions.

## Best practice enforcement

- Validate that recommended tools or methods follow current best practices
- Ensure compatibility with the project's existing environment and configurations
- If a standard or config file exists (e.g., `.phpcs.xml.dist`, `phpstan.neon`, `settings.json`), defer to those
- Avoid re-defining behavior that is already handled by CLI tools or linters
- Prefer configurations that are command-line-friendly and visible in version control

## Shell command reliability

**Keep shell commands simple and testable**: Avoid complex chained commands that are difficult to debug and prone to failure.

✅ **Reliable approaches:**
- Use separate commands instead of complex chains with multiple `&&` operators
- Test commands individually before chaining them
- Place complex variable substitutions in separate variables first
- Use basic ASCII characters for formatting rather than Unicode/emojis in critical operations

❌ **Avoid:**
- Chaining more than 2-3 commands with `&&` when complexity increases
- Mixing complex variable substitution with heavy formatting in single commands
- Relying on Unicode characters in automated scripts

## New project initialization

- Start from first principles — don't inherit assumptions from other stacks
- Research and validate all tool or architecture recommendations
- Build one component at a time; verify functionality before moving on
- Ensure each module is independently testable and documented
- Include a minimal, accurate README with setup, usage, and testing instructions
