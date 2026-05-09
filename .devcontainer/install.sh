#!/bin/bash

echo "downloading latest xray..."
# Fetch latest release download URL for linux-64
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep "browser_download_url.*Xray-linux-64.zip" | cut -d : -f 2,3 | tr -d \")

wget -O /tmp/xray.zip $DOWNLOAD_URL

echo "installing..."
unzip /tmp/xray.zip -d /tmp/xray_temp
chmod +x /tmp/xray_temp/xray
mv /tmp/xray_temp/xray /usr/local/bin/xray

# Clean up temporary files instead of destructive rm -rf
rm -rf /tmp/xray.zip /tmp/xray_temp
echo "installed!"
