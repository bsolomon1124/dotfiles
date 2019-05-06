# Generic but useful ~/.bash_profile
# What goes here: stuff useful to many people
# What doesn't go here: stuff only useful in particular cases
# (I.e. manipulating path to accomdate a certain executable)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# System-wide .bashrc file for interactive bash(1) shells.
if [[ -f /etc/bashrc ]]; then
    source /etc/bashrc
fi

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Prompts:
# - Offer alternative "short" and "long" prompts
# - Alter PS1 short prompt: just `$`
PSMED="\[\e[0;32m\] \W$ \[\e[m\]"
PSSHORT="\[\e[0;32m\]$ \[\e[m\]"
PSLONG="\[\e[0;32m\][\t \u   \w]$ \[\e[m\]"
export PS1=$PSSHORT

# Git command completion, if file is there
# See Chacon & Straub - p. 456
if [[ -f /etc/bashrc ]]; then
    source ~/.git-completion.sh
fi

# Turn off blank git commit message prompt
export GIT_MERGE_AUTOEDIT=no

# Idiocy prevention
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# Python-related aliases
if [[ -x $(which tree) ]]; then
    alias pytree='tree -P "*.py" -F --prune' # -I "__pycache__|*.pyc"
fi
if [[ -x $(which python3) ]]; then
    alias pyq="python3 -q"
fi

