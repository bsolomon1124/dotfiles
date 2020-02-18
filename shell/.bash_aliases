#!/usr/bin/env bash

#
# Useful aliases; use `alias` with no args to list these
#

# Set an alias only if it does not already exist.
# N.B.: alias exit Status: alias returns true unless a NAME is supplied for which no alias has been set
# TODO: maybe we should check that we aren't shadowing executables either; however,
# in some cases, that is exactly what we want to do, e.g. in `rm 'rm -i'`s
function safe_alias()
{
    local name="$1"
    shift
    ( \
        alias "$name" > /dev/null 2>&1 \
        && echo -e "\e[33mSkipping alias of '${name}'; already set\e[39m" >&2 \
    ) || alias "${name}=$*"
}

# Idiocy prevention
safe_alias rm 'rm -i'
safe_alias cp 'cp -i'
safe_alias mv 'mv -i'
safe_alias mkdir 'mkdir -p'

# `ls` aliases
# TODO: https://github.com/mathiasbynens/dotfiles/blob/3fbceb469cc52f021b11f4a0d335c4362366cac4/.aliases#L18
safe_alias l 'ls -CF'  # multi-column output; slash after directories / * after execs
safe_alias ll 'ls -alF'
safe_alias la 'ls -A'
safe_alias lah "ls -lahtFGp"  # Note: --sort is only on Linux
safe_alias hidden "ls -d .[!.]?*"  # exclude . and ..

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Homebrew update + cleanup
command -v brew > /dev/null && safe_alias brewup 'brew update -v && brew upgrade -v && brew cleanup -v'

# Reload the shell (i.e. invoke as a login shell)
safe_alias execsh "exec ${SHELL} -l"

# Print each $PATH entry on a separate line
safe_alias ppath 'echo -e "${PATH//:/\\n}" | sort -f'

# TODO: works on Linux?
safe_alias updatedb 'sudo /usr/libexec/locate.updatedb'

safe_alias pubip 'dig +short myip.opendns.com @resolver1.opendns.com 2> /dev/null || (curl ifconfig.me/ip && echo)'

safe_alias locip 'ipconfig getifaddr en0'

safe_alias grep 'grep --color=auto'

# See separate .gitconfig for git subcommand aliases.
safe_alias g "git"

# Python-related aliases
command -v tree > /dev/null \
    && safe_alias pytree 'tree -P "*.py" -F --prune'

command -v python > /dev/null \
    && safe_alias pyq "python3 -q"

safe_alias pygrep 'grep --include \\*.py'
command -v ipython > /dev/null && safe_alias ipy 'ipython'

safe_alias is_priv_ip 'python -c "import ipaddress, sys; print(ipaddress.ip_address(sys.argv[1]).is_private)"'

safe_alias utc 'date --utc 2> /dev/null || date -u'

if [[ -x "$(command -v docker)" ]]; then
    safe_alias d docker
    safe_alias dcl 'docker container ls --all'
    safe_alias dil 'docker image ls --all'
    safe_alias de 'docker exec'
    safe_alias dcp 'docker cp'
fi

safe_alias bz2 'bzip2'


safe_alias tarls 'tar --list --verbose --file'

# Change terminal window size
safe_alias resize "printf '\e[8;40;80t'; clear"
safe_alias small "printf '\e[8;20;70t'; clear"
safe_alias wide "printf '\e[8;20;150t'; clear"

if [[ -x "$(command -v clang)" ]]; then
    safe_alias clangw "clang -Wall -Werror -Wextra"
fi
safe_alias hist "history"

safe_alias cx "chmod a+x"
safe_alias ca "chmod a+rwx"

# Personally, I think this is much less work than using `jq`
safe_alias json 'python -m json.tool --sort-keys'
