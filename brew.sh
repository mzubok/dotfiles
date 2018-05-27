#!/usr/bin/env bash

# Installs Homebrew and some of the common dependencies needed/desired for software development

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
	echo "Installing Homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install Caskroom
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install brew-cask-upgrade - a command-line tool for upgrading every outdated app installed by Homebrew Cask. 
brew tap buo/cask-upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
# MacOS specific 'UseKeychain' option doesn't work
# brew install openssh
# Terminal multiplexer with VT100/ANSI terminal emulation
brew install screen

# ack is a tool like grep, optimized for programmers
brew install ack
# Plugin manager for zsh
brew install antigen
# Allows to create and view interactive cheatsheets on the command-line
brew install cheat
# Commandline monitoring for containers
brew install ctop
# Commandline monitoring for Java applications
brew install jvmtop
# Good-looking diffs
brew install diff-so-fancy
# Modern replacement for 'ls'
brew install exa
brew install git
brew install git-lfs
brew install gradle
# Interactive text-mode process viewer for Unix systems, it aims to be a better 'top'
brew install htop
# CLI HTTP client, user-friendly curl replacement
brew install httpie
# Lightweight and flexible command-line JSON processor
brew install jq
# Web browser in terminal
brew install lynx
brew install midnight-commander
# Port scanning utility
brew install nmap
# p7zip is a port of 7za.exe for POSIX systems like Unix, MacOS X ...
brew install p7zip
# Pipe viewer - is a terminal-based tool for monitoring the progress of data through a pipeline
brew install pv
# Perl-powered file rename script with many helpful built-ins
brew install rename
# Prints a steam locomotive if you type sl instead of ls
brew install sl
# ssh-copy-id install an SSH key on a server as an authorized key
brew install ssh-copy-id
# A command line tool which checks a server's service on any port for the support of TLS/SSL ciphers, protocols as well as recent cryptographic flaws and more
brew install testssl
# Magnificent app which corrects your previous console command :)
brew install thefuck
# A recursive directory listing command that produces a depth indented listing of files
brew install tree
brew install wget
brew install wifi-password
# Shows the current WiFi network password
brew install zsh
# brew install zsh-completions

# kubernetes
brew install kubernetes-cli
brew install kubernetes-helm
brew install kubectx

brew install ansible
brew install terraform

# Like cat but displays content with syntax highlighting
# brew install ccat
# Static analyzer for Java, C and Objective-C
# brew install infer
# View hosts/ports taking up the most network traffic
# brew install jnettop
# Open client for Cisco AnyConnect VPN
# brew install openconnect
# Parse HTML at the command-line
# brew install pup
# Add GitHub support to git on the command-line
# brew install hub
# Cowsay but with ponies
# brew install ponysay
# Command-line utility for posting snippets to Slack
# brew install slackcat
# brew install sshpass
# Keep Mac's application settings in sync
# brew install mackup
# Small git utilities
# brew install git-extras
# Display an interface's bandwidth usage
# brew install iftop

# Remove outdated versions from the cellar
brew cleanup
