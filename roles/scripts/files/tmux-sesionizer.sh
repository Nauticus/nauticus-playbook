#!/usr/bin/env bash

# expect a flag to be passed named git
# define a variable to hold git boolean
git=false

while getopts ":g" opt; do
  case $opt in
    g)
        git=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
  shift
done

if [[ $# -eq 1 ]]; then
    if [[ $git == true ]]; then
        selected=$(find $1 -name ".git" -maxdepth 4 -exec dirname {} + -prune | fzf)
    else
        selected=$(find $1 -mindepth 1 -maxdepth 2 -type d | fzf)
    fi
else
    if [[ $git == true ]]; then
        selected=$(find . -name ".git" -maxdepth 4 -exec dirname {} + -prune | fzf)
    else
        selected=$(find . -mindepth 1 -maxdepth 2 -type d | fzf)
    fi
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
