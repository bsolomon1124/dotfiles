#!/usr/bin/env bash

prompt_yesno() {
    read -r -p "$1     [y]es / [n]o: "
    case "$(echo "$REPLY" | tr '[:upper:]' '[:lower:]')" in
        y|yes) return 0 ;;
        *)     return 1 ;;
    esac
}

echo

CONFIG_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
echo "Confirm location of dotfiles directory:"
echo "    $CONFIG_PATH"
if ! prompt_yesno "Continue?"; then
    echo "Exiting" && exit 1
fi
echo

echo "$CONFIG_PATH" > "${CONFIG_PATH}/.CONFIG_PATH"
echo "Wrote CONFIG_PATH '$CONFIG_PATH' to ${CONFIG_PATH}/.CONFIG_PATH"
ln -svf "${CONFIG_PATH}/.CONFIG_PATH" "${HOME}/.CONFIG_PATH"
echo

for fname in bash_profile bashrc; do
    if [[ -f "${HOME}/.${fname}" ]]; then
        if ! prompt_yesno "Overwrite ~/.${fname}?"; then
            echo "Skipping overwrite of ~/.${fname}"
        else
            ln -vfs "${CONFIG_PATH}/shell/.${fname}" "${HOME}/.${fname}"
        fi
    else
        ln -vfs "${CONFIG_PATH}/shell/.${fname}" "${HOME}/.${fname}"
        echo "Symlinked to new location ~/.${fname}"
    fi
    echo
done



if prompt_yesno "Symlink Git configuration?"; then
    if [[ -f "${HOME}/.gitconfig" ]]; then
        if prompt_yesno 'Overwrite ~/.gitconfig?'; then
            ln -vfs "${CONFIG_PATH}/git/.gitignore_global" "${HOME}/.gitignore_global"
            ln -vfs "${CONFIG_PATH}/git/.gitconfig" "${HOME}/.gitconfig"
        fi
    fi
fi

ln -vs "${CONFIG_PATH}/.screenrc" "${HOME}/.screenrc"
ln -vs "${CONFIG_PATH}/db/.sqliterc" "${HOME}/.sqliterc"
