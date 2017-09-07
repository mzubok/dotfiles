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
# macos specific 'UseKeychain' option doesn't work
# brew install openssh
brew install screen

# ack is a tool like grep, optimized for programmers
brew install ack
# plugin manager for zsh
brew install antigen
# allows to create and view interactive cheatsheets on the command-line
brew install cheat
# commandline monitoring for containers
brew install ctop
# good-looking diffs
brew install diff-so-fancy
brew install git
brew install git-lfs
brew install gradle
# interactive text-mode process viewer for Unix systems, it aims to be a better 'top'
brew install htop
# CLI HTTP client, user-friendly curl replacement
brew install httpie
# lightweight and flexible command-line JSON processor
brew install jq
brew install lua
# web browser in terminal
brew install lynx
brew install midnight-commander
brew install nmap
# p7zip is a port of 7za.exe for POSIX systems like Unix, MacOS X ...
brew install p7zip
# pipe viewer - is a terminal-based tool for monitoring the progress of data through a pipeline
brew install pv
brew install rename
brew install sl
# ssh-copy-id install an SSH key on a server as an authorized key
brew install ssh-copy-id
# a command line tool which checks a server's service on any port for the support of TLS/SSL ciphers, protocols as well as recent cryptographic flaws and more
brew install testssl
# magnificent app which corrects your previous console command :)
brew install thefuck
# a recursive directory listing command that produces a depth indented listing of files
brew install tree
brew install wget
brew install wifi-password
brew install zsh
# brew install zsh-completions

# modern replacement for 'ls'
# brew install exa
# like cat but displays content with syntax highlighting
# brew install ccat
# static analyzer for Java, C and Objective-C
# brew install infer
# view hosts/ports taking up the most network traffic
# brew install jnettop
# open client for Cisco AnyConnect VPN
# brew install openconnect
# parse HTML at the command-line
# brew install pup
# add GitHub support to git on the command-line
# brew install hub
# cowsay but with ponies
# brew install ponysay
# command-line utility for posting snippets to Slack
# brew install slackcat
# brew install sshpass
# keep Mac's application settings in sync
# brew install mackup
# small git utilities
# brew install git-extras
# display an interface's bandwidth usage
# brew install iftop

# Remove outdated versions from the cellar
brew cleanup
