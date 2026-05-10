#!/bin/bash

# Start Xray in background
echo "[g2ray] Starting Xray..."
sudo pkill -f xray 2>/dev/null || true
sudo nohup /usr/local/bin/xray -c /etc/config.json > /tmp/xray.log 2>&1 &

echo "[g2ray] Xray started. Keepalive loop running every 15 minutes..."

# Keepalive loop using built-in GITHUB_TOKEN
# GitHub registers authenticated API calls as user activity -> resets idle timer
while true; do
    sleep 900  # 15 minutes
    gh api /user --silent 2>/dev/null && echo "[keepalive] ping ok at $(date)" >> /tmp/keepalive.log || true
done
