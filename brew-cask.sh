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
    knockknock
    microsoft-remote-desktop-beta
    omnigraffle
    paw
    slack
    sourcetree
    sublime-text
    taskexplorer
    trailer
)

brew cask install "${apps[@]}"

brew cask cleanup
