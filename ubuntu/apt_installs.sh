#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    echo "Must be root to run this script"
    exit 1
fi

set -ex

apt-get update -y
apt-get autoremove -y

# Note: on Docker containers, man pages are disabled by default;
# see https://stackoverflow.com/a/54814897/7954504 and run
# 'unminimize'
apt-get install -y --no-install-recommends man-db
apt-get install -y --no-install-recommends manpages
apt-get install -y --no-install-recommends manpages-posix

# Keep this alphabetized for sanity
apt-get install -y --no-install-recommends bash-completion
apt-get install -y --no-install-recommends build-essential
apt-get install -y --no-install-recommends bzip2
apt-get install -y --no-install-recommends cloc
apt-get install -y --no-install-recommends dirmngr
apt-get install -y --no-install-recommends git
apt-get install -y --no-install-recommends g++
apt-get install -y --no-install-recommends gcc
apt-get install -y --no-install-recommends gnupg
apt-get install -y --no-install-recommends htop
apt-get install -y --no-install-recommends httpie
apt-get install -y --no-install-recommends pkg-config
apt-get install -y --no-install-recommends libc6-dev
apt-get install -y --no-install-recommends libssl-dev
apt-get install -y --no-install-recommends llvm
apt-get install -y --no-install-recommends locate
apt-get install -y --no-install-recommends lsb-release
apt-get install -y --no-install-recommends make
apt-get install -y --no-install-recommends openssh-client
apt-get install -y --no-install-recommends tree
apt-get install -y --no-install-recommends unrar
apt-get install -y --no-install-recommends unzip
apt-get install -y --no-install-recommends vim
apt-get install -y --no-install-recommends wget
apt-get install -y --no-install-recommends xclip

if (lsb_release -c | grep -q eoan); then
    apt-get install -y --no-install-recommends bat  # Ubuntu 19+
fi

# A few Python/pyenv deps kept separate (some may be above though)
# NOTE: tk-dev will prompt for TZ info; set
#     DEBIAN_FRONTEND=noninteractive ./apt_installs.sh
# to disable prompt
apt-get install -y --no-install-recommends libssl-dev
apt-get install -y --no-install-recommends libbz2-dev
apt-get install -y --no-install-recommends libreadline-dev
apt-get install -y --no-install-recommends libsqlite3-dev
apt-get install -y --no-install-recommends libncurses5-dev
apt-get install -y --no-install-recommends libncursesw5-dev
apt-get install -y --no-install-recommends tk-dev
apt-get install -y --no-install-recommends libffi-dev
apt-get install -y --no-install-recommends liblzma-dev
apt-get install -y --no-install-recommends python-openssl
apt-get install -y --no-install-recommends xz-utils
apt-get install -y --no-install-recommends zlib1g-dev

# Clean up the apt cache
rm -rfv /var/lib/apt/lists/*

# Non-apt-get installs

# Shellcheck
scversion="stable"
wget -qO- "https://storage.googleapis.com/shellcheck/shellcheck-${scversion?}.linux.x86_64.tar.xz" | tar -xJv -C /usr/local/lib
ln -sv "/usr/local/lib/shellcheck-${scversion}/shellcheck" /usr/bin/shellcheck

# ripgrep
rgversion="11.0.2"
dpkgArch="$(dpkg --print-architecture)"
curl -LO "https://github.com/BurntSushi/ripgrep/releases/download/${rgversion}/ripgrep_${rgversion}_${dpkgArch}.deb"
dpkg -i "ripgrep_${rgversion}_${dpkgArch}.deb" && rm -f "ripgrep_${rgversion}_${dpkgArch}.deb"

# Pyenv
curl https://pyenv.run | bash
