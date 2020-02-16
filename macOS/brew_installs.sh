#!/usr/bin/env bash

#
# Install/update brew; install some common tools via brew
#

set -x

command -v brew > /dev/null || \
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update --verbose
brew upgrade --verbose
brew cleanup --verbose

brew install --verbose ack
brew install --verbose autojump
brew install --verbose bash-completion
brew install --verbose bat
brew install --verbose cask
brew install --verbose cloc
brew install --verbose clang-format
brew install --verbose colordiff
brew install --verbose coreutils
brew install --verbose cppcheck
brew install --verbose dos2unix
brew install --verbose fd
brew install --verbose gcc
brew install --verbose geoip
brew install --verbose golang
brew install --verbose hadolint
brew install --verbose htop
brew install --verbose httpie
brew install --verbose jq
brew install --verbose nmap
brew install --verbose node
brew install --verbose postgresql
brew install --verbose pyenv
brew install --verbose R
brew install --verbose ripgrep
brew install --verbose scala
brew install --verbose shellcheck
brew install --verbose sqlite
brew install --verbose tree
brew install --verbose unrar
brew install --verbose vim
brew install --verbose watch
brew install --verbose wget
