#!/bin/bash

osascript \
    -e 'tell application "System Events"'\
    -e 'do shell script quoted form of "/System/Applications/Mission Control.app/Contents/MacOS/Mission Control"'\
    -e 'click button 1 of group "Spaces Bar" of group 1 of group "Mission Control" of process "Dock"'\
    -e 'end tell'
