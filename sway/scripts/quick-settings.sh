#!/bin/bash
# A simple dmenu-based quick settings menu
choice=$(echo -e " Wi-Fi\n Bluetooth\n Night Light\n Power Off" | wofi --dmenu -p "Quick Settings")

case "$choice" in
    *Wi-Fi) nm-connection-editor ;;
    *Bluetooth) blueman-manager ;;
    *Night Light) wlsunset -t 4000 -T 6500 ;; # Example toggle
    *Power\ Off) swaynag -t warning -m 'Power Menu' -b 'Shutdown' 'shutdown -h now' -b 'Reboot' 'reboot' ;;
esac
