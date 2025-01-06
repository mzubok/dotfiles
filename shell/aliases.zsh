#!/usr/bin/env zsh

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# PS
alias psa="ps aux"
alias psg="ps aux | grep "

# Show human friendly numbers and colors
alias df="df -h"
alias du="du -h -d 1"

# Zippin
alias gz='tar -zcvf'

# ls, the common ones I use a lot shortened for rapid fire usage
alias l='eza -lh'     # size,show type,human readable
alias la='eza -alhg'  # long list,show almost all,show type,human readable
alias lr='ls -tRFh'   # sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   # long list,sorted by date,show type,human readable
alias ll='ls -l'      # long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias unexport='unset'

alias zshrc='$EDITOR ~/.zshrc' # Quick access to the ~/.zshrc file
alias reload!='. ~/.zshrc'

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# Ask to override
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

alias hosts='$EDITOR /etc/hosts'
# Copy my public key to the pasteboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
# Localrc config
alias localrc="if [[ -a ~/.localrc ]]; then ${EDITOR} ~/.localrc; fi"
# Flush DNS cache
alias flushdns="dscacheutil -flushcache"

# Shortcuts
alias x+="chmod +x"
alias -- +x="chmod +x"
alias unlock="chflags -R nouchg"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup'

alias ping='prettyping --nolegend'
alias du="ncdu --color dark -rr -x --exclude .git"

alias lookbusy="cat /dev/urandom | hexdump -C | grep \"34 32\""

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Start a simple HTTP server to serve files from current directory
alias server="python3 -m http.server 8000"

# fzf
alias v='fzf --preview "bat --color=always {}"'
