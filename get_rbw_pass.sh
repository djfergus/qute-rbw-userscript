#!/bin/sh

[[ "$QUTE_URL" =~ https?:\/\/(.*\.)?([^/.]+)\.[^/.]+ ]] 
BASE_URL="${BASH_REMATCH[2]}" # "google" from "https://accounts.google.com/help"

if PASS=$(rbw get "$BASE_URL" 2>&1 );
then
    # No error getting password: copy password to clipboard and then get TOTP (or clear)
    echo "$PASS" | xclip -selection clipboard 
    ((sleep 4; rbw code `$BASE_URL` |  xclip -selection clipboard) &) 2>/dev/null
else
    # Error getting password (multiple choices): parse error and select entry with dmenu
    re='multiple entries found: (.*)' 
    [[ "$PASS" =~ multiple\ entries\ found:\ (.*) ]] 
    ENTRIES="${BASH_REMATCH[1]}" # "name1@google.com, name2@google.com, name3@google.com"
    SELECTED_ENTRY=$(echo "$ENTRIES" | tr ',' '\n' | dmenu -i)
    [[ "$SELECTED_ENTRY" =~ (.*)@[^@]* ]]  
    SELECTED_ENTRY=$(echo "${BASH_REMATCH[1]}" | xargs) # "name1" in " name1@google.com

    rbw get "$BASE_URL" "$SELECTED_ENTRY" | xclip -selection clipboard 
    ((sleep 4; rbw code `$BASE_URL` `$SELECTED_ENTRY` |  xclip -selection clipboard) &) 2>/dev/null
fi

