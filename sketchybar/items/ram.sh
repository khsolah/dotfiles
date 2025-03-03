#!/bin/bash

sketchybar --add item ram right \
    --set ram icon=􀫦 \
    icon.color=$SKY \
    update_freq=5 \
    script="$PLUGIN_DIR/ram.sh"
