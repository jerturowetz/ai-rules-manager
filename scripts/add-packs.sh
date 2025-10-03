#!/usr/bin/env bash
set -euo pipefail

# ai-rules-manager add-packs utility
# - Removes all local packs from rulebook-ai
# - Adds all generated packs from ai-packs/ to rulebook-ai
#
# Usage:
#   scripts/add-packs.sh [--dry-run]
#
# Notes:
# - Only removes packs that were added locally (not built-in packs)
# - Automatically detects all *-pack directories in ai-packs/
# - Run after scripts/generate-packs.sh to sync latest changes

DRY_RUN=false

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=true
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      echo "Usage: $0 [--dry-run]" >&2
      exit 1
      ;;
  esac
done

project_root=$(cd "$(dirname "$0")/.." && pwd)
packs_dir="$project_root/ai-packs"

echo "🚀 AI Rules Manager - Pack Sync to Rulebook-AI"
echo

# Check if rulebook-ai is available
if ! command -v rulebook-ai &> /dev/null; then
  echo "❌ Error: rulebook-ai not found. Please install it first:"
  echo "   pip install git+https://github.com/botingw/rulebook-ai.git"
  exit 1
fi

# Check if ai-packs directory exists
if [ ! -d "$packs_dir" ]; then
  echo "❌ Error: ai-packs directory not found at $packs_dir"
  echo "   Run scripts/generate-packs.sh first to create packs"
  exit 1
fi

echo "📋 Current rulebook-ai pack status:"
rulebook-ai packs status || echo "No packs currently installed"
echo

# Get list of currently installed local packs (exclude built-ins)
echo "🧹 Removing existing local packs from rulebook-ai..."

# Parse pack status to find local packs (those with local paths)
local_packs=()
while IFS= read -r line; do
  # Look for lines that contain pack names (format: "  N. pack-name (vX.X.X)")
  if [[ $line =~ ^[[:space:]]*[0-9]+\.[[:space:]]([^[:space:]]+)[[:space:]]\( ]]; then
    pack_name="${BASH_REMATCH[1]}"
    # Skip built-in packs (they don't have local paths in next line)
    if read -r next_line && [[ $next_line =~ \.rulebook-ai/packs/ ]]; then
      local_packs+=("$pack_name")
    fi
  fi
done < <(rulebook-ai packs status 2>/dev/null || echo "")

# Remove local packs
for pack in "${local_packs[@]}"; do
  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] Would remove pack: $pack"
  else
    echo "  Removing: $pack"
    rulebook-ai packs remove "$pack" 2>/dev/null || echo "    Warning: Could not remove $pack (may not exist)"
  fi
done

if [ ${#local_packs[@]} -eq 0 ]; then
  echo "  No local packs found to remove"
fi

echo

# Find all generated packs
echo "📦 Adding generated packs to rulebook-ai..."
pack_count=0

# Use process substitution to avoid subshell issue with pack_count
while IFS= read -r -d '' pack_path; do
  pack_name=$(basename "$pack_path")
  
  # Verify pack structure
  if [ ! -f "$pack_path/manifest.yaml" ] || [ ! -f "$pack_path/README.md" ] || [ ! -d "$pack_path/rules/01-rules" ]; then
    echo "  ⚠️  Skipping $pack_name (invalid structure - run scripts/generate-packs.sh)"
    continue
  fi
  
  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] Would add pack: $pack_name"
    echo "[dry-run]   Path: $pack_path"
    echo "[dry-run]   Rules: $(find "$pack_path/rules/01-rules" -name "*.md" | wc -l | tr -d ' ')"
  else
    echo "  Adding: $pack_name"
    if rulebook-ai packs add "local:$pack_path" 2>/dev/null; then
      rule_count=$(find "$pack_path/rules/01-rules" -name "*.md" | wc -l | tr -d ' ')
      echo "    ✅ Added successfully ($rule_count rules)"
    else
      echo "    ❌ Failed to add (check pack structure)"
    fi
  fi
  
  pack_count=$((pack_count + 1))
done < <(find "$packs_dir" -name "*-pack" -type d -print0 | sort -z)

echo
if [ "$pack_count" -eq 0 ]; then
  echo "❌ No packs found in $packs_dir"
  echo "   Run scripts/generate-packs.sh first to create packs"
else
  echo "✅ Pack sync complete${DRY_RUN:+ (dry-run)}"
  echo "   Processed $pack_count packs"
  
  if [ "$DRY_RUN" = false ]; then
    echo
    echo "📋 Updated rulebook-ai pack status:"
    rulebook-ai packs status
    echo
    echo "💡 To apply these packs to a project, run:"
    echo "   cd /path/to/your/project"
    echo "   rulebook-ai project sync"
  fi
fi