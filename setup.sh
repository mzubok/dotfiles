#!/usr/bin/env bash

rm ~/.gitconfig
rm ~/.gitignore

rm ~/.curlrc
rm ~/.inputrc
rm ~/.wgetrc
rm ~/.zshrc

ln -s ~/Projects/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/Projects/dotfiles/git/gitignore ~/.gitignore

ln -s ~/Projects/dotfiles/shell/curlrc ~/.curlrc
ln -s ~/Projects/dotfiles/shell/inputrc ~/.inputrc
ln -s ~/Projects/dotfiles/shell/wgetrc ~/.wgetrc
ln -s ~/Projects/dotfiles/shell/zshrc ~/.zshrc

# Install the Dracula Custom theme for iTerm
open "${HOME}/Projects/dotfiles/iterm/themes/Dracula Custom.itermcolors"

# Reload zsh settings
source ~/.zshrc