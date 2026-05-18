#!/bin/bash

echo "This script requires root. Press any key to continue or Ctrl+C to exit..."
read -n 1 -s
echo

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

# Get script directory (so it works no matter where you run it from)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create directory
mkdir -p /autoupd

# Copy files
cp "$SCRIPT_DIR/autoupd.sh" /autoupd/
cp "$SCRIPT_DIR/autoupd.service" /etc/systemd/system/

# Fix permissions
chmod +x /autoupd/autoupd.sh

# Reload and enable service
systemctl daemon-reload
systemctl enable autoupd.service
systemctl start autoupd.service

echo "Executed successfully. Exiting..."
