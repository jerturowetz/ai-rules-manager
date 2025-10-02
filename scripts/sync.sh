#!/usr/bin/env bash
set -euo pipefail

# ai-rules-manager sync utility
# - Syncs project ai-rules -> ~/.ai-rules
# - Syncs project ai-packs -> ~/ai-packs
# - Optionally registers/deregisters packs with rulebook-ai (stubbed hooks)
#
# Usage:
#   scripts/sync.sh [--dry-run] [--no-packs] [--no-rules]
#
# Notes:
# - Uses rsync with --delete to mirror directories exactly
# - If --dry-run is provided, no changes are made, and actions are printed
# - Pack registration via rulebook-ai is a stub; customize register_packs/deregister_removed_packs

DRY_RUN=false
SYNC_RULES=true
SYNC_PACKS=true

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=true
      ;;
    --no-packs)
      SYNC_PACKS=false
      ;;
    --no-rules)
      SYNC_RULES=false
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      exit 1
      ;;
  esac
done

project_root=$(cd "$(dirname "$0")/.." && pwd)
src_rules="$project_root/ai-rules"
src_packs="$project_root/ai-packs"
dest_rules="$HOME/.ai-rules"
dest_packs="$HOME/ai-packs"

rsync_cmd=(rsync -avh --delete --exclude='.DS_Store' --exclude='README.md' --exclude='NOTES.md' --exclude='manifest.json')
if [ "$DRY_RUN" = true ]; then
  rsync_cmd+=(--dry-run)
fi

sync_dir() {
  local src="$1"
  local dest="$2"
  local label="$3"
  if [ ! -d "$src" ]; then
    echo "[skip] $label: source directory not found at $src"
    return 0
  fi
  mkdir -p "$dest"
  echo "[sync] $label: $src -> $dest"
  "${rsync_cmd[@]}" "$src/" "$dest/"
}

register_packs() {
  # Stub: scan pack manifests and register via rulebook-ai CLI if available.
  # Example (pseudo): rulebook --no-pager packs register --path "$dest_packs/$pack"
  # Implement as needed for your environment.
  echo "[info] register_packs: stubbed. Add rulebook-ai CLI calls here."
}

deregister_removed_packs() {
  # Stub: compare registered local packs with folders present in $dest_packs and deregister those missing.
  # Example (pseudo): rulebook --no-pager packs list | while read ...; do rulebook packs deregister ...; done
  echo "[info] deregister_removed_packs: stubbed. Add rulebook-ai CLI calls here."
}

if [ "$SYNC_RULES" = true ]; then
  sync_dir "$src_rules" "$dest_rules" "ai-rules"
fi

if [ "$SYNC_PACKS" = true ]; then
  sync_dir "$src_packs" "$dest_packs" "ai-packs"
  register_packs
  deregister_removed_packs
fi

echo "[done] sync complete${DRY_RUN:+ (dry-run)}"