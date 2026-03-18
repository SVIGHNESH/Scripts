#!/bin/bash

firefox &
sleep 3
wait_for_window() {
    local timeout=15
    local count=0
    while [ $count -lt $timeout ]; do
        hyprctl clients -j | jq -e ".[] | select(.class == \"firefox\")" > /dev/null 2>&1 && return 0
        sleep 0.5
        count=$((count + 1))
    done
    return 1
}
wait_for_window
hyprctl dispatch movetoworkspace 1,firefox
