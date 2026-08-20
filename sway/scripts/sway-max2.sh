#!/bin/bash
# Log that the script started
echo "Script started at $(date)" >> /home/arno/sway-debug.log

# Ensure environment
export PATH="/usr/local/bin:/usr/bin:/bin"

# Test logic (does it see swaymsg?)
swaymsg -t get_workspaces > /dev/null 2>> /home/arno/sway-debug.log

# If swaymsg failed, log it
if [ $? -ne 0 ]; then
    echo "Error: swaymsg failed. Is the socket available?" >> /home/arno/sway-debug.log
    exit 1
fi
# Listen continuously for window events
swaymsg -m -t subscribe '["window"]' | while read -r event; do
    # Only trigger when a brand new window is opened
    change=$(echo "$event" | jq -r '.change')
    if [ "$change" = "new" ]; then
        
        # 1. Get the name of the active workspace
        ws_name=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused == true) | .name')
        
        # 2. Count actual application windows (nodes with a PID) inside this specific workspace
        win_count=$(swaymsg -t get_tree | jq --arg ws "$ws_name" '
            .. | objects | select(.type? == "workspace" and .name? == $ws) 
            | [.. | objects | select(.pid? != null)] | length
        ')
        
        # 3. If the count is greater than 2 (meaning the new window makes it 3), migrate it
        if [ "$win_count" -gt 2 ]; then
            # Find the highest workspace number currently open and add 1
            next_ws=$(swaymsg -t get_workspaces | jq '. | map(.num) | max + 1')
            
            # Fallback if parsing fails or workspace numbers are weird
            if [ "$next_ws" = "null" ] || [ "$next_ws" -le 0 ]; then
                next_ws=1
            fi
            
            # Move the newly opened container to the target workspace and follow it
            swaymsg "move container to workspace $next_ws; workspace $next_ws"
        fi
    fi
done
