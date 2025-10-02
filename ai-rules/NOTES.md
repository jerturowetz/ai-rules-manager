# AI Rules System - Operational Notes

## Tool Configuration Status

### Memory Settings
- **Cursor**: Memory/chat history disabled
- **ChatGPT**: Memory disabled
- **Rationale**: Relies on this curated rules system instead of tool-specific memory for consistency

## System Maintenance
- Rules are manually curated and version controlled
- Updates should be reflected in both `README.md` and `manifest.json`
- Follow single responsibility principle when adding new rules

## Usage
- This rules system provides the primary context for AI interactions
- Tools should reference these rules rather than building their own context over time
- Ensures consistent behavior across different AI tools and sessions

## File Organization Philosophy
- **Global rules** (`global/`) apply universally across all contexts and technologies
- **Domain rules** (`domains/`) are specific to particular technologies, frameworks, or specialized contexts
- Each rule follows single responsibility principle - focused on one specific aspect
- Rules are designed to layer together (global provides foundation, domains add specificity)

## Integration Notes
- System designed to work with any AI tool that can reference local files
- Manifest file (`manifest.json`) provides machine-readable catalog for potential automation
- All rules use consistent YAML frontmatter for metadata and structured markdown format

## Quality Standards
- Rules must be actionable and specific (not vague principles)
- Examples should use ✅/❌ pattern for clarity
- Code examples use 4-space indentation (following the formatting guidelines)
- Avoid redundancy - consolidate overlapping concepts into existing rules
