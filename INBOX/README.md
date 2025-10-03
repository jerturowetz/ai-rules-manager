# INBOX

This directory serves as a staging area for new AI rules that haven't been properly categorized yet.

## Purpose

- **Quick capture**: Drop new rule files here without having to immediately decide on their proper organization
- **Review queue**: Periodically process items in the INBOX to move them to their proper locations
- **Experimentation**: Test new rules before committing to their final structure

## Workflow

1. **Add new rules**: Drop `.md` files here when you have a new rule idea or receive rules from other sources
2. **Review regularly**: Periodically go through INBOX items to:
   - Move completed rules to `ai-rules/global/` or `ai-rules/domains/`
   - Refine or combine similar rules
   - Delete rules that are no longer needed
3. **Keep it clean**: The INBOX should be regularly emptied - it's a temporary staging area, not permanent storage

## Processing Guidelines

When processing INBOX items:
- **Global rules** (apply to all projects) → `ai-rules/global/`
- **Domain-specific rules** (tech stack, context-specific) → `ai-rules/domains/`
- **Experimental rules** → Keep in INBOX until refined
- **Duplicate/outdated rules** → Delete or consolidate

## Notes

- All files in INBOX are tracked in git (no gitignore)
- Use descriptive filenames when adding items
- Consider adding a brief note about the rule's intended purpose in the filename or as a comment