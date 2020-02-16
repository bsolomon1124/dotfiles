#!/usr/bin/env bash

function google()
{
    local query="$*"
    open "https://www.google.com/search?q=${query}"
}

function npgrep()
{
    ps aux | rg -i "$1"
}

function headers()
{
    if [[ -x "$(command -v http)" ]]; then
        http --headers "$@"
    else
        curl -sv "$@" 2>&1 >/dev/null |
            grep -v "^\*" |
            grep -v "^}" |
            cut -c3-
    fi
}

function manp() {
    # Plain-text man output, without backspaces and underscores
    # A tip from `man man`
    man "$1" | col -b
}

# Usage: untar archive.tar.gz [/dir/to/extract/]
function untar()
{
    local tarball="$1"
    if [[ "$#" -eq 2 ]]; then
        local dest="$2"
        mkdir -p "$dest"
        tar --extract --gzip --verbose --file "$tarball" -C "$dest"
    else
        tar --extract --gzip --verbose --file "$1"
    fi
}

# This list:
# - Values brevity over completeness
# - Excludes a few params that you will probably never use
function specparams()
{
    echo 'Bash special parameters: https://www.gnu.org/software/bash/manual/bash.html'
    echo
    function echott()
    {
        echo -n '    '
        echo "$1"
    }
    echot '$*    Pos. parameters; "$*" expands to "$1 $2 …"'
    echot '$@    Pos. parameters; "$@" expands to "$1" "$2" …'
    echot '$#    Number of positional parameters (excludes script name)'
    echot '$?    Exit status of the most recently executed foreground pipeline'
    echot '$-    Current option flags, e.g. via `set` or `sh -i`'
    echot '$$    PID of shell or invoking (parent) shell'
    echot '$!    PID of most recent background job'
    echot '$0    Name of the shell or shell script'
}

function pyenv_latest()
{
    if [[ ! -x "$(command -v pyenv)" ]]; then
        echo "pyenv not found; exiting" >&2
        exit 1
    fi
}
