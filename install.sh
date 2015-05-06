#!/bin/bash

PATH_TO_FILE="$(cd `dirname $0` && pwd)";

rm ~/Library/LaunchAgents/Franky.*

# Check for LaunchAgents folder folder
if [[ ! -d ~/Library/LaunchAgents ]]; then
  mkdir ~/Library/LaunchAgents;
fi

# AppCleaner
if [[ -e /Applications/AppCleaner.app/Contents/MacOS/DaemonManager ]]; then 
  ln -s ${PATH_TO_FILE}/Library/LaunchAgents/Franky.AppCleaner.plist ~/Library/LaunchAgents/Franky.AppCleaner.plist
else
  echo "${RED}Attention: ${DEFAULT} AppCleaner not found"
fi

# Quicksilver
if [[ -d ~/Library/Application\ Support/Quicksilver ]]; then 
  rm ~/Library/Application\ Support/Quicksilver/Triggers.plist
  ln -s ${PATH_TO_FILE}/Library/LaunchAgents/Franky.Quicksilver.plist ~/Library/LaunchAgents/Franky.Quicksilver.plist
  ln -s ${PATH_TO_FILE}/Library/Application\ Support/Quicksilver/Triggers.plist ~/Library/Application\ Support/Quicksilver/Triggers.plist
  if [[ -e ~/Scripts/MacOS/Window/WindowMgt.sh ]]; then
    bash ~/Scripts/MacOS/Window/WindowMgt.sh
  else 
    echo "${RED}Attention: ${DEFAULT} Quicksilver Keyboard shortcuts not found (snap left and snap right)"
  fi
else 
  echo "${RED}Attention: ${DEFAULT} Quicksilver not found"
fi

# Terminal
if [[ -e /Applications/iTerm.app/Contents/MacOS/iTerm ]]; then 
  ln -s ${PATH_TO_FILE}/Library/LaunchAgents/Franky.iTerm.plist ~/Library/LaunchAgents/Franky.iTerm.plist
else 
  echo "${RED}Attention: ${DEFAULT} iTerm not found"
fi

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


