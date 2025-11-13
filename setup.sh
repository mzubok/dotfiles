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
    ~/.zsh_plugins.txt
    ~/.zshrc
)

CONFIG_FILES_TO_REMOVE=(
    ~/.config/atuin
    ~/.config/bat
    ~/.config/btop
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

# Create symlinks using a simpler approach
create_symlink() {
    local src="$1"
    local dest="$2"

    # Expand tilde in destination
    dest="${dest/#\~/$HOME}"

    if [ -L "$dest" ] || [ -e "$dest" ]; then
        rm -f "$dest"
    fi
    ln -s "$src" "$dest"
}

# Create all symlinks
create_symlink "$BASE_DIR/ack/ackrc" ~/.ackrc
create_symlink "$BASE_DIR/git/gitconfig" ~/.gitconfig
create_symlink "$BASE_DIR/git/gitignore" ~/.gitignore
create_symlink "$BASE_DIR/shell/editorconfig" ~/.editorconfig
create_symlink "$BASE_DIR/shell/curlrc" ~/.curlrc
create_symlink "$BASE_DIR/shell/inputrc" ~/.inputrc
create_symlink "$BASE_DIR/ripgrep/ripgreprc" ~/.ripgreprc
create_symlink "$BASE_DIR/shell/screenrc" ~/.screenrc
create_symlink "$BASE_DIR/shell/wgetrc" ~/.wgetrc
create_symlink "$BASE_DIR/zsh/zprofile" ~/.zprofile
create_symlink "$BASE_DIR/zsh/zshrc" ~/.zshrc
create_symlink "$BASE_DIR/zsh/zsh_plugins.txt" ~/.zsh_plugins.txt
create_symlink "$BASE_DIR/atuin" ~/.config/atuin
create_symlink "$BASE_DIR/bat" ~/.config/bat
create_symlink "$BASE_DIR/btop" ~/.config/btop
create_symlink "$BASE_DIR/ghostty" ~/.config/ghostty
create_symlink "$BASE_DIR/starship/starship.toml" ~/.config/starship.toml
create_symlink "$BASE_DIR/zed/settings.json" ~/.config/zed/settings.json
create_symlink "$BASE_DIR/shell/aliases.zsh" ~/.bin/aliases.zsh
create_symlink "$BASE_DIR/shell/config.zsh" ~/.bin/config.zsh
create_symlink "$BASE_DIR/shell/functions.zsh" ~/.bin/functions.zsh
create_symlink "$BASE_DIR/zed/settings.json" ~/.config/zed/settings.json

echo "Setup is done. Run 'reload!' now!"
