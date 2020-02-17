#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    echo "Must be root to run this script"
    exit 1
fi

set -ex

apt-get update -y
apt-get autoremove -y

apt-get install -y --no-install-recommends man-db

# Keep this alphabetized for sanity
apt-get install -y --no-install-recommends build-essential
apt-get install -y --no-install-recommends bzip2
apt-get install -y --no-install-recommends dirmngr
apt-get install -y --no-install-recommends git
apt-get install -y --no-install-recommends g++
apt-get install -y --no-install-recommends gcc
apt-get install -y --no-install-recommends gnupg
apt-get install -y --no-install-recommends pkg-config
apt-get install -y --no-install-recommends libc6-dev
apt-get install -y --no-install-recommends libssl-dev
apt-get install -y --no-install-recommends llvm
apt-get install -y --no-install-recommends make
apt-get install -y --no-install-recommends openssh-client
apt-get install -y --no-install-recommends tree
apt-get install -y --no-install-recommends unzip
apt-get install -y --no-install-recommends vim
apt-get install -y --no-install-recommends wget

# A few Python/pyenv deps kept separate (some may be above though)
# NOTE: tk-dev will prompt for TZ info; set
#     DEBIAN_FRONTEND=noninteractive ./apt_installs.sh
# to disable prompt
apt-get install -y --no-install-recommends libssl-dev
apt-get install -y --no-install-recommends zlib1g-dev
apt-get install -y --no-install-recommends libbz2-dev
apt-get install -y --no-install-recommends libreadline-dev
apt-get install -y --no-install-recommends libsqlite3-dev
apt-get install -y --no-install-recommends libncurses5-dev
apt-get install -y --no-install-recommends libncursesw5-dev
apt-get install -y --no-install-recommends xz-utils
apt-get install -y --no-install-recommends tk-dev
apt-get install -y --no-install-recommends libffi-dev
apt-get install -y --no-install-recommends liblzma-dev
apt-get install -y --no-install-recommends python-openssl

# Clean up the apt cache
rm -rfv /var/lib/apt/lists/*

