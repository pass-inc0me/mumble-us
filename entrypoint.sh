#!/bin/bash
sudo apt-get update && sudo apt-get install -y mumble-server
murmurd -fg -ini murmur.ini &
MURMUR_PID=$!

wait $MURMUR_PID
