#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
    exit 0
fi

case ${PERCENTAGE} in
9[0-9] | 100)
    ICON="􀛨"
    ICON_COLOR=$GREEN
    ;;
[6-8][0-9])
    ICON="􀺸"
    ICON_COLOR=$TEAL
    ;;
[3-5][0-9])
    ICON="􀺶"
    ICON_COLOR=$PEACH
    ;;
[1-2][0-9])
    ICON="􀛩"
    ICON_COLOR=$RED
    ;;
*)
    ICON="􀛪"
    ICON_COLOR=$RED
    ;;
esac

if [[ $CHARGING != "" ]]; then
    ICON="􀢋"
    ICON_COLOR=$YELLOW
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME \
    icon="$ICON" \
    icon.color=$ICON_COLOR \
    label="${PERCENTAGE}%"
