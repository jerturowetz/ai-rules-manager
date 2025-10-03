---
id: pr_summary_standards
scope: global
category: workflow
description: "Structured pull request summaries with emoji titles and issue-first sourcing approach"
tools_excluded: []
---

# Pull Request Summary Standards

Write short, goal-based PR summaries with emoji titles that help reviewers understand context and changes. Never repeat the diff content.

## Title Format

PR titles must start with an emoji prefix:

- 🌪 **New value** · new feature or major addition
- 💨 **Enhancement** · improvements to existing features
- 🧰 **DevX** · developer tooling/workflow changes
- 💡 **KTLO** · routine maintenance/operations
- 🚑 **Hotfix** · urgent critical fix
- 🐛 **Defect** · bug fix for live features

**Example title:**
`💨 Speed up CI by caching pnpm store`

## Content Guidelines

### No Screenshots, Links, or Feature Flags
- Keep summaries text-only for clarity
- Avoid external dependencies in PR descriptions
- Focus on the essential information

### Sourcing Rule for AI
- **If an issue exists**: Read the issue first, then scan code changes, then write the summary
- **If no issue**: Infer intent from the code changes

## Required Structure

### Top Line (Issue Reference)
- If closing an issue: `closes #123`
- If related only: `relates to #123`

### Three-Section Format

**Goal:** Why this PR exists (1–2 sentences)
**Scope:** High-level description of what changed (not the diff details)  
**How to test:** Steps reviewers can follow, with expected result

## Example Summary

```
closes #123

**Goal:** Reduce CI time to under 8 minutes by caching dependencies.
**Scope:** Add `actions/cache` keyed to lockfile; no app logic changes.
**How to test:** Push branch, confirm cache restore in install step, total job < 8 minutes.
```

## What NOT to Include

- **Don't repeat the diff** - reviewers can see file changes
- **Don't include rationale** - that goes in the issue or commit messages
- **Don't list every file changed** - focus on the high-level impact
- **Don't include implementation details** - stick to the "what" and "why"

## AI Assistant Guidelines

When helping write PR summaries:

1. **Always check for linked issues first** - read the full issue context
2. **Scan the code diff** - understand the technical changes
3. **Focus on business impact** - why does this matter to the team/product?
4. **Keep it scannable** - busy reviewers need quick context
5. **Make testing actionable** - provide specific steps, not vague suggestions