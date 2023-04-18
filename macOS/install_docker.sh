#!/usr/bin/env bash

set -eux
set -o pipefail

# Install Docker Desktop on Mac
# Note that `brew install docker` only installs the CLI, not docker engine
# Also, there doesn't appear to be support for 'homebrew/cask/docker' in Brewfile
#
# Alternative: https://docs.docker.com/desktop/install/mac-install/
# https://github.com/Homebrew/homebrew-cask/blob/master/Casks/docker.rb

if [[ -d /Applications/Docker.app ]]; then
    echo Docker already installed
    exit 0
fi

for i in \
    docker-completion \
    docker-compose \
    docker-compose-completion \
    docker-credential-helper-ecr \
    hyperkit \
    kubernetes-cli; do
    if brew list | grep -q -F "$i"; then
        brew remove "$i"
    fi
done
sudo find /usr "$(dirname $(brew --prefix))" -iregex '.*bash_completion.d/docker-compose' -type f -print -delete 2>/dev/null || true

# Docker CLI user-bin installation
# https://docs.docker.com/desktop/settings/mac/#advanced

if [[ ! -d "${HOME}/.docker" ]]; then
    mkdir "${HOME}/.docker"
fi

if [[ ! -d "${HOME}/.docker/bin" ]]; then
    mkdir "${HOME}/.docker/bin"
fi

brew install -v --cask docker
