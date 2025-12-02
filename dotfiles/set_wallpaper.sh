
#!/bin/bash

# Function to convert hex color to RGBA format
convert_hex_to_rgba() {
    local hex_color=$1
    echo "rgba(${hex_color:0:2}${hex_color:2:2}${hex_color:4:2}ee)"
}

# Check if a wallpaper path is provided
if [[ -n $1 ]]; then
    WALLPAPER=".config/backgrounds/$1"
    if [[ ! -f "$WALLPAPER" ]]; then
        echo "Error: Wallpaper '$WALLPAPER' not found."
        exit 1
    fi
else
    echo "Error: No wallpaper file provided. Please specify the wallpaper path."
    exit 1
fi
# Set the wallpaper with hyprpaper
echo -e "preload=$WALLPAPER" > ~/.config/hypr/hyprpaper.conf
echo -e "wallpaper= ,$WALLPAPER" >> ~/.config/hypr/hyprpaper.conf
hyprctl dispatch reload
pkill hyprpaper
hyprpaper &
# Generate pywal colors based on the selected wallpaper
wal -i "$WALLPAPER"

# Update Hyprland border colors with the pywal cache
PYWAL_COLORS="$HOME/.cache/wal/colors"
INACTIVE_BORDER_COLOR=$(convert_hex_to_rgba $(sed -n '1p' "$PYWAL_COLORS" | sed 's/#//'))
ACTIVE_BORDER_COLOR=$(convert_hex_to_rgba $(sed -n '6p' "$PYWAL_COLORS" | sed 's/#//'))

# Update Hyprland configuration
sed -i "/col.active_border/c\    col.active_border = $ACTIVE_BORDER_COLOR" ~/.config/hypr/hyprland.conf
sed -i "/col.inactive_border/c\    col.inactive_border = $INACTIVE_BORDER_COLOR" ~/.config/hypr/hyprland.conf

# Reload Hyprland config
hyprctl reload
echo "Wallpaper set to: $WALLPAPER"
echo "Hyprland border colors updated!"


