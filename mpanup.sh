#!/bin/bash

echo "mpanup starting"

# Detect monitors
mapfile -t monitors < <(xrandr --listmonitors | awk 'NR>1 {print $4}')
monitor_count=${#monitors[@]}
echo "Detected $monitor_count monitor(s)"

# Reset existing panels
dconf reset -f /org/mate/panel/

# Load Parrot default panels
dconf load /org/mate/panel/ < /usr/local/share/mpanup/parrot-panels.conf

# Reassign panels to each monitor
panel_ids=$(gsettings get org.mate.panel.general toplevel-id-list | tr -d "[],'")
read -r -a panels <<< "$panel_ids"

for i in "${!monitors[@]}"; do
    TOP_PANEL="${panels[$((i*2))]}"
    BOTTOM_PANEL="${panels[$((i*2+1))]}"

    gsettings set org.mate.panel.toplevel:/org/mate/panel/toplevels/$TOP_PANEL/ monitor "$i"
    gsettings set org.mate.panel.toplevel:/org/mate/panel/toplevels/$BOTTOM_PANEL/ monitor "$i"
done

# Restart panel
mate-panel --replace &

echo "mpanup complete"
