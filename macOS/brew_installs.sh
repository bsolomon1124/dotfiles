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

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set +x
ORIG_IFS="$IFS"
IFS=$'\n\t'
pkgs=(
  'ack'
  'autojump'
  'bash-completion'
  'bat'
  'cask'
  'cloc'
  'clang-format'
  'colordiff'
  'coreutils'
  'cppcheck'
  'dos2unix'
  'fd'
  'gawk'
  'gcc'
  'geoip'
  'gnu-sed'
  'golang'
  'greadline'
  'hadolint'
  'htop'
  'httpie'
  'jq'
  'nmap'
  'node'
  'postgresql'
  'pyenv'
  'pygments'
  'readline'
  'redis'
  'R'
  'ripgrep'
  'scala'
  '--HEAD olafurpg/scalafmt/scalafmt'
  '--HEAD olafurpg/scalafmt/scalafix'
  'shellcheck'
  'shfmt'
  'shyaml'
  'sqlite'
  'tree'
  'unrar'
  'vim'
  'watch'
  'wget'
  'xz'
)
for name in ${pkgs[@]}; do
  brew install $name
done
IFS="$ORIG_IFS"
