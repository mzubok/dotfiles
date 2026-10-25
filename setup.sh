#!/usr/bin/env bash
#
# Symlink dotfiles into place. Safe to re-run.
#
#   ./setup.sh          create/repair symlinks; real files are moved to a backup dir
#   ./setup.sh --check  report missing, broken or unlinked targets without changing anything

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
CHECK_ONLY=false
[ "${1:-}" = "--check" ] && CHECK_ONLY=true

# source (relative to repo) | target
LINKS=(
    "ack/ackrc|$HOME/.ackrc"
    "git/gitconfig|$HOME/.gitconfig"
    "git/gitignore|$HOME/.gitignore"
    "git/gitattributes|$HOME/.gitattributes"
    "shell/editorconfig|$HOME/.editorconfig"
    "shell/curlrc|$HOME/.curlrc"
    "shell/wgetrc|$HOME/.wgetrc"
    "ssh/config|$HOME/.ssh/config"
    "zsh/zprofile|$HOME/.zprofile"
    "zsh/zshrc|$HOME/.zshrc"
    "zsh/zsh_plugins.txt|$HOME/.zsh_plugins.txt"
    "atuin|$HOME/.config/atuin"
    "bat|$HOME/.config/bat"
    "btop|$HOME/.config/btop"
    "ghostty|$HOME/.config/ghostty"
    "starship/starship.toml|$HOME/.config/starship.toml"
    "zed/settings.json|$HOME/.config/zed/settings.json"
    "claude/settings.json|$HOME/.claude/settings.json"
    "shell/aliases.zsh|$HOME/.bin/aliases.zsh"
    "shell/config.zsh|$HOME/.bin/config.zsh"
    "shell/functions.zsh|$HOME/.bin/functions.zsh"
    "functions/battery|$HOME/.bin/battery"
    "functions/brew-why|$HOME/.bin/brew-why"
)

problems=0

backup() {
    local target="$1"
    local dest="$BACKUP_DIR/${target#"$HOME"/}"
    mkdir -p "$(dirname "$dest")"
    mv "$target" "$dest"
    echo "  backed up $target -> $dest"
}

link() {
    local src="$BASE_DIR/$1"
    local target="$2"

    if [ "$(readlink "$target" 2>/dev/null)" = "$src" ]; then
        return
    fi

    if $CHECK_ONLY; then
        if [ -L "$target" ]; then
            echo "WRONG LINK  $target -> $(readlink "$target")"
        elif [ -e "$target" ]; then
            echo "NOT LINKED  $target (real file or directory)"
        else
            echo "MISSING     $target"
        fi
        problems=$((problems + 1))
        return
    fi

    if [ -L "$target" ]; then
        rm "$target"
    elif [ -e "$target" ]; then
        backup "$target"
    fi

    mkdir -p "$(dirname "$target")"
    ln -s "$src" "$target"
    echo "linked $target"
}

# Symlinks that point into this repo but whose source no longer exists
# (e.g. a config file removed from the repo)
prune_stale() {
    local entry
    for entry in "$HOME"/.[!.]* "$HOME"/.bin/* "$HOME"/.config/*; do
        [ -L "$entry" ] || continue
        case "$(readlink "$entry")" in
            "$BASE_DIR"/*) ;;
            *) continue ;;
        esac
        [ -e "$entry" ] && continue
        if $CHECK_ONLY; then
            echo "STALE       $entry -> $(readlink "$entry")"
            problems=$((problems + 1))
        else
            rm "$entry"
            echo "removed stale link $entry"
        fi
    done
}

for pair in "${LINKS[@]}"; do
    [ -e "$BASE_DIR/${pair%%|*}" ] || { echo "Source missing in repo: ${pair%%|*}" >&2; exit 1; }
    link "${pair%%|*}" "${pair#*|}"
done
prune_stale

if $CHECK_ONLY; then
    if [ "$problems" -eq 0 ]; then
        echo "All links OK."
    else
        echo "$problems problem(s) found. Run ./setup.sh to fix."
        exit 1
    fi
else
    [ -d "$BACKUP_DIR" ] && echo "Replaced files were saved to $BACKUP_DIR"
    echo "Setup is done. Run 'reload!' now!"
fi
