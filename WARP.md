# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is **AI Rules Manager** - a development workspace for creating and organizing AI interaction rules and packs for use with [rulebook-ai](https://github.com/botingw/rulebook-ai). This project is for **rule development**, not deployment - it organizes your rules locally before deploying them to OTHER projects.

## Core Architecture

The system follows a **development → organization → pack creation** pattern:

```
ai-rules-manager/
├── ai-rules/           # Development workspace for individual rules
│   ├── global/         # Universal rules (communication, code standards, workflow)
│   ├── domains/        # Technology-specific rules (Python, WordPress, Astro, etc.)
│   ├── manifest.json   # Rule catalog and metadata
│   └── README.md       # Rule documentation
├── ai-packs/           # Development workspace for thematic rule collections
├── scripts/sync.sh     # Deployment utility (rsync with --delete)
└── .rulebook-ai-ignore # Prevents auto-installation of community packs
```

**Key Design Principles:**
- **Separation of concerns**: Development files vs. deployed files
- **Atomic deployments**: All-or-nothing sync with rollback capability
- **Version control**: Full git tracking of rule evolution
- **Pack organization**: Rules grouped into reusable, shareable collections

## Common Development Commands

### Sync Operations (Primary Workflow)
```bash
# Preview changes without applying (safe exploration)
scripts/sync.sh --dry-run

# Deploy all changes to ~/.ai-rules and ~/ai-packs
scripts/sync.sh

# Deploy only individual rules (skip packs)
scripts/sync.sh --no-packs

# Deploy only packs (skip individual rules)
scripts/sync.sh --no-rules
```

### Rule Development
```bash
# Add a new global rule
vi ai-rules/global/new-rule.md

# Add a domain-specific rule
vi ai-rules/domains/framework-specific.md

# Edit existing rule
vi ai-rules/global/communication-style-direct.md
```

### Pack Development
```bash
# Create new pack structure
mkdir -p ai-packs/my-project-pack/rules/01-rules
vi ai-packs/my-project-pack/manifest.yaml
vi ai-packs/my-project-pack/README.md

# Move rules into pack
cp ai-rules/global/some-rule.md ai-packs/my-project-pack/rules/01-rules/
```


## Architecture Understanding

### Rule System Design
The project implements a **hierarchical rule system**:

1. **Global Rules** (`ai-rules/global/`): Universal patterns applied across all contexts
   - Communication style (direct, no-fluff, structured)
   - Problem-solving methodology (systematic debugging, thoroughness)
   - Code standards (formatting, simple solutions, regex avoidance)
   - Workflow practices (commit messages, PR summaries, source validation)

2. **Domain Rules** (`ai-rules/domains/`): Technology-specific guidance
   - Framework standards (WordPress, Python, Astro)
   - Specialized contexts (privacy compliance, product recommendations)
   - Tool configurations (Cursor IDE settings)

3. **Pack Collections** (`ai-packs/`): Thematic rule groupings for selective deployment
   - Foundation Pack: Core communication and thinking patterns
   - Development Standards Pack: Code formatting and validation
   - Framework Packs: Technology-specific collections
   - Project Packs: Client-specific rule sets


## Development Workflow

### Daily Development Process
1. **Edit rules** in `ai-rules/` or create **packs** in `ai-packs/`
2. **Preview changes** with `scripts/sync.sh --dry-run`
3. **Deploy** with `scripts/sync.sh`
4. **Test** changes with your AI assistant workflow
5. **Commit** to git for version control

### Rule Writing Standards
Follow the established metadata format:
```markdown
---
id: unique_rule_identifier
scope: global|domain
category: category_name
description: "Brief description of the rule's purpose"
domains: ["domain1", "domain2"]  # For domain-scoped rules only
tools_excluded: []               # Optional: tools this rule doesn't apply to
---

# Rule Title
[Content following established patterns with ✅ DO and ❌ DON'T examples]
```

### Pack Development Standards
Each pack requires:
- `manifest.yaml`: Pack metadata and rule inventory
- `README.md`: Purpose, usage, and philosophy
- `rules/01-rules/`: Actual rule files (zero-padded subdirectories)

### Integration with rulebook-ai
- **Deployment targets**: `ai-rules/` → `~/.ai-rules`, `ai-packs/` → `~/ai-packs`
- **Community integration**: Validate pack structure for sharing and importing
- **Protection**: `.rulebook-ai-ignore` prevents auto-installation of community packs

## Important Implementation Notes

### Safety Features
- **Dry-run capability**: Always test with `--dry-run` before deploying
- **Atomic operations**: rsync with `--delete` ensures clean deployments
- **Git tracking**: Full change history for rollback capability
- **Auto-install protection**: This project won't be treated as a deployment target

### File Organization Patterns
- **Single responsibility**: Each rule file focuses on one specific aspect
- **Consistent naming**: kebab-case for files, structured metadata headers  
- **Clear categorization**: Global vs domain scope clearly separated
- **Modular design**: Rules can be updated independently without conflicts

## Rulebook-AI Integration

This system is designed as a development environment for [rulebook-ai](https://github.com/botingw/rulebook-ai), which provides:
- **Multi-assistant deployment** (Claude, ChatGPT, Cursor, etc.)
- **Project-specific profiles** for selective rule activation
- **Community pack sharing** and importing
- **Validation and structure checking** for pack compatibility

The sync utility serves as a bridge between this development environment and the target deployment locations that rulebook-ai expects.