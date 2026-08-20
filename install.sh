#!/usr/bin/env sh

set -e

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

echo "==> Deploying Kitty configuration..."
mkdir -p "$CONFIG_DIR/kitty"
cp -r kitty/* "$CONFIG_DIR/kitty/"

echo "==> Deploying Sway configuration..."
mkdir -p "$CONFIG_DIR/sway"
cp -r sway/* "$CONFIG_DIR/sway/"

echo "==> Applying Xfce panel layout..."
if command -v xfce4-panel-profiles >/dev/null 2>&1; then
    xfce4-panel-profiles load xfce_panel/xfce_panel_config.tar.bz2
else
    echo "Warning: 'xfce4-panel-profiles' is not installed. Skipping Xfce panel restore." >&2
fi

echo "==> Configurations applied successfully!"
