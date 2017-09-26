#!/usr/bin/env bash

# Install packages
apps=(
    alfred
    appcleaner
    docker
    forklift
    google-drive
    grammarly
    intellij-idea
    iterm2
    java
    microsoft-remote-desktop-beta
    paw
    slack
    sourcetree
    sublime-text3
    trailer
)

brew cask install "${apps[@]}"

brew cask cleanup
