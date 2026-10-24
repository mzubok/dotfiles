#!/usr/bin/env zsh

# http://zsh.sourceforge.net/Doc/Release/Options.html

# History (atuin handles search and sync; this is the plain zsh fallback)
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY   # Append history as commands are executed
setopt HIST_IGNORE_ALL_DUPS # Don't save duplicates
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks from each command line
setopt HIST_VERIFY          # Perform history expansion and reload the line into the editing buffer
setopt EXTENDED_HISTORY     # Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds)
setopt HIST_IGNORE_SPACE    # Don't save commands typed with a leading space (atuin does the same)

# Completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case-insensitive matching
zstyle ':completion:*' menu select                         # Arrow-key menu for multiple matches
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}      # Colour lists (zsh defaults while LS_COLORS is unset)
