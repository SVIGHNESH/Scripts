#!/bin/bash

CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.id')
WS_YOUTUBE=$((CURRENT_WS + 1))
WS_IDEA=$((CURRENT_WS + 2))
WS_POSTMAN=$((CURRENT_WS + 3))

wait_for_window() {
    local class=$1
    local timeout=${2:-10}
    local count=0
    while [ $count -lt $timeout ]; do
        hyprctl clients -j | jq -e ".[] | select(.class == \"$class\")" > /dev/null 2>&1 && return 0
        sleep 0.5
        count=$((count + 1))
    done
    return 1
}

firefox "https://youtube.com" &
wait_for_window "Navigator" 15
hyprctl dispatch movetoworkspace "$WS_YOUTUBE,Navigator"

~/.local/share/JetBrains/Toolbox/scripts/idea &
wait_for_window "idea" 20
hyprctl dispatch movetoworkspace "$WS_IDEA,idea"

postman &
wait_for_window "Postman" 15
hyprctl dispatch movetoworkspace "$WS_POSTMAN,Postman"
