#!/usr/bin/env bash
#
# Set up a Mac from this repo. Safe to re-run.
#
#   ./bootstrap.sh          Command Line Tools, Homebrew, Brewfile packages, symlinks
#   ./bootstrap.sh --macos  also apply macOS defaults (macos.sh)

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPLY_MACOS=false
[ "${1:-}" = "--macos" ] && APPLY_MACOS=true

if ! xcode-select -p >/dev/null 2>&1; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Finish the installer dialog, then re-run $0"
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make brew available in this session (fresh installs aren't on PATH yet)
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

echo "Installing Brewfile packages..."
brew bundle --file="$BASE_DIR/Brewfile"

echo "Linking dotfiles..."
"$BASE_DIR/setup.sh"

if $APPLY_MACOS; then
    echo "Applying macOS defaults..."
    "$BASE_DIR/macos.sh"
fi

echo "Bootstrap done. Open a new terminal to load the shell config."
