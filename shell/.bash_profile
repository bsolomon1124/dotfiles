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
            locate -0 -l 1 "$scriptname" | $(type -p gxargs xargs | head -n1 ) -r -I % -t -0 cp % "$HOME/.$scriptname"
        elif [[ "$(command -v mdfind)" ]]; then
            mdfind -name "$scriptname"  | head -n1 | $(type -p gxargs xargs | head -n1 ) -r -I % -t cp % "$HOME/.$scriptname"
        else
            find / -name "$scriptname" -type f -exec cp {} "$HOME/.$scriptname" \; -quit 2>/dev/null
        fi

        if [[ ! -f "$HOME/.$scriptname" ]]; then
            curl -fsSL -o "$HOME/.$scriptname" "https://raw.githubusercontent.com/git/git/master/contrib/completion/$scriptname"
        fi
    fi
}

if [[ -x "$(command -v pyenv)" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    if [ -n "$PS1" -a -n "$BASH_VERSION" ]; then source ~/.bashrc; fi
fi

grab_git_completion_script "git-prompt.sh" && source ~/.git-prompt.sh
grab_git_completion_script "git-completion.bash" && source ~/.git-completion.bash

source "${CONFIG_PATH}/shell/environ"
source "${CONFIG_PATH}/shell/.bash_aliases"

_BREW_REFIX="$(brew --prefix)"

# bash-completion from homebrew for bash, docker, etc
if [[ -r "${_BREW_REFIX}/etc/profile.d/bash_completion.sh" ]]; then
    . "${_BREW_REFIX}/etc/profile.d/bash_completion.sh"
fi

if [ -f "${_BREW_REFIX}/etc/bash_completion" ]; then
    . "${_BREW_REFIX}/etc/bash_completion"
fi

# Bash prompt - looks like `user ~/path/to/directory git:branchname`
if [[ "$(type -t '__git_ps1')" == 'function' ]]; then
    PS1='\n\[\033[36m\] \[\033[90m\]\w\[\033[35m\]$(__git_ps1 " -> %s")\[\033[96m\]\n\$\[\033[0m\] '
else
    PS1='\n\[\033[36m\] \[\033[90m\]\w\[\033[96m\]\n\$\[\033[0m\] '
fi
export PS1

if [ -e "${HOME}/.iterm2_shell_integration.bash" ]; then
    source "${HOME}/.iterm2_shell_integration.bash"
else
    curl -fsSL https://iterm2.com/shell_integration/install_shell_integration.sh | bash
fi

# Docker Desktop
if [[ -d /Applications/Docker.app ]]; then
    if [[ -f "${HOME}/.docker/init-bash.sh" ]]; then
        source "${HOME}/.docker/init-bash.sh" || true
    fi
fi
