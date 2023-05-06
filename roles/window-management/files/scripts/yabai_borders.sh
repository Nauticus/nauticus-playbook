#!/bin/bash

layout=$(yabai -m query --spaces --space | jq -re '.["type"]')
windows_length=$(yabai -m query --spaces --space | jq -re '.["windows"] | length')

if [[ "$layout" == "bsp" ]]; then
    if [[ $windows_length == 1 ]]; then
        yabai -m config window_border off
    else
        yabai -m config window_border on
    fi
else
    yabai -m config window_border off
fi
