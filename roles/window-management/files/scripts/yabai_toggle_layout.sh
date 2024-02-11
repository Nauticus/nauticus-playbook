#!/usr/bin/env bash

# Toggle the workspace (desktop) layout between float and bsp

read -r curType index <<< $(echo $(yabai -m query --spaces --space | jq '.type, .index'))
if [ $curType = '"bsp"' ]; then
  yabai -m space --layout stack
else
  yabai -m space --layout bsp
fi
