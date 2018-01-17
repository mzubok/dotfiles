#!/usr/bin/env bash

# Install packages
apps=(
    alfred
    arq
    appcleaner
    bartender
    docker
    fantastical
    forklift
    google-drive
    grammarly
    intellij-idea
    iterm2
    java
    knockknock
    microsoft-remote-desktop-beta
    omnigraffle
    paw
    slack
    sourcetree
    sublime-text
    taskexplorer
    trailer
    viscosity
)

brew cask install "${apps[@]}"

brew cask cleanup
