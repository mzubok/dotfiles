#!/usr/bin/env bash

platform=$(uname);

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
ln -s "$(pwd)/shell/zshrc" ~/.zshrc

mkdir ~/.bin
ln -s "$(pwd)/shell/aliases.zsh" ~/.bin/aliases.zsh
ln -s "$(pwd)/shell/config.zsh" ~/.bin/config.zsh
ln -s "$(pwd)/shell/functions.zsh" ~/.bin/functions.zsh


if [ platform == 'Darwin' ]; then
    echo 'Instlling iTerm2 theme...'
    open "$(pwd)/iterm/themes/Dracula Custom.itermcolors"
fi

# Reload zsh settings
# source ~/.zshrc

echo 'Setup is done. Run `reload!` now!'
