#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

HIGHLIGHT=off
if [ "$SELECTED" = "true" ]; then
    HIGHLIGHT=on
fi

sketchybar --set $NAME icon.highlight=$HIGHLIGHT \
    label.highlight=$HIGHLIGHT \
    background.drawing=$HIGHLIGHT
