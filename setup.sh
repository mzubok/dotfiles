#!/usr/bin/env bash

echo 'Removing old directories and symbolic links...'

rm -rf ~/.bin
rm -f ~/.ackrc
rm -f ~/.editorconfig
rm -f ~/.gitconfig
rm -f ~/.gitignore
rm -f ~/.curlrc
rm -f ~/.inputrc
rm -f ~/.ripgreprc
rm -f ~/.screenrc
rm -f ~/.wgetrc
rm -f ~/.zprofile
rm -f ~/.zshrc

CONFIG_DIR=~/.config

rm -f $CONFIG_DIR/atuin
rm -f $CONFIG_DIR/ghostty
rm -f $CONFIG_DIR/starship.toml
rm -f $CONFIG_DIR/zed/settings.json

if [ ! -d "$CONFIG_DIR" ]; then
    # Directory does not exist, so create it
    mkdir "$CONFIG_DIR"
    echo "Directory $CONFIG_DIR created."
else
    echo "Directory $CONFIG_DIR already exists."
fi

echo 'Creating new symbolic links...'

ln -s "$(pwd)/ack/ackrc" ~/.ackrc
ln -s "$(pwd)/git/gitconfig" ~/.gitconfig
ln -s "$(pwd)/git/gitignore" ~/.gitignore
ln -s "$(pwd)/shell/editorconfig" ~/.editorconfig
ln -s "$(pwd)/shell/curlrc" ~/.curlrc
ln -s "$(pwd)/shell/inputrc" ~/.inputrc
ln -s "$(pwd)/ripgrep/ripgreprc" ~/.ripgreprc
ln -s "$(pwd)/shell/screenrc" ~/.screenrc
ln -s "$(pwd)/shell/wgetrc" ~/.wgetrc
ln -s "$(pwd)/zsh/zprofile" ~/.zprofile
ln -s "$(pwd)/zsh/zshrc" ~/.zshrc

ln -s "$(pwd)/atuin" "$CONFIG_DIR/atuin"
ln -s "$(pwd)/ghostty" "$CONFIG_DIR/ghostty"
ln -s "$(pwd)/starship/starship.toml" "$CONFIG_DIR/starship.toml"
ln -s "$(pwd)/zed/settings.json" "$CONFIG_DIR/zed/settings.json"

mkdir ~/.bin
ln -s "$(pwd)/shell/aliases.zsh" ~/.bin/aliases.zsh
ln -s "$(pwd)/shell/config.zsh" ~/.bin/config.zsh
ln -s "$(pwd)/shell/functions.zsh" ~/.bin/functions.zsh

# Reload zsh settings
# source ~/.zshrc

echo 'Setup is done. Run `reload!` now!'
