#!/usr/bin/env bash

echo 'Removing old directories and symbolic links...'

rm -rf ~/.bin

rm ~/.ackrc
rm ~/.editorconfig
rm ~/.gitconfig
rm ~/.gitignore
rm ~/.curlrc
rm ~/.inputrc
rm ~/.screenrc
rm ~/.wgetrc
rm ~/.zprofile
rm ~/.zshrc

echo 'Creating new symbolic links...'

ln -s "$(pwd)/shell/ackrc" ~/.ackrc
ln -s "$(pwd)/git/gitconfig" ~/.gitconfig
ln -s "$(pwd)/git/gitignore" ~/.gitignore
ln -s "$(pwd)/shell/editorconfig" ~/.editorconfig
ln -s "$(pwd)/shell/curlrc" ~/.curlrc
ln -s "$(pwd)/shell/inputrc" ~/.inputrc
ln -s "$(pwd)/shell/screenrc" ~/.screenrc
ln -s "$(pwd)/shell/wgetrc" ~/.wgetrc
ln -s "$(pwd)/zsh/zprofile" ~/.zprofile
ln -s "$(pwd)/zsh/zshrc" ~/.zshrc

mkdir ~/.bin
ln -s "$(pwd)/shell/aliases.zsh" ~/.bin/aliases.zsh
ln -s "$(pwd)/shell/config.zsh" ~/.bin/config.zsh
ln -s "$(pwd)/shell/functions.zsh" ~/.bin/functions.zsh

# Reload zsh settings
# source ~/.zshrc

echo 'Setup is done. Run `reload!` now!'
