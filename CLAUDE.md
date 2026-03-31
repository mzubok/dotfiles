# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a macOS dotfiles repository using a custom symlink-based installation (no GNU stow). Configuration files live in topic-based subdirectories and are symlinked to their expected locations by `setup.sh`.

## Setup & Installation

```bash
# Install Homebrew packages
./brew.sh

# Create all symlinks (idempotent — safe to re-run)
./setup.sh

# Apply macOS system preferences
./macos.sh
```

## Repository Structure

Each top-level directory maps to a tool/app. `setup.sh` handles symlinking:

| Directory | Symlink target |
|-----------|---------------|
| `ack/`, `git/`, `ssh/`, `shell/` | Files go to `~/` |
| `ghostty/`, `bat/`, `btop/`, `starship/`, `atuin/`, `ripgrep/` | Dirs go to `~/.config/<name>` |
| `shell/aliases.zsh`, `shell/functions.zsh`, `shell/config.zsh` | Symlinked to `~/.bin/` and sourced by `.zshrc` |
| `zsh/zshrc`, `zsh/zprofile`, `zsh/zsh_plugins.txt` | Symlinked to `~/` |

## Shell Configuration Flow

1. `~/.zprofile` (zsh/zprofile) — Homebrew PATH, JetBrains Toolbox
2. `~/.zshrc` (zsh/zshrc) — loads antidote plugins, atuin, starship, fzf, then sources `~/.bin/{aliases,config,functions}.zsh`
3. `~/.localrc` — machine-specific private config (not tracked, sourced if present)
4. `~/.zsh_plugins.txt` (zsh/zsh_plugins.txt) — antidote plugin list

## Adding New Tool Configuration

1. Create a subdirectory for the tool (e.g., `newtool/`)
2. Add the config file(s) inside it
3. Add a `create_symlink` call in `setup.sh`
4. Add the package to `Brewfile` if installed via Homebrew

## Package Management

`Brewfile` is the source of truth for installed packages. After editing:

```bash
brew bundle        # install/update from Brewfile
brew bundle cleanup  # remove packages not in Brewfile
```
