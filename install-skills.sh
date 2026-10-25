#!/usr/bin/env bash
#
# Install the third-party skills listed in claude/skills.txt. Safe to re-run:
# skills that are already installed are skipped.
#
#   ./install-skills.sh            install missing skills
#   ./install-skills.sh --update   also update installed ones (npx skills update -g)

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIST="$BASE_DIR/claude/skills.txt"
SKILLS_DIR="$HOME/.agents/skills"

if ! command -v npx >/dev/null 2>&1; then
    echo "npx not found (install Node.js); skipping skills." >&2
    exit 0
fi

while read -r source skill; do
    case "$source" in ''|\#*) continue ;; esac
    if [ -d "$SKILLS_DIR/$skill" ]; then
        echo "skill $skill: already installed"
        continue
    fi
    echo "skill $skill: installing from $source"
    npx -y skills add "$source" --global --skill "$skill" --agent claude-code --yes
done < "$LIST"

if [ "${1:-}" = "--update" ]; then
    npx -y skills update --global --yes
fi
