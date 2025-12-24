#!/bin/bash

# 1. Install Mumble
sudo apt-get update && sudo apt-get install -y mumble-server wget jq openssl

# 2. Restore your Permanent Certificate from Secrets
echo "$MUMBLE_CERT" > server.crt
echo "$MUMBLE_KEY" > server.key
chmod 600 server.key

# 3. Get the Bore Tunnel Port
wget https://github.com/ekzhang/bore/releases/download/v0.5.0/bore-v0.5.0-x86_64-unknown-linux-musl.tar.gz
tar -xf bore-v0.5.0-x86_64-unknown-linux-musl.tar.gz
chmod +x bore

# Start bore to find a free port
./bore local 64738 --to bore.pub > bore.log 2>&1 &
sleep 8
BORE_PORT=$(grep -oP 'listening at bore.pub:\K\d+' bore.log)

# KILL the first bore and restart it so LOCAL matches REMOTE
pkill bore
sleep 2
./bore local $BORE_PORT --to bore.pub --port $BORE_PORT > bore.log 2>&1 &

echo "--------------------------------------------------"
echo "MATCHING PORT ACTIVE: bore.pub:$BORE_PORT"
echo "--------------------------------------------------"

# 4. Update murmur.ini to match the public port
sed -i "s/^port=.*/port=$BORE_PORT/" murmur.ini
echo "registerHostname=bore.pub" >> murmur.ini

# 5. Start Mumble
mumble-server -fg -ini murmur.ini
