#!/bin/bash
SELECTION=$(printf "Lock\nSuspend\nLog out\nReboot\nShutdown" | fuzzel --dmenu -p "Power Menu: ")

case $SELECTION in
    "Lock") swaylock ;;
    "Suspend") systemctl suspend ;;
    "Log out") swaymsg exit ;;
    "Reboot") systemctl reboot ;;
    "Shutdown") systemctl poweroff ;;
esac
