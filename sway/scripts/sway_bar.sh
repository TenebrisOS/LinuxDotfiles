#!/bin/bash

# Change this according to your device
keyboard_input_name="1:1:AT_Translated_Set_2_keyboard"

# Swaybar requires an infinite loop to keep updating
while true; do
    # Date and time
    date_and_week=$(date "+%Y/%m/%d")
    current_time=$(date "+%H:%M")

    # Battery or charger (graceful fallback if upower fails)
    battery_charge=$(upower --show-info $(upower --enumerate | grep -i 'BAT' | head -n 1) 2>/dev/null | grep -E "percentage" | awk '{print $2}')
    battery_status=$(upower --show-info $(upower --enumerate | grep -i 'BAT' | head -n 1) 2>/dev/null | grep -E "state" | awk '{print $2}')

    # Audio and multimedia (using default pamixer sink to avoid RUNNING/SUSPENDED errors)
    audio_volume=$(pamixer --get-volume 2>/dev/null || echo "0")
    audio_is_muted=$(pamixer --get-mute 2>/dev/null || echo "true")
    
    media_artist=$(playerctl metadata artist 2>/dev/null)
    media_song=$(playerctl metadata title 2>/dev/null)
    player_status=$(playerctl status 2>/dev/null)

    # Network
    network=$(ip route get 1.1.1.1 2>/dev/null | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
    interface_easyname=$(dmesg | grep "$network" 2>/dev/null | grep renamed | awk 'NF>1{print $NF}')
    
    # Ping (Added -W 1 so it doesn't freeze the bar if offline)
    ping=$(ping -c 1 -W 1 1.1.1.1 2>/dev/null | tail -1 | awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

    # Others
    language=$(swaymsg -r -t get_inputs 2>/dev/null | awk '/'"$keyboard_input_name"'/;/xkb_active_layout_name/' | grep -A1 '\b'"$keyboard_input_name"'\b' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}')
    loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')

    # ==========================================
    # Logic Checks (Quotes added to prevent crashes)
    # ==========================================

    if [ "$battery_status" = "discharging" ]; then
        battery_pluggedin='⚠'
    else
        battery_pluggedin='⚡'
    fi

    if [ -z "$network" ]; then
       network_active="⛔"
       ping="-"
    else
       network_active="⇆"
    fi

    if [ "$player_status" = "Playing" ]; then
        song_status='▶'
    elif [ "$player_status" = "Paused" ]; then
        song_status='⏸'
    else
        song_status='⏹'
    fi

    if [ "$audio_is_muted" = "true" ]; then
        audio_active='🔇'
    else
        audio_active='🔊'
    fi

    # Output to swaybar
    echo "$network_active $interface_easyname ($ping ms) | $audio_active $audio_volume% | $battery_pluggedin $battery_charge | $date_and_week  $current_time"

    # Sleep controls the refresh rate of your bar
    sleep 1
done
