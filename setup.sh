#!/usr/bin/env bash

rm ~/.gitconfig
rm ~/.gitignore
rm ~/.curlrc
rm ~/.inputrc
rm ~/.wgetrc
rm ~/.zshrc

rm ~/.aliases
rm ~/.functions

ln -s "$(pwd)/git/gitconfig" ~/.gitconfig
ln -s "$(pwd)/git/gitignore" ~/.gitignore
ln -s "$(pwd)/shell/curlrc" ~/.curlrc
ln -s "$(pwd)/shell/inputrc" ~/.inputrc
ln -s "$(pwd)/shell/wgetrc" ~/.wgetrc
ln -s "$(pwd)/shell/zshrc" ~/.zshrc

ln -s "$(pwd)/shell/aliases" ~/.aliases
ln -s "$(pwd)/shell/functions" ~/.functions

# Install the Dracula Custom theme for iTerm
open "$(pwd)/iterm/themes/Dracula Custom.itermcolors"

# Reload zsh settings
source ~/.zshrc