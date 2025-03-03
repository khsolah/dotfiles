#!/bin/bash

SPACE_SIDS=(1 2 3 4 5 6 7 8 9 10)

for sid in "${SPACE_SIDS[@]}"; do
    sketchybar --add space space.$sid left \
        --set space.$sid space=$sid \
        icon=$sid \
        icon.color=$SUBTEXT1 \
        icon.highlight_color=$CRUST \
        label.font="sketchybar-app-font:Regular:16.0" \
        label.padding_right=20 \
        label.y_offset=-1 \
        label.color=$SUBTEXT1 \
        label.highlight_color=$CRUST \
        background.color=$LAVENDER \
        background.corner_radius=10 \
        script="$PLUGIN_DIR/yabai.sh"
done

sketchybar --add item space_separator left \
    --set space_separator icon="" \
    icon.color=$SAPPHIRE \
    icon.padding_left=4 \
    label.drawing=off \
    background.drawing=off \
    script="$PLUGIN_DIR/yabai_windows.sh" \
    --subscribe space_separator space_windows_change
