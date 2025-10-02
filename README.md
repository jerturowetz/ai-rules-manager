# AI Rules Manager

A development workspace for creating and organizing AI interaction rules and packs for use with [rulebook-ai](https://github.com/botingw/rulebook-ai). This project is for rule development, not deployment — it organizes your rules locally before deploying them to OTHER projects.

## Methodology

This project separates **development** from **deployment**:
- Develop rules in `ai-rules/`
- Organize packs in `ai-packs/`
- Deploy using `scripts/sync.sh` to `~/.ai-rules` and `~/ai-packs`

### Current Architecture (organized for pack generation)

```
ai-rules-manager/
├── ai-rules/
│   ├── global/
│   │   ├── foundation/
│   │   ├── development-standards/
│   │   ├── workflow/
│   │   └── tool-config/
│   └── domains/
│       ├── tech-python/
│       ├── tech-wordpress/
│       ├── tech-astro/
│       ├── context-product/
│       ├── context-privacy/
│       └── context-ai-testing/
├── ai-packs/
│   └── foundation-pack/
│       ├── manifest.yaml
│       ├── README.md
│       └── rules/01-rules/
└── scripts/
    └── sync.sh
```

### Deployment Targets

- `ai-rules/` → `~/.ai-rules` (only rule files; dev files are excluded)
- `ai-packs/` → `~/ai-packs` (pack collections consumable by rulebook-ai)

## Workflow

1. Edit rules in `ai-rules/`
2. Build packs under `ai-packs/`
3. Preview changes with `scripts/sync.sh --dry-run`
4. Deploy with `scripts/sync.sh`

## Commands

```bash
# Preview changes without applying
scripts/sync.sh --dry-run

# Deploy all changes
scripts/sync.sh

# Sync only rules (skip packs)
scripts/sync.sh --no-packs

# Sync only packs (skip individual rules)
scripts/sync.sh --no-rules
```

## Pack Generation

### Auto-Generate Packs from Rule Directories

```bash
# Generate all packs from organized rule directories
scripts/generate-packs.sh

# Preview what would be generated (safe, no changes)
scripts/generate-packs.sh --dry-run

# Generate only a specific pack
scripts/generate-packs.sh --pack-name foundation
scripts/generate-packs.sh --pack-name development-standards
```

The script automatically:
- Scans `ai-rules/global/` and `ai-rules/domains/` subdirectories
- Creates a pack for each directory containing rules
- Generates `manifest.yaml` with rule metadata
- Creates descriptive `README.md`
- Copies all rule files to proper pack structure

### Manual Pack Development

For custom packs:
```bash
mkdir -p ai-packs/my-custom-pack/rules/01-rules
vi ai-packs/my-custom-pack/manifest.yaml
vi ai-packs/my-custom-pack/README.md
cp ai-rules/global/foundation/communication-style-direct.md ai-packs/my-custom-pack/rules/01-rules/
```

## Notes

- This repo intentionally avoids auto-installing rulebook-ai community packs
- We focus on organizing YOUR rules and turning them into packs
- The sync script excludes `.DS_Store`, README/NOTES, and manifest files from deployment
