# AI Rule Manager

A development workspace for creating and organizing AI interaction rules and packs for use with [rulebook-ai](https://github.com/botingw/rulebook-ai). This repository lives at `~/.ai-rule-manager` and generates rulebook-ai compliant packs that can be directly consumed from other projects.

## Installation

### 1. Install rulebook-ai
```bash
pip install git+https://github.com/botingw/rulebook-ai.git
```

### 2. Clone this repository to your home directory
```bash
git clone https://github.com/jerturowetz/ai-rules-manager.git ~/.ai-rule-manager
cd ~/.ai-rule-manager
```

## Quick Start

**One-command setup and sync:**
```bash
# Complete setup: install dependencies, generate packs, sync to rulebook-ai
./setup-and-sync.sh

# Preview what would be done without making changes
./setup-and-sync.sh --dry-run
```

## How It Works

This system integrates with rulebook-ai to provide a complete rule management workflow:

1. **Development**: Create and organize rules in `ai-rules/`
2. **Packaging**: Generate rulebook-ai compliant packs in `ai-packs/`  
3. **Installation**: Add packs to rulebook-ai pack library
4. **Consumption**: Apply packs to projects using `rulebook-ai project sync`

### Integration with Rulebook-AI

- **Pack Generation**: Automatically creates packs with proper numeric prefixes required by rulebook-ai
- **Local Installation**: Use `rulebook-ai packs add local:./ai-packs/pack-name` to install your custom packs
- **Project Usage**: Apply packs to any project with `rulebook-ai project sync`

### Current Architecture (organized for pack generation)

```
ai-rules-manager/
├── INBOX/
│   └── (staging area for new rules)
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


## Workflow

### Automated (Recommended)
```bash
# One command does it all: generate packs + sync to rulebook-ai
./setup-and-sync.sh
```

### Manual Steps
1. **Capture new rules**: Drop new rules in `INBOX/` for quick capture
2. **Process INBOX**: Regularly review and move rules from `INBOX/` to `ai-rules/`
3. **Edit rules**: Refine and organize rules in `ai-rules/`
4. **Generate & sync**: Run `./setup-and-sync.sh` or individual scripts:
   - `scripts/generate-packs.sh` - Create rulebook-ai compliant packs
   - `scripts/add-packs.sh` - Sync all packs to rulebook-ai
5. **Use in projects**: Apply to any project with `rulebook-ai project sync`

## Commands

### Pack Generation
```bash
# Generate all packs from rule directories
scripts/generate-packs.sh

# Preview what would be generated (safe, no changes)
scripts/generate-packs.sh --dry-run

# Generate only a specific pack
scripts/generate-packs.sh --pack-name foundation
```

### Rulebook-AI Integration
```bash
# Sync ALL generated packs to rulebook-ai (recommended workflow)
scripts/add-packs.sh

# Preview what would be synced without making changes
scripts/add-packs.sh --dry-run

# Add a single pack manually
rulebook-ai packs add local:./ai-packs/foundation-pack

# List available and installed packs
rulebook-ai packs list
rulebook-ai packs status

# Apply packs to a project (run in project directory)
rulebook-ai project sync
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

## Future Enhancements

### TODO: Rulebook-AI Integration
- [ ] **Centralized pack registry**: Create a central list/registry of available packs from this collection
- [ ] **Rulebook-ai project sync**: Integrate with rulebook-ai's pack system for project-specific deployment
- [ ] **Profile management**: Enable rulebook-ai profiles to selectively activate packs per project
- [ ] **Pack versioning**: Version packs so projects can pin to specific rule versions
- [ ] **Dependency management**: Handle pack dependencies and conflicts automatically
- [ ] **Community sharing**: Make packs shareable through rulebook-ai's community system

## Documentation

### Official Resources
- **Rulebook-AI Repository**: https://github.com/botingw/rulebook-ai
- **"Hidden" Documentation**: https://github.com/botingw/rulebook-ai/tree/main/memory/docs/
  
  ⚠️ **Note**: These docs may be incomplete or out of date, but they contain the recommended structure specifications that this project follows.

### Setup Script Features
The `setup-and-sync.sh` script provides zero-configuration automation:
- **Dependency Management**: Automatically installs uvx and rulebook-ai if missing
- **Smart Updates**: Updates existing rulebook-ai installation to latest version
- **Complete Workflow**: Generates packs + syncs to rulebook-ai in one command
- **Safety First**: Includes `--dry-run` mode and `--skip-install` for testing

### Pack Structure Requirements
This project generates packs that comply with rulebook-ai's pack structure spec:
- Rule files must have numeric prefixes: `01-rule-name.md`, `02-another-rule.md`
- Packs must contain `manifest.yaml`, `README.md`, and `rules/01-rules/` directory
- All requirements are automatically handled by the generation scripts

## Integration Workflow

Use this rule development workspace → Generate compliant packs → Install via rulebook-ai → Deploy to specific projects with selective pack activation.

## Notes

- This repository focuses on organizing YOUR custom rules and turning them into rulebook-ai compliant packs
- Generated packs include proper numeric prefixes and structure required by rulebook-ai
- Use `rulebook-ai packs add` to install community packs alongside your custom ones
- All pack generation follows the official rulebook-ai pack structure specification
