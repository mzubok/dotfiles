#!/usr/bin/env bash

echo 'Removing old directories and symbolic links...'

rm -rf ~/.bin

rm ~/.gitconfig
rm ~/.gitignore
rm ~/.curlrc
rm ~/.inputrc
rm ~/.screenrc
rm ~/.wgetrc
rm ~/.zshrc

echo 'Creating new symbolic links...'

ln -s "$(pwd)/git/gitconfig" ~/.gitconfig
ln -s "$(pwd)/git/gitignore" ~/.gitignore
ln -s "$(pwd)/shell/curlrc" ~/.curlrc
ln -s "$(pwd)/shell/inputrc" ~/.inputrc
ln -s "$(pwd)/shell/screenrc" ~/.screenrc
ln -s "$(pwd)/shell/wgetrc" ~/.wgetrc
ln -s "$(pwd)/shell/zshrc" ~/.zshrc

mkdir ~/.bin
ln -s "$(pwd)/shell/aliases.zsh" ~/.bin/aliases.zsh
ln -s "$(pwd)/shell/config.zsh" ~/.bin/config.zsh
ln -s "$(pwd)/shell/functions.zsh" ~/.bin/functions.zsh

# Install the Dracula Custom theme for iTerm
if [[ `uname` == 'Darwin' ]]; then

    echo 'Instlling iTerm2 theme...'
    open "$(pwd)/iterm/themes/Dracula Custom.itermcolors"

    echo 'Linking Sublime Text 3 settings file...'
    rm "~/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
    ln -s "$(pwd)/sublime/Packages/User/Preferences.sublime-settings" "~/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
fi

# Reload zsh settings
# source ~/.zshrc

echo 'Setup is done. Run `reload!` now!'
