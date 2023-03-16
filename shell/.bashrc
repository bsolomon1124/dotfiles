# pyenv shell environment config
# https://github.com/pyenv/pyenv#basic-github-checkout
if [[ -x "$(command -v pyenv)" ]]; then
    eval "$(pyenv init -)"
fi

# Docker Desktop
if [[ -d /Applications/Docker.app ]]; then
    if [[ -f "${HOME}/.docker/init-bash.sh" ]]; then
        source "${HOME}/.docker/init-bash.sh" || true
    fi
fi

source /Users/brsolomon/.docker/init-bash.sh || true # Added by Docker Desktop
