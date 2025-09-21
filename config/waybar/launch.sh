#!/usr/bin/env bash

CONFIG_FILES="$HOME/nixos-dotfiles/config/waybar/config $HOME/nixos-dotfiles/config/waybar/style.css"

trap "pkill waybar" EXIT

while true; do
  waybar &
  inotifywait -e create,modify $CONFIG_FILES
  pkill waybar
done
