# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# Check window dimensions after each line
shopt -s checkwinsize

# Completion options
bind 'set page-completions off'
bind 'set show-all-if-ambiguous on'

# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoreboth
export HISTSIZE=2000
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[5~": beginning-of-history'
bind '"\e[6~": end-of-history'

# Use UTF-8 in terminal
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Aliases

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias ag='ag --color-match="1;31" --color-path=35 --color-line-number=32'
alias code='/c/Program\ Files/Microsoft\ VS\ Code/Code.exe'
if [ -f '/c/Program Files (x86)/Meld/Meld.exe' ]; then
    alias meld='/c/Program\ Files\ \(x86\)/Meld/Meld.exe'
elif [ -f '/c/Program Files/Meld/Meld.exe' ]; then
    alias meld='/c/Program\ Files/Meld/Meld.exe'
fi

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

alias vi='vim'

# Stolen from Git-bash
# If MSYS2_PS1 is set, use that as default PS1;
# if a PS1 is already set and exported, use that;
# otherwise set a default prompt
# of user@host, MSYSTEM variable, and current_directory
[[ -n "${MSYS2_PS1}" ]] && export PS1="${MSYS2_PS1}"
# if we have the "High Mandatory Level" group, it means we're elevated
#if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"
#  then _ps1_symbol='\[\e[1m\]#\[\e[0m\]'
#  else _ps1_symbol='\$'
#fi
[[ $(declare -p PS1 2>/dev/null | cut -c 1-11) = 'declare -x ' ]] || \
  export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"' '
unset _ps1_symbol

# Uncomment to use the terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

# Fixup git-bash in non login env
if [ -f /etc/profile.d/git-prompt.sh ]; then
    shopt -q login_shell || . /etc/profile.d/git-prompt.sh
fi
