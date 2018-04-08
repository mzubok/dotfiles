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
    istat-menus
    iterm2
    java
    kaleidoscope
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
    vlc
)

brew cask install "${apps[@]}"

brew cask cleanup
