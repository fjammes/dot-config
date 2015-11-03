#!/bin/sh

set -e
set -x

OP="$1"

BRIGHTNESS=$(xrandr --verbose | grep -i brightness | cut -f2 -d ' ' | tail -n 1)
NEW_BRIGHTNESS=$(python -c "print min(abs(${BRIGHTNESS}${OP}), 1)")
xrandr --output LVDS --brightness $NEW_BRIGHTNESS
