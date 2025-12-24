#!/bin/bash

# --- 1. INSTALLATION SECTION ---
echo "Installing Mumble and Playit.gg..."
sudo apt-get update
sudo apt-get install -y mumble-server wget openssl

# Download and install Playit.gg (the permanent tunnel tool)
curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null
echo "deb [arch=amd64] https://playit-cloud.github.io/ppa/data ./ " | sudo tee /etc/apt/sources.list.d/playit.list
sudo apt-get update
sudo apt-get install playit -y

# --- 2. IDENTITY SECTION ---
openssl req -x509 -newkey rsa:2048 -nodes -keyout server.key -out server.crt -subj "/CN=MumbleBillboard" -days 365

# --- 3. CONFIGURATION SECTION ---
cat <<EOF > mumble.ini
database=mumble.sqlite
icesecretwrite=
logfile=mumble.log
sslCert=server.crt
sslKey=server.key
welcometext="<br />Welcome to <b>Your Permanent Server</b>"
port=64738
users=100
EOF

# --- 4. EXECUTION SECTION ---
echo "Fixing port conflicts..."
sudo systemctl stop mumble-server || true
sudo pkill -9 mumble-server || true

echo "Starting Mumble Server..."
mumble-server -ini mumble.ini &

sleep 5

echo "--------------------------------------------------"
echo "SETTING UP PERMANENT ADDRESS"
echo "Look for a CLAIM LINK below. Click it to set up your static IP!"
echo "--------------------------------------------------"

# Start playit. 
# It will generate a claim link in the log the first time.
playit
