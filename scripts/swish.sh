#!/usr/bin/env bash

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_sessions() {
    current_session=$(tmux display-message -p "#S")
    last_session=$(tmux display-message -p '#{client_last_session}')
    sessions=$(tmux list-sessions | sed -E 's/:.*$//' | grep -Fxv "$last_session" | grep -Fxv "$current_session")
    echo -e "$last_session\n$sessions" | awk '!seen[$0]++'
}

user_kill_session="$(tmux show-option -gqv @swish-kill)"
kill_key="${user_kill_session:-alt-bspace}"
kill_session_bind="$kill_key:execute-silent(tmux kill-session -t {})+reload(${current_dir%/}/reload_sessions.sh)"

selection=$(get_sessions | fzf --tmux --bind "$kill_session_bind")

if [ -n "$selection" ]; then
    tmux switch-client -t "$selection"
fi

