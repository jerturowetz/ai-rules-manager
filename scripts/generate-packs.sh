#!/usr/bin/env bash
set -euo pipefail

# ai-rules-manager pack generation utility
# Generates packs from organized rule directories in ai-rules/
#
# Usage:
#   scripts/generate-packs.sh [--dry-run] [--pack-name PACK_NAME]
#
# Notes:
# - Scans ai-rules/global/ and ai-rules/domains/ for subdirectories
# - Each subdirectory becomes a pack
# - Creates manifest.yaml, README.md, and copies rules
# - If --dry-run is provided, shows what would be created without making changes

DRY_RUN=false
SPECIFIC_PACK=""

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=true
      ;;
    --pack-name)
      shift
      SPECIFIC_PACK="$1"
      ;;
    *)
      if [[ $arg == --pack-name=* ]]; then
        SPECIFIC_PACK="${arg#--pack-name=}"
      fi
      ;;
  esac
done

project_root=$(cd "$(dirname "$0")/.." && pwd)
rules_dir="$project_root/ai-rules"
packs_dir="$project_root/ai-packs"

generate_manifest() {
  local pack_name="$1"
  local pack_dir="$2"
  local source_dir="$3"
  local category="$4"
  
  local rule_count=$(find "$source_dir" -name "*.md" | wc -l | tr -d ' ')
  local description=""
  local pack_category=""
  
  case "$pack_name" in
    *foundation*)
      description="Core communication and thinking patterns for AI interactions"
      pack_category="foundation"
      ;;
    *development-standards*)
      description="Code quality, testing, and implementation standards"
      pack_category="development"
      ;;
    *workflow*)
      description="Git workflow, project management, and documentation standards"
      pack_category="workflow"
      ;;
    *tool-config*)
      description="IDE and tooling configuration standards"
      pack_category="configuration"
      ;;
    *tech-python*)
      description="Python-specific development standards and best practices"
      pack_category="technology"
      ;;
    *tech-wordpress*)
      description="WordPress-specific development standards and practices"
      pack_category="technology"
      ;;
    *tech-astro*)
      description="Astro framework development standards and practices"
      pack_category="technology"
      ;;
    *context-product*)
      description="Product management and task formatting standards"
      pack_category="context"
      ;;
    *context-privacy*)
      description="Privacy compliance and consent management standards"
      pack_category="context"
      ;;
    *context-ai-testing*)
      description="AI system testing and quality assurance methodologies"
      pack_category="context"
      ;;
    *)
      description="AI interaction rules for $pack_name"
      pack_category="general"
      ;;
  esac
  
  cat > "$pack_dir/manifest.yaml" << EOF
name: $pack_name
version: 1.0.0
summary: $description
description: |
  $description
  
  This pack contains $rule_count rules organized for consistent AI interactions.

author: jeremyt
created: $(date +%Y-%m-%d)
category: $pack_category

rules:
EOF

  # Add rule entries with numeric prefixes
  local counter=1
  find "$source_dir" -name "*.md" | sort | while read -r rule_file; do
    local rule_filename=$(basename "$rule_file")
    local prefixed_filename=$(printf "%02d-%s" "$counter" "$rule_filename")
    local rule_name="${rule_filename%.md}"
    local rule_title=$(echo "$rule_name" | sed 's/-/ /g' | sed 's/\b\w/\U&/g')
    
    cat >> "$pack_dir/manifest.yaml" << EOF
  - path: rules/01-rules/$prefixed_filename
    description: $rule_title
EOF
    counter=$((counter + 1))
  done

  cat >> "$pack_dir/manifest.yaml" << EOF

dependencies: []
conflicts: []

tags:
  - $(echo "$pack_category" | tr '[:upper:]' '[:lower:]')
  - ai-rules
EOF
}

