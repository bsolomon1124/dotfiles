# Don't print 'The default interactive shell is now zsh'
# on login.  https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

# If not running interactively (i.e. we are via `bash argv`), don't do anything
[ -z "$PS1" ] && return

# System-wide .bashrc file for interactive bash(1) shells.
if [ -f /etc/bashrc ]; then
      source /etc/bashrc
fi

if [[ ! -f "${HOME}/.CONFIG_PATH" ]]; then
    echo "CONFIG_PATH not set; exiting" >&2
    exit 1
fi

# Disable builtin 'command', which does not show the full path
enable -n command

CONFIG_PATH=$(<.CONFIG_PATH)
if [[ -z "$CONFIG_PATH" ]]; then
    echo "CONFIG_PATH empty; exiting" >&2
    exit 1
fi

if [[ ! -d "$CONFIG_PATH" ]]; then
    echo "Missing configuration files at CONFIG_PATH '$CONFIG_PATH'" >&2
    exit 1
fi

function grab_git_completion_script()
{
    local scriptname="$1"
    if [[ ! -f "$HOME/.$scriptname" ]]; then
        if [[ "$(command -v locate)" ]]; then
            locate -0 -l 1 "$scriptname" | xargs -I % -t -0 cp % "$HOME/.$scriptname"
        elif [[ "$(command -v mdfind)" ]]; then
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

# Pyenv: https://github.com/pyenv/pyenv#basic-github-checkout
# Need to account for if pyenv was installed through brew,
# in which case it will not be under ~ and we do *not* need
# to manipulate path or PYENV_ROOT
if brew list --versions pyenv > /dev/null; then
    if [[ -x "$(command -v pyenv)" ]]; then
        eval "$(pyenv init -)"
    fi
    if [[ -x "$(command -v pyenv-virtualenv-init)" ]]; then
        eval "$(pyenv virtualenv-init -)"
    fi
elif [[ -d "$HOME/.pyenv" ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    if [[ -x "$(command -v pyenv)" ]]; then
        eval "$(pyenv init -)"
        if [[ -x "$(command -v pyenv-virtualenv-init)" ]]; then
            eval "$(pyenv virtualenv-init -)"
        fi
    fi
fi

source "${CONFIG_PATH}/shell/environ"
source "${CONFIG_PATH}/shell/.bash_aliases"

# Bash prompt - looks like `user ~/path/to/directory git:branchname`
if [[ "$(type -t '__git_ps1')" == 'function' ]]; then
    PS1='\n\[\033[36m\]\u \[\033[34m\]\w\[\033[35m\]$(__git_ps1 " -> %s")\[\033[96m\]\n\$\[\033[0m\] '
else
    PS1='\n\[\033[36m\]\u \[\033[34m\]\w\[\033[96m\]\n\$\[\033[0m\] '
fi
export PS1
