#!/usr/bin/env bash

set +x

if [[ ! -x "$(command -v git)" ]]; then
    echo "Vundle installation required git" >&2
    exit 1
fi

DEST="${HOME}/.vim/bundle/Vundle.vim"
rm -rfv "$DEST"
git clone --single-branch \
    https://github.com/VundleVim/Vundle.vim.git \
    "$DEST"
vim +PluginInstall +qall
