#!/usr/bin/env bash

# Install packages
apps=(
    alfred
    docker
    forklift
    google-drive
    grammarly
    intellij-idea
    iterm2
    java
    paw
    slack
    sourcetree
    sublime-text
    trailer
)

brew cask install "${apps[@]}"

brew cask cleanup