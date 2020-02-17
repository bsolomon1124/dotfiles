#!/usr/bin/env bash

set -x

echo "Set default: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Set default: show hidden files"
defaults write com.apple.Finder AppleShowAllFiles -bool true

echo "Set default: autohide the dock"
defaults write com.apple.dock autohide -bool true

echo "Set default: show battery percentage"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
