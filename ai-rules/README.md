# AI Rules System

A curated collection of AI interaction rules organized by scope and domain, designed to provide consistent, high-quality guidance for AI assistants across different contexts and technologies.

## Overview

This rules system follows the **single responsibility principle** - each rule file focuses on a specific aspect of AI interaction, from global communication standards to domain-specific technical requirements. Rules are structured with consistent metadata and clear formatting for easy reference and maintenance.

## Directory Structure

```
.ai-rules/
├── global/              # Universal rules that apply across all domains
│   ├── communication-style-direct.md
│   ├── systematic-problem-solving.md
│   ├── code-formatting-guidelines.md
│   ├── implementation-standards.md
│   ├── simple-solutions-principle.md
│   ├── list-formatting.md
│   ├── validate-sources.md
│   ├── tooling-parity.md
│   ├── avoid-regex-parsing.md
│   ├── commit-message-standards.md
│   ├── no-code-in-briefs.md
│   ├── be-thorough.md
│   ├── systematic-file-operations.md
│   └── pr-summary-standards.md
└── domains/             # Technology or context-specific rules
    ├── wordpress-standards.md
    ├── python-standards.md
    ├── astro-standards.md
    ├── cursor-standards.md
    ├── product-recommendations.md
    ├── privacy-compliance-context.md
    ├── ai-negative-testing.md
    └── task-brief-formats.md
```

## Rule Categories

### Global Rules (Universal Application)
These rules apply regardless of the specific technology or domain being discussed.

**Communication & Style:**
- Direct, professional communication without fluff
- Structured, scannable formatting for lists and documents
- Thorough analysis and complete task execution

**Code & Development:**
- Consistent code formatting and organization standards
- Logic definition at the top of functions/modules
- Simple solutions over complex workarounds
- Tool parity between CLI, IDE, and CI/CD
- Avoiding regex for structured data parsing

**Workflow & Process:**
- Systematic problem-solving and debugging protocols
- Standardized commit messages with emoji prefixes
- Structured pull request summaries
- Source validation for tool features and APIs
- Separating planning documents from implementation details

### Domain Rules (Specific Technologies)

**Development Frameworks & Tools:**
- **WordPress**: Security practices, coding standards, hooks/filters
- **Python**: Import organization, docstrings, error handling, environment setup
- **Astro**: Performance optimization, Starlight integration, content workflow
- **Cursor**: IDE configuration and rules organization

**Specialized Contexts:**
- **Product Recommendations**: Structured formatting with strict criteria adherence
- **Privacy Compliance**: OneTrust CMP and Segment integration context
- **AI Testing**: Negative testing methodology for AI system safety
- **Task Briefs**: Two-format system for structured vs. casual task descriptions

## Rule Structure

Each rule file follows a consistent format:

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

Brief introduction explaining the rule's purpose.

## Section Headers
- Use consistent formatting
- Provide clear examples with ✅ DO and ❌ DON'T patterns
- Include rationale when helpful
```

## Usage Guidelines

### For AI Assistants
1. **Check scope**: Apply global rules universally, domain rules only when relevant
2. **Layer appropriately**: Global rules provide the foundation, domain rules add specificity
3. **Validate sources**: Always confirm tool features and APIs against authoritative documentation
4. **Be systematic**: Use the problem-solving protocols for debugging and analysis
5. **Stay thorough**: Complete all parts of multi-step tasks and verify against requirements

### For Humans
1. **Add new rules thoughtfully**: Follow the single responsibility principle
2. **Maintain consistency**: Use the established metadata format and structure
3. **Update regularly**: Keep domain rules current with evolving technologies
4. **Document changes**: Update the manifest when adding, removing, or significantly changing rules

## Maintenance

This system is designed to be:
- **Modular**: Each rule can be updated independently
- **Scalable**: New domains and categories can be added without disruption
- **Discoverable**: Clear naming and categorization for easy reference
- **Consistent**: Standardized format across all rule files

## Pack Organization

This repository can be organized into **packs** - thematic collections of rules that can be selectively applied per project. Consider organizing rules into packs such as:

- **Foundation Pack**: Core communication and systematic thinking rules
- **Development Standards Pack**: Code formatting, implementation, and validation rules
- **Framework Packs**: Technology-specific rules (WordPress, Python, Astro, etc.)
- **Context Packs**: Specialized domain rules (privacy compliance, product recommendations, etc.)

Each pack would contain:
- `manifest.yaml` - Pack metadata and rule listing
- `README.md` - Pack purpose, usage guidance, and philosophy
- `rules/` - Directory containing the actual rule files

## rulebook-ai Integration

This rules collection is designed to work seamlessly with [rulebook-ai](https://github.com/botingw/rulebook-ai), which provides infrastructure for:

- **Rule Management**: Organizing, validating, and syncing rules across projects
- **AI Assistant Integration**: Deploying rules to multiple AI tools (Claude, ChatGPT, etc.)
- **Project Profiles**: Selective activation of rule packs per project
- **Community Sharing**: Access to community-maintained rule packs

### Key Documentation Resources

The rulebook-ai repository contains comprehensive documentation in the `memory/docs` folder:

- **User Guide** (`memory/docs/user_guide/`):
  - `rule_loading_summary.md` - How rules are loaded and prioritized
  - `rule_template.md` - Standard format for writing rules
  - `tutorial.md` - Getting started with rulebook-ai
  - `supported_assistants.md` - Which AI tools are supported
  - `software_documentation_guides.md` - Best practices for technical documentation

- **Features** (`memory/docs/features/`):
  - `community_packs/` - Using and contributing to shared rule collections
  - `manage_rules/` - Rule organization and lifecycle management
  - `vscode_extension/` - IDE integration for rule development

### Setup with rulebook-ai

1. **Install rulebook-ai**: Follow the installation guide in the rulebook-ai repository
2. **Clone your rules**: Place this `.ai-rules` directory in your project or a dedicated rules repository
3. **Create project profiles**: Use `rulebook-ai` to create profiles that activate relevant rule packs
4. **Sync to AI assistants**: Deploy your selected rules to your preferred AI tools

## Contributing

When adding new rules:
1. Determine if the rule is global (applies everywhere) or domain-specific
2. Choose an appropriate category that aligns with existing patterns
3. Follow the established metadata format and markdown structure (see `rule_template.md` in rulebook-ai docs)
4. Update the manifest file with the new rule details
5. Consider if the rule overlaps with existing rules and consolidate if appropriate
6. If organizing into packs, ensure proper pack structure and documentation

The goal is to maintain a focused, well-organized set of rules that provide clear, actionable guidance without redundancy or conflicts.
