#!/usr/bin/env bash

# Install packages
apps=(
    alfred
    arq
    authy
    bartender
    cleanmymac
    daisydisk
    docker
    fantastical
    forklift
    google-drive
    grammarly
    intellij-idea
    iterm2
    kaleidoscope
    knockknock
    little-snitch
    nordvpn
    omnigraffle
    paw
    slack
    sublime-text
    taskexplorer
    textual
    tower
    trailer
    viscosity
    visual-studio-code
    vlc
)

brew cask install "${apps[@]}"

brew cask cleanup
