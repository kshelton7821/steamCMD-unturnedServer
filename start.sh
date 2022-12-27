#!bin/bash
# Written by: Keaton Shelton
# Date: 10/10/2022
# Purpose: Primary Launch Script for Unturned Dedicated Server
# Version: 1.0.0
mkdir /serverFiles/backups
mkdir /serverFiles/logs
echo "Load and Update Unturned"
steamcmd +force_install_dir /serverFiles/ +login anonymous +app_update 1110390 validate +quit
echo "Update Complete"
echo "Copy SteamClient.so to Steam SDK"
cp /serverFiles/linux64/steamclient.so /root/.steam/sdk64/steamclient.so
echo "Begin Backup"
cd /serverFiles
if [ -d "Servers" ]; then
    tar -I pigz --exclude='./backups' -cvpf backups/$(date +%Y.%m.%d.%H.%M.%S).tar.gz ./*
fi
echo "Launching Server"
/scripts/unturnedStart.sh
