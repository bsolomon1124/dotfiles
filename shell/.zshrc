# zsh interactive shell init.
# .zprofile handles login-shell env; .zshrc handles interactive goodies.

[[ -z "$PS1" ]] && return

# Ensure CONFIG_PATH is available for non-login interactive shells too
# (e.g., tmux panes, scripted shells) where .zprofile didn't run.
if [[ -z "${CONFIG_PATH-}" && -f "${HOME}/.CONFIG_PATH" ]]; then
    CONFIG_PATH=$(<"${HOME}/.CONFIG_PATH")
    export CONFIG_PATH
fi

# Homebrew fallback if .zprofile wasn't sourced (non-login shell).
if [[ -z "${_BREW_PREFIX-}" ]] && (( ${+commands[brew]} )); then
    _BREW_PREFIX="$(brew --prefix)"
fi

source "${CONFIG_PATH}/shell/environ"
source "${CONFIG_PATH}/shell/aliases"

# Completions. Homebrew installs site-functions into $(brew --prefix)/share/zsh/site-functions.
if [[ -n "${_BREW_PREFIX-}" && -d "${_BREW_PREFIX}/share/zsh/site-functions" ]]; then
    fpath=("${_BREW_PREFIX}/share/zsh/site-functions" $fpath)
fi
autoload -Uz compinit && compinit -u

# Terraform completion (zsh)
if [[ -x "${_BREW_PREFIX}/bin/terraform" ]]; then
    complete -o nospace -C "${_BREW_PREFIX}/bin/terraform" terraform 2>/dev/null || \
        autoload -U +X bashcompinit && bashcompinit && \
        complete -o nospace -C "${_BREW_PREFIX}/bin/terraform" terraform
fi

# Git-aware prompt: user ~/path git:(branch *+)
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats ' -> %b%u%c'
zstyle ':vcs_info:git:*' actionformats ' -> %b|%a%u%c'
precmd() { vcs_info }

setopt PROMPT_SUBST
PROMPT=$'\n%F{cyan} %F{240}%~%F{magenta}${vcs_info_msg_0_}%F{cyan}\n%#%f '

# History
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS SHARE_HISTORY INC_APPEND_HISTORY

# iTerm2 shell integration (zsh)
if [[ -e "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Docker Desktop
if [[ -d /Applications/Docker.app ]]; then
    if [[ -f "${HOME}/.docker/init-zsh.sh" ]]; then
        source "${HOME}/.docker/init-zsh.sh" || true
    fi
fi
if [[ -d "${HOME}/.docker/bin" ]]; then
    export PATH="${HOME}/.docker/bin:${PATH}"
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# VSCode terminal shell integration (zsh)
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)" 2>/dev/null

alias priv='/Applications/Privileges.app/Contents/MacOS/PrivilegesCLI'
alias uuid4='python3 -c "import uuid; print(uuid.uuid4())"'
