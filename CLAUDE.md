# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a macOS dotfiles repository using a custom symlink-based installation (no GNU stow). Configuration files live in topic-based subdirectories and are symlinked to their expected locations by `setup.sh`.

## Setup & Installation

```bash
# New Mac: Command Line Tools, Homebrew, Brewfile packages, then setup.sh
# (add --macos to also run macos.sh)
./bootstrap.sh

# Create all symlinks (idempotent — safe to re-run).
# Real files in the way are moved to ~/.dotfiles-backup/<timestamp>/, never deleted.
./setup.sh

# Report missing, broken or unlinked targets without changing anything
./setup.sh --check

# Apply macOS system preferences
./macos.sh
```

## Repository Structure

Each top-level directory maps to a tool/app. `setup.sh` handles symlinking:

| Directory | Symlink target |
|-----------|---------------|
| `ack/`, `git/`, `shell/`, `ripgrep/` | Files go to `~/` as dotfiles (`~/.gitconfig`, `~/.ripgreprc`, ...) |
| `ssh/config` | `~/.ssh/config`; it includes `~/.ssh/config.d/*` for machine-specific hosts (not tracked) |
| `ghostty/`, `bat/`, `btop/`, `atuin/` | Dirs go to `~/.config/<name>` |
| `starship/starship.toml`, `zed/settings.json` | `~/.config/starship.toml`, `~/.config/zed/settings.json` |
| `functions/` | Executables symlinked to `~/.bin/` (on `PATH`) |
| `shell/aliases.zsh`, `shell/functions.zsh`, `shell/config.zsh` | Symlinked to `~/.bin/` and sourced by `.zshrc` |
| `zsh/zshrc`, `zsh/zprofile`, `zsh/zsh_plugins.txt` | Symlinked to `~/` |

## Shell Configuration Flow

1. `~/.zprofile` (zsh/zprofile) — Homebrew PATH, JetBrains Toolbox
2. `~/.zshrc` (zsh/zshrc) — loads antidote plugins, atuin, starship, fzf, then sources `~/.bin/{aliases,config,functions}.zsh`
3. `~/.localrc` — machine-specific private config (not tracked, sourced if present).
   Other machine-specific files: `~/.gitconfig.local` (git identity, signing key), `~/.ssh/config.d/*`
4. `~/.zsh_plugins.txt` (zsh/zsh_plugins.txt) — antidote plugin list

## Shell Environment Gotchas

- **GNU tools come first on PATH** in interactive shells: `.zshrc` prepends Homebrew's `gnu-sed` and `coreutils`
  `gnubin` dirs on purpose, so `sed`, `ls`, `cp`, `date`, etc. are the GNU versions, and scripts started from the
  terminal inherit that PATH. Use GNU syntax (e.g. `sed -i 's/a/b/' file`, not BSD's `sed -i '' ...`). Scripts in
  this repo (`setup.sh`, `bootstrap.sh`, `macos.sh`) should stay portable between GNU and BSD tools.
- **`rm`, `cp` and `mv` are aliased to `-iv`** and prompt before overwriting/deleting. In non-interactive
  commands, use `command rm` (or `/bin/rm`) to avoid hanging on a prompt.

## Adding New Tool Configuration

1. Create a subdirectory for the tool (e.g., `newtool/`)
2. Add the config file(s) inside it
3. Add a `"source|target"` entry to the `LINKS` array in `setup.sh`
4. Add the package to `Brewfile` if installed via Homebrew

## Package Management

`Brewfile` is the source of truth for installed packages. After editing:

```bash
brew bundle        # install/update from Brewfile
brew bundle cleanup  # remove packages not in Brewfile
```
