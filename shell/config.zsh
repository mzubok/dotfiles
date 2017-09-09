#!/usr/bin/env zsh

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY       # Adds history
setopt INC_APPEND_HISTORY   # Append history as commands are executed
setopt HIST_IGNORE_ALL_DUPS # Don't save duplicates
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks from each command line
setopt HIST_VERIFY          # Perform history expansion and reload the line into the editing buffer
setopt EXTENDED_HISTORY     # Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds)
unsetopt SHARE_HISTORY      # Disable sharing history between terminals (sessions)

setopt CORRECT  			# Try to correct the spelling of commands