#!/bin/bash
sudo apt-get update && sudo apt-get install -y mumble-server
murmurd -fg -ini murmur.ini