generate_readme() {
  local pack_name="$1"
  local pack_dir="$2"
  local source_dir="$3"
  
  local rule_count=$(find "$source_dir" -name "*.md" | wc -l | tr -d ' ')
  local display_name=$(echo "$pack_name" | sed 's/-/ /g' | sed 's/\b\w/\U&/g')
  
  cat > "$pack_dir/README.md" << EOF
# $display_name

## Purpose

This pack contains $rule_count AI interaction rules focused on $(echo "$pack_name" | sed 's/-pack$//' | sed 's/-/ /g').

## Rules Included

EOF

  # List all rules with numeric prefixes
  local counter=1
  find "$source_dir" -name "*.md" | sort | while read -r rule_file; do
    local rule_filename=$(basename "$rule_file")
    local prefixed_filename=$(printf "%02d-%s" "$counter" "$rule_filename")
    local rule_name="${rule_filename%.md}"
    local rule_title=$(echo "$rule_name" | sed 's/-/ /g' | sed 's/\b\w/\U&/g')
    
    echo "- **$prefixed_filename** - $rule_title" >> "$pack_dir/README.md"
    counter=$((counter + 1))
  done

  cat >> "$pack_dir/README.md" << EOF

## Usage

This pack can be used with rulebook-ai or deployed individually to ~/.ai-rules.

Add to your rulebook-ai profile or copy rules to your AI assistant configuration.

## Integration

Works well with other packs in the ai-rules-manager collection.
EOF
}

generate_pack() {
  local source_dir="$1"
  local category="$2"
  local dir_name=$(basename "$source_dir")
  local pack_name="$dir_name-pack"
  local pack_dir="$packs_dir/$pack_name"
  
  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] Would create pack: $pack_name"
    echo "[dry-run]   Source: $source_dir"
    echo "[dry-run]   Destination: $pack_dir"
    echo "[dry-run]   Rules: $(find "$source_dir" -name "*.md" | wc -l | tr -d ' ')"
    return 0
  fi
  
  echo "[create] Generating pack: $pack_name"
  
  # Clean and create pack directory structure
  rm -rf "$pack_dir"
  mkdir -p "$pack_dir/rules/01-rules"
  
  # Copy rule files with numeric prefixes (required by rulebook-ai)
  local counter=1
  find "$source_dir" -name "*.md" | sort | while read -r rule_file; do
    local rule_filename=$(basename "$rule_file")
    local prefixed_filename=$(printf "%02d-%s" "$counter" "$rule_filename")
    cp "$rule_file" "$pack_dir/rules/01-rules/$prefixed_filename"
    counter=$((counter + 1))
  done
  
  # Generate manifest
  generate_manifest "$pack_name" "$pack_dir" "$source_dir" "$category"
  
  # Generate README
  generate_readme "$pack_name" "$pack_dir" "$source_dir"
  
  local rule_count=$(find "$pack_dir/rules/01-rules" -name "*.md" | wc -l | tr -d ' ')
  echo "[created] $pack_name with $rule_count rules"
}

echo "🚀 AI Rules Manager - Pack Generation"
echo

if [ -n "$SPECIFIC_PACK" ]; then
  echo "Generating specific pack: $SPECIFIC_PACK"
  
  # Look for the specific directory
  if [ -d "$rules_dir/global/$SPECIFIC_PACK" ]; then
    generate_pack "$rules_dir/global/$SPECIFIC_PACK" "global"
  elif [ -d "$rules_dir/domains/$SPECIFIC_PACK" ]; then
    generate_pack "$rules_dir/domains/$SPECIFIC_PACK" "domain"
  else
    echo "❌ Pack directory not found: $SPECIFIC_PACK"
    echo "Available directories:"
    find "$rules_dir" -type d -mindepth 2 -maxdepth 2 | sed 's|.*/||' | sort
    exit 1
  fi
else
  echo "Scanning for pack directories..."
  echo
  
  # Generate packs from global directories
  if [ -d "$rules_dir/global" ]; then
    find "$rules_dir/global" -type d -mindepth 1 -maxdepth 1 | while read -r dir; do
      if [ "$(find "$dir" -name "*.md" | wc -l | tr -d ' ')" -gt 0 ]; then
        generate_pack "$dir" "global"
      fi
    done
  fi
  
  # Generate packs from domain directories
  if [ -d "$rules_dir/domains" ]; then
    find "$rules_dir/domains" -type d -mindepth 1 -maxdepth 1 | while read -r dir; do
      if [ "$(find "$dir" -name "*.md" | wc -l | tr -d ' ')" -gt 0 ]; then
        generate_pack "$dir" "domain"
      fi
    done
  fi
fi

echo
echo "✅ Pack generation complete${DRY_RUN:+ (dry-run)}"

if [ "$DRY_RUN" = false ]; then
  echo
  echo "📦 Generated packs:"
  ls -1 "$packs_dir" | grep -E ".*-pack$" | sed 's/^/  - /'
fi