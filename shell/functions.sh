#!/usr/bin/env bash

function google()
{
    local query="$*"
    open "https://www.google.com/search?q=${query}"
}

function npgrep()
{
    ps aux | ripgrep "$1"
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
