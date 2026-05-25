#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Send Image to list-dev
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/clipssh.png
# @raycast.packageName clipssh

# Documentation:
# @raycast.description Send clipboard image to list-dev via clipssh
# @raycast.author aram_poghossian
# @raycast.authorURL https://raycast.com/aram_poghossian

export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

output=$(clipssh list-dev 2>&1)
exit_code=$?
clean=$(echo "$output" | perl -pe 's/\033\[[0-9;]*m//g')

if [ $exit_code -ne 0 ]; then
  case "$clean" in
    *"No image in clipboard"*)  echo "No image in clipboard" ;;
    *"Clipboard image is empty"*) echo "Clipboard is empty" ;;
    *"Failed to upload"*)         echo "Upload failed — check your SSH connection" ;;
    *"pngpaste not found"*)       echo "pngpaste not found — run: brew install pngpaste" ;;
    *)                            echo "$clean" ;;
  esac
  exit 1
fi

echo "✓ Path copied to clipboard"
