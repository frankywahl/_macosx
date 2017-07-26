#!/bin/bash

PATH_TO_FILE="$(cd `dirname $0` && pwd)";

rm ~/Library/LaunchAgents/Franky.*

# Check for LaunchAgents folder folder
mkdir -p ~/Library/LaunchAgents;

PROGS=(Quicksilver iTerm AppCleaner Hammerspoon)

for PROG in ${PROGS[@]}; do
  echo "Doing ${PROG}"
  if [[ -e /Applications/${PROG}.app/Contents/MacOS/${PROG} ]]; then 
    ln -s ${PATH_TO_FILE}/Library/LaunchAgents/Franky.${PROG}.plist ~/Library/LaunchAgents/Franky.${PROG}.plist
  else 
    echo "${RED}Attention: ${DEFAULT} ${PROG} not found"
  fi
done
