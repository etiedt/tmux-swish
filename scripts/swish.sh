#!/usr/bin/env bash

get_sessions() {
    last_session=$(tmux display-message -p '#{client_last_session}')
    sessions=$(tmux list-sessions | sed -E 's/:.*$//' | grep -Fxv "$last_session")
    echo -e "$sessions\n$last_session" | awk '!seen[$0]++'
}

selection=$(get_sessions | fzf --tmux)

tmux switch-client -t "$selection"

