#!/bin/bash
##
## Be sure to read the license file
##
## This is a simple launch script to run the LibreWolf AppImage in a portable manner

SWD=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

FILENAME=$(ls $SWD/LibreWolf*.AppImage)

"$FILENAME" --no-remote $@
