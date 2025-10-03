#!/usr/bin/env bash
set -euo pipefail

# AI Rule Manager - Setup & Sync
# One-command setup and synchronization script
#
# Usage:
#   ./setup-and-sync.sh [--dry-run] [--skip-install] [--force-update]
#
# What it does:
#   1. Checks/installs uvx (if not present)
#   2. Installs/updates rulebook-ai (only if missing or --force-update)
#   3. Generates all packs with proper structure
#   4. Syncs all packs to rulebook-ai
#
# Options:
#   --dry-run      Preview what would be done without making changes
#   --skip-install Skip dependency installation checks
#   --force-update Force update of rulebook-ai even if already installed

DRY_RUN=false
SKIP_INSTALL=false
FORCE_UPDATE=false

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=true
      ;;
    --skip-install)
      SKIP_INSTALL=true
      ;;
    --force-update)
      FORCE_UPDATE=true
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      echo "Usage: $0 [--dry-run] [--skip-install] [--force-update]" >&2
      exit 1
      ;;
  esac
done

# Color output functions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
  echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
  echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
  echo -e "${RED}❌ $1${NC}"
}

# Check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "🚀 AI Rule Manager - Setup & Sync"
echo "================================="
echo

if [ "$DRY_RUN" = true ]; then
  log_warning "DRY RUN MODE - No changes will be made"
  echo
fi

# Step 1: Check and install uvx
if [ "$SKIP_INSTALL" = false ]; then
  log_info "Checking uvx installation..."
  
  if command_exists uvx; then
    log_success "uvx is already installed"
  else
    log_warning "uvx not found. Installing uvx..."
    if [ "$DRY_RUN" = true ]; then
      echo "[dry-run] Would install uvx via: curl -LsSf https://astral.sh/uv/install.sh | sh"
    else
      if command_exists curl; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
        # Source the shell to get uvx in PATH
        export PATH="$HOME/.cargo/bin:$PATH"
        if command_exists uvx; then
          log_success "uvx installed successfully"
        else
          log_error "uvx installation failed or not in PATH"
          log_info "Try running: export PATH=\"\$HOME/.cargo/bin:\$PATH\""
          exit 1
        fi
      else
        log_error "curl not found. Please install curl or uvx manually"
        log_info "Visit: https://docs.astral.sh/uv/getting-started/installation/"
        exit 1
      fi
    fi
  fi
  echo

  # Step 2: Check and install/update rulebook-ai
  log_info "Checking rulebook-ai installation..."
  
  if command_exists rulebook-ai; then
    log_success "rulebook-ai is already installed"
    if [ "$FORCE_UPDATE" = true ]; then
      if [ "$DRY_RUN" = true ]; then
        echo "[dry-run] Would update rulebook-ai via: pip install --upgrade git+https://github.com/botingw/rulebook-ai.git"
      else
        log_info "Force updating rulebook-ai to latest version..."
        pip install --upgrade git+https://github.com/botingw/rulebook-ai.git
        log_success "rulebook-ai updated"
      fi
    else
      log_info "Use --force-update to update to latest version"
    fi
  else
    log_warning "rulebook-ai not found. Installing..."
    if [ "$DRY_RUN" = true ]; then
      echo "[dry-run] Would install rulebook-ai via: pip install git+https://github.com/botingw/rulebook-ai.git"
    else
      if command_exists pip; then
        pip install git+https://github.com/botingw/rulebook-ai.git
        log_success "rulebook-ai installed successfully"
      else
        log_error "pip not found. Please install Python and pip first"
        exit 1
      fi
    fi
  fi
  echo
else
  log_info "Skipping dependency installation (--skip-install)"
  echo
fi

# Verify dependencies are available
if [ "$DRY_RUN" = false ]; then
  if ! command_exists rulebook-ai; then
    log_error "rulebook-ai not available after installation. Check your PATH and Python environment."
    exit 1
  fi
fi

# Step 3: Generate packs
log_info "Generating rulebook-ai compliant packs..."
if [ "$DRY_RUN" = true ]; then
  echo "[dry-run] Would run: scripts/generate-packs.sh --dry-run"
  scripts/generate-packs.sh --dry-run
else
  scripts/generate-packs.sh
fi
echo

# Step 4: Sync packs to rulebook-ai
log_info "Syncing packs to rulebook-ai..."
if [ "$DRY_RUN" = true ]; then
  echo "[dry-run] Would run: scripts/add-packs.sh --dry-run"
  scripts/add-packs.sh --dry-run
else
  scripts/add-packs.sh
fi

echo
echo "================================="
if [ "$DRY_RUN" = true ]; then
  log_success "Dry run completed! Run without --dry-run to execute."
else
  log_success "Setup and sync completed successfully!"
  echo
  log_info "Your AI Rule Manager is ready to use:"
  echo "  • All packs generated with proper rulebook-ai structure"
  echo "  • All packs synced to rulebook-ai pack library"
  echo
  log_info "To use in a project:"
  echo "  cd /path/to/your/project"
  echo "  rulebook-ai project sync"
  echo
  log_info "To see installed packs:"
  echo "  rulebook-ai packs status"
fi