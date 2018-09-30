#!/usr/bin/env bash

# Install packages
apps=(
    alfred
    arq
    appcleaner
    authy
    bartender
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
    sourcetree
    sublime-text
    taskexplorer
    trailer
    viscosity
    visual-studio-code
    vlc
    zoomus
)

brew cask install "${apps[@]}"

brew cask cleanup
