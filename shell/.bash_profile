# If not running interactively (i.e. we are via `bash argv`), don't do anything
[ -z "$PS1" ] && return

# System-wide .bashrc file for interactive bash(1) shells.
if [ -f /etc/bashrc ]; then
      source /etc/bashrc
fi

CONFIG_PATH="${HOME}/Scripts/python/projects/bsolomon1124/config"
if [[ ! -d "$CONFIG_PATH" ]]; then
    echo "Missing configuration files at $CONFIG_PATH" >&2
    exit 1
fi

source "${CONFIG_PATH}/shell/environ"
source "${CONFIG_PATH}/shell/.bash_aliases"

if [[ -f "$HOME/.git-completion.sh" ]]; then
    source ~/.git-completion.sh  # Git autocomplete- - See Chacon & Straub - p. 456
fi
