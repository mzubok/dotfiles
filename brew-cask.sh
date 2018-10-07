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
    java
    kaleidoscope
    knockknock
    little-snitch
    omnigraffle
    paw
    slack
    sublime-text
    taskexplorer
    tower
    trailer
    viscosity
    visual-studio-code
    vlc
    zoomus
)

brew cask install "${apps[@]}"

brew cask cleanup
