#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# -----------------------------------------------------------------------------
# Files
# -----------------------------------------------------------------------------
echo 'Set default: show all filename extensions'
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo 'Set default: show hidden files'
defaults write com.apple.Finder AppleShowAllFiles -bool true

echo 'Set default: disable the warning when changing a file extension'
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# -----------------------------------------------------------------------------
# Finder
# -----------------------------------------------------------------------------
echo 'Set default: allow quitting finder via ⌘ + Q; doing so will also hide desktop icons'
defaults write com.apple.finder QuitMenuItem -bool true

echo 'Set default: disable window animations and Get Info animations in Finder'
defaults write com.apple.finder DisableAllAnimations -bool true

echo 'Set default: show status bar in Finder'
defaults write com.apple.finder ShowStatusBar -bool true

echo 'Set default: show path bar in Finder'
defaults write com.apple.finder ShowPathbar -bool true

echo 'Set default: display full POSIX path as Finder window title'
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo 'Set default: use list view in all Finder windows by default'
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# -----------------------------------------------------------------------------
# Screenshots
# -----------------------------------------------------------------------------
echo 'Set default: save screenshots to ~/Pictures/Screenshots'
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

echo 'Set default: disable shadow in screenshots'
defaults write com.apple.screencapture disable-shadow -bool true

# -----------------------------------------------------------------------------
# Updates
# -----------------------------------------------------------------------------
echo 'Set default: enable the automatic update check'
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

echo 'Set default: check for software updates daily, not just once per week'
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# -----------------------------------------------------------------------------
# Other
# -----------------------------------------------------------------------------
echo 'Set default: autohide the dock'
defaults write com.apple.dock autohide -bool true

echo 'Set default: show battery percentage'
defaults write com.apple.menuextra.battery ShowPercent -string 'YES'

echo 'Set default: show icons for hard drives, servers, and removable media on the desktop'
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo 'Set default: only use UTF-8 in Terminal.app'
defaults write com.apple.terminal StringEncodings -array 4

echo 'Set default: disable the “Are you sure you want to open this application?” dialog'
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo 'Set default: reveal additional info when clicking clock in login window'
# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo 'Set default: timezone == America/New_York'
sudo systemsetup -settimezone "America/New_York" > /dev/null
