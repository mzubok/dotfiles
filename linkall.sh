#!/usr/bin/env bash

rm ~/.gitconfig
rm ~/.gitignore

rm ~/.curlrc
rm ~/.inputrc
rm ~/.wgetrc

ln -s ~/Projects/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/Projects/dotfiles/git/gitignore ~/.gitignore

ln -s ~/Projects/dotfiles/shell/curlrc ~/.curlrc
ln -s ~/Projects/dotfiles/shell/inputrc ~/.inputrc
ln -s ~/Projects/dotfiles/shell/wgetrc ~/.wgetrc