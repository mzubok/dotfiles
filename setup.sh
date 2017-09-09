#!/usr/bin/env bash

echo 'Removing old directories and symbolic links...'

rm -rf ~/.bin

rm ~/.gitconfig
rm ~/.gitignore
rm ~/.curlrc
rm ~/.inputrc
rm ~/.wgetrc
rm ~/.zshrc

echo 'Creating new symbolic links...'

ln -s "$(pwd)/git/gitconfig" ~/.gitconfig
ln -s "$(pwd)/git/gitignore" ~/.gitignore
ln -s "$(pwd)/shell/curlrc" ~/.curlrc
ln -s "$(pwd)/shell/inputrc" ~/.inputrc
ln -s "$(pwd)/shell/wgetrc" ~/.wgetrc
ln -s "$(pwd)/shell/zshrc" ~/.zshrc

mkdir ~/.bin
ln -s "$(pwd)/shell/aliases" ~/.bin/aliases.zsh
ln -s "$(pwd)/shell/functions" ~/.bin/functions.zsh

# Install the Dracula Custom theme for iTerm
open "$(pwd)/iterm/themes/Dracula Custom.itermcolors"

# Reload zsh settings
# source ~/.zshrc

echo 'Setup is done. Run `reload!` now!'