#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

bind_keys() {
    user_swish_bind="$(tmux show-option -gqv @swish-bind)"
    swish_key="${user_swish_bind:-o}"
    tmux bind-key "$swish_key" run-shell "$CURRENT_DIR/scripts/swish.sh"
}

bind_keys
