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

# Prompts (Bash Prompt String 1 (use PS1=$PSLONG/$PSSHORT))
# Hijacked in part from https://github.com/mitsuhiko/dotfiles/blob/master/bash/bashrc
if [[ "$(command -v __git_ps1)" ]]; then
    PS1='
[\u in \W$(__git_ps1 " on git:%s")]
\$ '
else
    PS1='
[\u in \W]
\$ '
fi
export PS1

shopt -s histappend
shopt -s checkwinsize
