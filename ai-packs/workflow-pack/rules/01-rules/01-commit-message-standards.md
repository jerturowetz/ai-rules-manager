---
id: commit_message_standards
scope: global
category: workflow
description: "Use clear, conventional commit messages with emoji prefixes for consistent project history"
tools_excluded: []
---

# Commit Message Standards

Use clear, conventional, and actionable commit messages to maintain a high-quality project history. Keep commit messages short, clear, and imperative.

## Emoji Prefixes

Start each commit with one emoji:

- 🌪 **New value** · new feature or major addition
- 💨 **Enhancement** · improvements to existing features
- 🧰 **DevX** · developer tooling/workflow changes
- 💡 **KTLO** · routine maintenance/operations
- 🚑 **Hotfix** · urgent critical fix
- 🐛 **Defect** · bug fix for live features

## Format Rules

- Start with an emoji, then a short imperative summary
- Use **imperative mood**: e.g., "Add validation", not "Added validation"
- Focus on **what changed**, not why (rationale goes in PR description)
- Keep the subject line **≤50 characters**, capitalized, no trailing period
- Avoid repetition of filenames or context already evident in the diff
- Don't write rationale; keep messages short and practical

## Examples

**Good commit messages:**
- `🐛 Fix null check in webhook handler`
- `🧰 Speed up local dev with turbo cache`
- `💨 Simplify auth middleware branches`
- `🌪 Add CSV export for workspace reports`

**Bad commit messages:**
- `Updated commit message guidelines for clarity` (too verbose)
- `Fixed bug` (not specific)
- `Added new feature that does X Y and Z because we need it for the client` (too long, includes rationale)
- `fix: correct typo in dashboard label`
- `refactor: streamline auth middleware`
- `docs: add README install instructions`
