#!/bin/bash

sketchybar --add item datetime right \
    --set datetime update_freq=30 \
    background.drawing=off \
    script="$PLUGIN_DIR/datetime.sh"
