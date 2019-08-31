#!/usr/bin/env bash

if [ ! -f /etc/debian_version ]; then
    echo "Only Debiab is currently supported"
    exit
fi

# Test to see if zsh is installed
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Set the default shell to zsh if it isn't currently set to zsh
    echo "Zsh has been already installed"
    if [[ ! "$(echo $SHELL)" == "$(which zsh)" ]]; then
        echo "Switching to zsh"
        # chsh -s "$(which zsh)"
    fi
else
    echo "Installin sh"
    apt-get install -y zsh
    echo "Switching to zsh"
    # chsh -s "$(which zsh)"
fi

# Install Antigen if it isn't already present
antigen_dir="/usr/local/share/antigen"
if [ ! -d "${antigen_dir}" ]; then
    echo "Installin antigen"
    mkdir -p "${antigen_dir}"
    curl -L https://git.io/antigen > "${antigen_dir}/antigen.zsh"
    source "${antigen_dir}/antigen.zsh"
else
    echo "Enabling antigen"
    source "${antigen_dir}/antigen.zsh"
fi