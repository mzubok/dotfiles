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
brew upgrade # --all

# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

# Install brew-cask-upgrade - a command-line tool for upgrading every outdated app installed by Homebrew Cask.
# brew tap buo/cask-upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don't forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
# Don't forget to add `$(brew --prefix gnu-sed)/libexec/gnubin` to `$PATH`.
brew install gnu-sed

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
# MacOS specific 'UseKeychain' option doesn't work
# brew install openssh
# Terminal multiplexer with VT100/ANSI terminal emulation
# brew install screen

# ack is a tool like grep, optimized for programmers
brew install ack
# A code-searching tool
brew install ag
# brew install ant
# Plugin manager for zsh
brew install antigen
# Cloudflare's PKI and TLS toolkit
brew install cfssl
# Allows to create and view interactive cheatsheets on the command-line
# brew install cheat
# Commandline monitoring for containers
# brew install ctop
# Commandline monitoring for Java applications
# brew install jvmtop
# Good-looking diffs
brew install diff-so-fancy
brew install direnv
# Modern replacement for 'ls'
brew install eza
brew install git
# brew install git-lfs
# brew install go
brew install gradle
# brew install groovy
brew install hexyl
# Interactive text-mode process viewer for Unix systems, it aims to be a better 'top'
brew install htop
# CLI HTTP client, user-friendly curl replacement
brew install httpie
# Lightweight and flexible command-line JSON processor
brew install jq
# Web browser in terminal
# brew install lynx
brew install maven
brew install midnight-commander
# Port scanning utility
brew install nmap
# brew install nnn
# p7zip is a port of 7za.exe for POSIX systems like Unix, MacOS X ...
brew install p7zip
brew install pipenv
# Pipe viewer - is a terminal-based tool for monitoring the progress of data through a pipeline
brew install pv
# Perl-powered file rename script with many helpful built-ins
brew install rename
# Fetches system/theme information in terminal
brew install screenfetch
# Finds bugs in shell scripts
brew install shellcheck
# ssh-copy-id install an SSH key on a server as an authorized key
brew install ssh-copy-id
# A command line tool which checks a server's service on any port for the support of TLS/SSL ciphers, protocols as well as recent cryptographic flaws and more
brew install testssl
brew install tmux
# Magnificent app which corrects your previous console command :)
brew install thefuck
# A recursive directory listing command that produces a depth indented listing of files
brew install tree
brew install wget
brew install zsh
brew install zsh-completions

# gpg
brew install gnupg
brew install pinentry-mac # echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf

# kubernetes
brew install kubernetes-cli
brew install kubernetes-helm
brew install kubectx
brew install helmfile

brew install ansible
brew install terraform
brew install terraform-docs
brew install packer
brew install vault

# Static analyzer for Java, C and Objective-C
# brew install infer
# View hosts/ports taking up the most network traffic
brew install jnettop
# Parse HTML at the command-line
brew install pup
# brew install sshpass
# Keep Mac's application settings in sync
# brew install mackup
# Small git utilities
brew install git-extras
# Display an interface's bandwidth usage
brew install iftop
# A cat(1) clone that supports syntax highlighting for a large number of programming and markup languages
brew install bat
# A disk usage analyzer with an ncurses interface
brew install ncdu
# The TLDR pages are a community effort to simplify the beloved man pages with practical examples
brew install tldr
# Monitor a process and trigger a notification
brew install noti
# Pretty ping :)
brew install prettyping
brew install asciinema
# A horizontal ruler for terminal
brew install hr
# Dockerfile linter
brew install hadolint
# A command line interface for Postgres with auto-completion and syntax highlighting
brew install pgcli

# A Docker manager for the terminal
# brew tap moncho/dry
# brew install dry

brew install awscli
brew install azure-cli
# brew tap weaveworks/tap
# brew install weaveworks/tap/eksctl

# A customizable cross-platform graphical process/system monitor for the terminal,
brew install bottom
# Clifm is a shell-like, text-based terminal file manager that sits on the command line.
brew install clifm
# Dasel (short for data-selector) allows you to query and modify data structures using selector strings.
# Comparable to jq / yq, but supports JSON, YAML, TOML, XML and CSV with zero runtime dependencies.
brew install dasel
brew install ffmpeg
# A command-line JSON viewer designed for reading, exploring, and searching through JSON data.
brew install jless
# Command-line XML and HTML beautifier and content extractor.
brew install xq
# A lightweight and portable command-line YAML, JSON and XML processor.
brew install yq
# Zellij is a terminal workspace. It has the base functionality of a terminal multiplexer (similar to tmux or screen)
# but includes many built-in features that would allow users to extend it and create their own personalized environment.
brew install zellij

# Remove outdated versions from the cellar
brew cleanup
