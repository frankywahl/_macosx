#!/bin/bash

PATH_TO_FILE="$(cd `dirname $0` && pwd)";

rm ~/Library/LaunchAgents/Franky.*

# Check for LaunchAgents folder folder
mkdir -p ~/Library/LaunchAgents;

PROGS=(Quicksilver iTerm AppCleaner Slate)

for PROG in ${PROGS[@]}; do
  echo "Doing ${PROG}"
  if [[ -e /Applications/${PROG}.app/Contents/MacOS/${PROG} ]]; then 
    ln -s ${PATH_TO_FILE}/Library/LaunchAgents/Franky.${PROG}.plist ~/Library/LaunchAgents/Franky.${PROG}.plist
  else 
    echo "${RED}Attention: ${DEFAULT} ${PROG} not found"
  fi
done

echo "Do you want to install system specific configurations (This is still experimental) [y/n]"
read SYSTEM_SPECIFIC
while [[ "$SYSTEM_SPECIFIC" != "y" && "$SYSTEM_SPECIFIC" != "n" ]]
do
  echo "Please tell me if you want to do system specific config? [y/n]"
  read SYSTEM_SPECIFIC
done

if [[ "$SYSTEM_SPECIFIC" = "y" ]]; then
  rm -rf ~/Library/Preferences/com.apple.dock.plist
  ln -s ${PATH_TO_FILE}/Library/Preferences/com.apple.dock.plist ~/Library/Preferences/com.apple.dock.plist
  rm -rf ~/Library/Application\ Support/BetterTouchtool/bttdata2
  ln -s ${PATH_TO_FILE}/Library/Application\ Support/BetterTouchTool/bttdata2 ~/Library/Application\ Support/BetterTouchtool/bttdata2
  killall Dock
fi

