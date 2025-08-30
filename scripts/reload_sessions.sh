#!/usr/bin/env bash

current_session=$(tmux display-message -p "#S")
sessions=$(tmux list-sessions | sed -E "s/:.*$//")

if [[ $(echo "$sessions" | wc -l) -gt 1 ]]; then
    echo "$sessions" | grep -v "$current_session"
else
    echo "$sessions"
fi
