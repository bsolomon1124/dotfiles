#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo 'Set default: timezone == America/New_York'
systemsetup -settimezone "America/New_York" 2> /dev/null