#!/bin/bash

# Define the profiles
PROFILES="power-saver
balanced
performance"

# Present the menu via Fuzzel
SELECTED=$(echo "$PROFILES" | fuzzel --dmenu -p "Select Power Profile: ")

# Act on the selection and send notification
case "$SELECTED" in
    power-saver)
        powerprofilesctl set power-saver
        notify-send -u low -i battery-caution "Power Profile" "Switched to Power Saver"
        ;;
    balanced)
        powerprofilesctl set balanced
        notify-send -u low -i battery-good "Power Profile" "Switched to Balanced"
        ;;
    performance)
        powerprofilesctl set performance
        notify-send -u critical -i battery-full-charged "Power Profile" "Switched to Performance"
        ;;
    *)
        exit 0
        ;;
esac
