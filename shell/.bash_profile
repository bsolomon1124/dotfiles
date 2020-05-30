# Don't print 'The default interactive shell is now zsh'
# on login.  https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

# If not running interactively (i.e. we are via `bash argv`), don't do anything
[ -z "$PS1" ] && return

# System-wide .bashrc file for interactive bash(1) shells.
if [ -f /etc/bashrc ]; then
      source /etc/bashrc
fi

CONFIG_PATH="${HOME}/Scripts/python/projects/bsolomon1124/config"
if [[ ! -d "$CONFIG_PATH" ]]; then
    echo "Missing configuration files at $CONFIG_PATH" >&2
    exit 1
fi

function grab_git_completion_script()
{
    local scriptname="$1"
    if [[ ! -f "$HOME/.$scriptname" ]]; then
        if [[ "$(command -v locate)" ]]; then
            locate -0 -l 1 "$scriptname" | xargs -I % -t -0 cp % "$HOME/.$scriptname"
        else if [[ "$(command -v mdfind)" ]]; then
        	mdfind -name "$scriptname"  | head -n1 | xargs -I % -t cp % "$HOME/.$scriptname"
        else
            find / -name "$scriptname" -type f -exec cp {} "$HOME/.$scriptname" \; -quit 2>/dev/null
        fi
        if [[ ! -f "$HOME/.$scriptname" ]]; then
            curl -sSL -o "$HOME/.$scriptname" "https://raw.githubusercontent.com/git/git/master/contrib/completion/$scriptname"
        fi
    fi
}

grab_git_completion_script "git-prompt.sh" &&  source ~/.git-prompt.sh
grab_git_completion_script "git-completion.bash" &&  source ~/.git-completion.bash

source "${CONFIG_PATH}/shell/environ"
source "${CONFIG_PATH}/shell/.bash_aliases"

# Bash prompt - looks like `user ~/path/to/directory git:branchname`
if [[ "$(command -v __git_ps1)" ]]; then
    PS1='\n\[\033[36m\]\u \[\033[34m\]\w\[\033[35m\]$(__git_ps1 " git:%s")\[\033[96m\]\n\$\[\033[0m\] '
else
    PS1='\n\[\033[36m\]\u \[\033[34m\]\w\[\033[96m\]\n\$\[\033[0m\] '
fi
export PS1
