#!/bin/bash
sudo apt-get update && sudo apt-get install -y mumble-server
chmod 777 .
/usr/sbin/murmurd -fg -ini murmur.ini
