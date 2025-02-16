#!/usr/bin/env bash

echo 'Removing old directories and symbolic links...'

# Define lists of files and directories to remove
FILES_TO_REMOVE=(
    ~/.ackrc
    ~/.editorconfig
    ~/.gitconfig
    ~/.gitignore
    ~/.curlrc
    ~/.inputrc
    ~/.ripgreprc
    ~/.screenrc
    ~/.wgetrc
    ~/.zprofile
    ~/.zshrc
)

CONFIG_FILES_TO_REMOVE=(
    ~/.config/atuin
    ~/.config/ghostty
    ~/.config/starship.toml
    ~/.config/zed/settings.json
)

# Remove old files safely
for file in "${FILES_TO_REMOVE[@]}" "${CONFIG_FILES_TO_REMOVE[@]}"; do
    [ -e "$file" ] && rm -f "$file"
done

# Remove ~/.bin if it exists
[ -d ~/.bin ] && rm -rf ~/.bin

# Function to ensure directories exist
ensure_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Created directory: $1"
    else
        echo "Directory already exists: $1"
    fi
}

# Ensure necessary directories exist
ensure_directory ~/.config
ensure_directory ~/.config/zed
ensure_directory ~/.bin

echo 'Creating new symbolic links...'

# Get the absolute path of the current directory
BASE_DIR="$(pwd)"

declare -A SYMLINKS=(
    ["$BASE_DIR/ack/ackrc"]="~/.ackrc"
    ["$BASE_DIR/git/gitconfig"]="~/.gitconfig"
    ["$BASE_DIR/git/gitignore"]="~/.gitignore"
    ["$BASE_DIR/shell/editorconfig"]="~/.editorconfig"
    ["$BASE_DIR/shell/curlrc"]="~/.curlrc"
    ["$BASE_DIR/shell/inputrc"]="~/.inputrc"
    ["$BASE_DIR/ripgrep/ripgreprc"]="~/.ripgreprc"
    ["$BASE_DIR/shell/screenrc"]="~/.screenrc"
    ["$BASE_DIR/shell/wgetrc"]="~/.wgetrc"
    ["$BASE_DIR/zsh/zprofile"]="~/.zprofile"
    ["$BASE_DIR/zsh/zshrc"]="~/.zshrc"
    ["$BASE_DIR/atuin"]="~/.config/atuin"
    ["$BASE_DIR/ghostty"]="~/.config/ghostty"
    ["$BASE_DIR/starship/starship.toml"]="~/.config/starship.toml"
    ["$BASE_DIR/zed/settings.json"]="~/.config/zed/settings.json"
    ["$BASE_DIR/shell/aliases.zsh"]="~/.bin/aliases.zsh"
    ["$BASE_DIR/shell/config.zsh"]="~/.bin/config.zsh"
    ["$BASE_DIR/shell/functions.zsh"]="~/.bin/functions.zsh"
)

# Create symlinks
for src in "${!SYMLINKS[@]}"; do
    dest="${SYMLINKS[$src]}"
    if [ -L "$dest" ] || [ -e "$dest" ]; then
        rm -f "$dest"
    fi
    ln -s "$(readlink -f "$src")" "$dest"
done

echo "Setup is done. Run 'reload!' now!"
