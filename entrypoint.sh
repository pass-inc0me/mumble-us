#!/bin/bash
sudo apt-get update && sudo apt-get install -y mumble-server

chmod 777 .

echo "Starting Mumble Billboard..."

mumble-server -fg -ini murmur.ini
