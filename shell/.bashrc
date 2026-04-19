# Docker Desktop
if [[ -d /Applications/Docker.app ]]; then
    if [[ -f "${HOME}/.docker/init-bash.sh" ]]; then
        source "${HOME}/.docker/init-bash.sh" || true
    fi
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# VSCode Terminal Shell Integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path bash)"
