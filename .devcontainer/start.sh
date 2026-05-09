#!/bin/bash

# Generate UUID and update configs only once
if [ ! -f /etc/xray_uuid ]; then
    UUID=$(cat /proc/sys/kernel/random/uuid)
    echo $UUID > /etc/xray_uuid
    
    # Update Xray config with dynamic UUID
    sed -i "s/550e8400-e29b-41d4-a716-446655440000/$UUID/g" /etc/config.json
    
    # Add link to bashrc so it prints on every new terminal
    echo "echo -e \"\n✅ VLESS LINK:\nvless://${UUID}@94.130.50.12:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=\${CODESPACE_NAME}-443.app.github.dev&path=%2F#ghtun\"" >> /etc/bash.bashrc
    echo "echo -e \"\n🌐 KEEP-ALIVE LINK: https://\${CODESPACE_NAME}-8080.app.github.dev\n(Add this link to UptimeRobot!)\"" >> /etc/bash.bashrc
fi

# Kill previously running instances if reconnecting
pkill -f "python3 -m http.server 8080"
pkill -f "/usr/local/bin/xray"

# Start Keep-Alive Server in background
cd /tmp
nohup python3 -m http.server 8080 > /dev/null 2>&1 &

# Start Xray in background
nohup /usr/local/bin/xray -c /etc/config.json > /tmp/xray.log 2>&1 &

# Print links to the initial attach console
cat /etc/bash.bashrc | grep "echo -e" | bash
