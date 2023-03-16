#!/usr/bin/env bash

prompt_yesno() {
    read -r -p "$1     [y]es / [n]o: "
    case "$(echo "$REPLY" | tr '[:upper:]' '[:lower:]')" in
        y|yes) return 0 ;;
        *)     return 1 ;;
    esac
}

clear
echo
echo    '--- --- --- MacOS environment bootstrap --- --- ---'
echo
echo -e "\033[1mWARNING\033[0m: this script will overwrite files"
echo    "such as ~/.bash_profile and ~/.gitignore."
echo
echo    "Confirm each action carefully."
echo

CONFIG_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
echo "Confirm dotfiles directory location (source of this script):"
echo "    $CONFIG_PATH"
echo
if ! prompt_yesno "Continue?"; then
    echo "Exiting" && exit 1
fi
echo

echo "$CONFIG_PATH" > "${CONFIG_PATH}/.CONFIG_PATH"
echo -e "\033[1mWrote\033[0m CONFIG_PATH marker:"
echo    "    src: $CONFIG_PATH"
echo    "    dest: ${CONFIG_PATH}/.CONFIG_PATH"
echo
ln -svf "${CONFIG_PATH}/.CONFIG_PATH" "${HOME}/.CONFIG_PATH"
echo

enable -n command
pushd "${CONFIG_PATH}/macOS" || exit 1
if [[ ! -x "$(command -v brew)" ]]; then
    /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
HOMEBREW_NO_ENV_HINTS=1 brew bundle --verbose
popd

for fname in bash_profile bashrc hushlogin; do
    if [[ -f "${HOME}/.${fname}" ]]; then
        echo -e "\e[0;91mWarning\033[0m: Target ~/.${fname} exists"
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
        echo -e "\e[0;91mWarning\033[0m: Target ${CONFIG_PATH}/git/.gitconfig exists"
        if prompt_yesno 'Overwrite ~/.gitconfig?'; then
            ln -vfs "${CONFIG_PATH}/git/.gitignore_global" "${HOME}/.gitignore_global"
            ln -vfs "${CONFIG_PATH}/git/.gitconfig" "${HOME}/.gitconfig"
            echo
            default_name="$(id -F)"
            read -r -p "Git global user.name (default '$default_name'): " GIT_CONFIG_USER_NAME
            read -r -p "Git global user.email: " GIT_CONFIG_USER_EMAIL
            set -x
            git config --global user.name "$GIT_CONFIG_USER_NAME"
            git config --global user.email "$GIT_CONFIG_USER_EMAIL"
            set +x
        fi
    fi
fi

ln -vfs "${CONFIG_PATH}/.screenrc" "${HOME}/.screenrc"
ln -vfs "${CONFIG_PATH}/db/.sqliterc" "${HOME}/.sqliterc"
