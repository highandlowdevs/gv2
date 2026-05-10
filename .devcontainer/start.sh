#!/bin/bash

echo "[g2ray] Starting Xray in background..."
sudo pkill -f xray || true
sudo nohup /usr/local/bin/xray -c /etc/config.json > /tmp/xray.log 2>&1 &

echo "[g2ray] Starting internal Keepalive loop (pinging GitHub every 3 minutes)..."
while true; do
    curl -s --max-time 5 https://github.com/ -o /dev/null
    sleep 180
done
