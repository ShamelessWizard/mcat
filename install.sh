#!/bin/sh
# install.sh - Install mcat from bin/mcat to /usr/local/bin/mcat
# Run with: sudo ./install.sh

set -e

DEST=/usr/local/bin/mcat
SRC=bin/mcat

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root (use sudo)."
    exit 1
fi

if [ ! -f "$SRC" ]; then
    echo "Error: $SRC not found."
    echo "Run this script from the repository root directory."
    exit 1
fi

echo "Installing mcat from $SRC to $DEST ..."

install -v -m 0755 -o root -g root "$SRC" "$DEST"

if [ $? -eq 0 ]; then
    echo ""
    echo "Installed successfully to $DEST"
    echo "You can now run: mcat -h"
    echo ""
    echo "To uninstall later:"
    echo "    sudo rm $DEST"
else
    echo "Installation failed."
    exit 1
fi
