#!/bin/bash
RELEASES="$(pwd)/../artifacts/all_releases"

RECIPES_PATH="$RELEASES/Tools/bin/recipes"
# Add recipes which contains things like mitigate all
if [[ "$PATH" != *"$RECIPES_PATH"* ]]; then
    PATH=$PATH:$RECIPES_PATH
fi

# Add shortcut script
SHORTCUT_PATH="$RELEASES/Tools/shortcut"
if [[ "$PATH" != *"$SHORTCUT_PATH"* ]]; then
    PATH=$PATH:$SHORTCUT_PATH
fi

# Add symlib LD_LIBRARY_PATH
SYM_LIB_PATH="$RELEASES/Symlib/"
if [[ "$LD_LIBRARY_PATH" != *"$SYM_LIB_PATH"* ]]; then
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SYM_LIB_PATH
fi

# Add interposing shortcut lib to LD_LIBRARY_PATH
#SHORTCUT_LIB_PATH="$RELEASES/Tools/shortcut"
#if [[ "$LD_LIBRARY_PATH" != *"$SHORTCUT_LIB_PATH"* ]]; then
#    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SHORTCUT_LIB_PATH
#fi

# Export path
export PATH
export LD_LIBRARY_PATH
