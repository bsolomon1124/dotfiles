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

# `ls` aliases; GNU ls supports --color, with -G equivalent on MacOS/BSD
if ls --color > /dev/null 2>&1; then
    colorflag='--color'
    export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else
    colorflag='-G'
    export LSCOLORS=ExBxhxDxfxhxhxhxhxcxcx
fi
alias ls="command ls ${colorflag}"

safe_alias l "ls -AFC"
safe_alias ll "l -l"

# Show hidden files only but exclude '.' and '..'
safe_alias hidden "ls -d .[!.]?*"

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

if [[ -x "$(command -v locate)" ]]; then
    safe_alias updatedb 'sudo /usr/libexec/locate.updatedb'
    safe_alias where 'locate'
    safe_alias loc 'locate'
fi

safe_alias pubip 'dig +short myip.opendns.com @resolver1.opendns.com 2> /dev/null || (curl ifconfig.me/ip && echo)'

safe_alias locip 'ipconfig getifaddr en0'

safe_alias grep 'grep --color=auto'

# See separate .gitconfig for git subcommand aliases.
safe_alias g "git"

# Python-related aliases
command -v tree > /dev/null \
    && safe_alias pytree 'tree -P "*.py" -F --prune'

if [[ -x "$(command -v python)" ]]; then
    safe_alias pyq "python3 -q"
    safe_alias py3 'python3'
    safe_alias py2 'python2 -tt'
    safe_alias venv 'python -m venv venv && . ./venv/bin/activate'
fi

safe_alias pygrep 'grep --include \\*.py'
command -v ipython > /dev/null && safe_alias ipy 'ipython'

safe_alias is_priv_ip 'python -c "import ipaddress, sys; print(ipaddress.ip_address(sys.argv[1]).is_private)"'

safe_alias utc 'date --utc 2> /dev/null || date -u'

if [[ -x "$(command -v docker)" ]]; then
    # We use Docker 'grouped' commands, introduced in Docker 1.13
    # https://www.docker.com/blog/whats-new-in-docker-1-13/
    # Note that 'dc' may shadow the 'dc' Polish calculator
    safe_alias d 'docker'
    safe_alias dc 'docker container'
    safe_alias dcl 'docker container ls'
    safe_alias dci 'docker container inspect'
    safe_alias dcr 'docker container run'
    safe_alias dcri 'docker container run -it --rm'
    safe_alias dce 'docker container exec'
    safe_alias dcp 'docker container cp'

    safe_alias di 'docker image'
    safe_alias dil 'docker image ls'

    safe_alias dv 'docker volume'

    safe_alias docker_update_imgs 'docker system prune --force && docker image ls --format "{{.Repository}}:{{.Tag}}" | xargs -L1 docker image pull'
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

is_py2=$(python -c 'import sys; print("%i" % (sys.hexversion<0x03000000))')
if [[ $is_py2 -eq 0 ]]; then
    safe_alias json 'python -m json.tool'
else
    safe_alias json 'python -m json.tool --sort-keys'
fi

safe_alias unwrap 'less -S'
safe_alias nowrap 'less -S'

safe_alias cv 'command -v'

if [[ -x "$(command -v pbcopy)" ]]; then
    cpf() {
        pbcopy < "$1"
    }
fi

# Shutdown/restart/etc
safe_alias restart 'sudo shutdown -r now'
safe_alias sd 'sudo shutdown -h now'
