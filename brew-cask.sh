#!/usr/bin/env bash

# Install packages
apps=(
    alfred
    arq
    appcleaner
    docker
    forklift
    google-drive
    grammarly
    intellij-idea
    iterm2
    java
    microsoft-remote-desktop-beta
    omnigraffle
    paw
    slack
    sourcetree
    sublime-text
    trailer
)

brew cask install "${apps[@]}"

brew cask cleanup
