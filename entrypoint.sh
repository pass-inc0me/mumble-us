#!/bin/bash

# Install OpenSSL
sudo apt-get update && sudo apt-get install -y openssl

# Generate a 10-year permanent identity for your server
openssl req -x509 -newkey rsa:2048 -nodes -keyout server.key -out server.crt -subj "/CN=MumbleBillboard" -days 3650

echo "--------------------------------------------------"
echo "!!! COPY THE TEXT BELOW INTO GITHUB SECRETS !!!"
echo "--------------------------------------------------"
echo ""
echo "--- YOUR MUMBLE_KEY (Copy everything between lines) ---"
cat server.key
echo "--- END OF MUMBLE_KEY ---"
echo ""
echo "--- YOUR MUMBLE_CERT (Copy everything between lines) ---"
cat server.crt
echo "--- END OF MUMBLE_CERT ---"
echo ""
echo "--------------------------------------------------"
echo "After copying, delete this script and use the Final one."
