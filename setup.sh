#!/bin/bash
echo "This script requires root. Press any key to continue or Ctrl+C to exit..."
read -n 1 -s
echo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/autoupd" /usr/bin/autoupd
cp "$SCRIPT_DIR/autoupd.service" /etc/systemd/system/
chmod +x /usr/bin/autoupd
systemctl daemon-reload
systemctl enable autoupd.service
systemctl start autoupd.service
echo "Executed successfully. Exiting..."
