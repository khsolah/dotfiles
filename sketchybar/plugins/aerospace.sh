#!/bin/bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on \
        label.highlight=on \
        icon.highlight=on
else
    sketchybar --set $NAME background.drawing=off \
        label.highlight=off \
        icon.highlight=off
fi
