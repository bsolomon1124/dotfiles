# zsh login shell init (runs before .zshrc for login shells).
# On macOS Terminal.app / iTerm2, new windows are login shells.

if [[ ! -f "${HOME}/.CONFIG_PATH" ]]; then
    print -u2 "CONFIG_PATH not set; exiting"
    exit 1
fi

CONFIG_PATH=$(<"${HOME}/.CONFIG_PATH")
if [[ -z "$CONFIG_PATH" || ! -d "$CONFIG_PATH" ]]; then
    print -u2 "Missing configuration files at CONFIG_PATH '$CONFIG_PATH'"
    exit 1
fi
export CONFIG_PATH

# Homebrew env (shellenv handles PATH/MANPATH/INFOPATH across arches)
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if (( ${+commands[brew]} )); then
    _BREW_PREFIX="$(brew --prefix)"
    export PATH="${_BREW_PREFIX}/opt/openssl/bin:${_BREW_PREFIX}/sbin:${PATH}"
fi
