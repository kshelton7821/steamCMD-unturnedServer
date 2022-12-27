#!/bin/bash
# Written by: Keaton Shelton
# Date: 10/10/2022
# Purpose: Server Launch Helper
# Version: 1.0.0

export TERM=xterm
echo "Launching Server"

#/serverFiles/Unturned_Headless.x86_64 -batchmode -nographics -logfile /serverFiles/logs/$(date +%F).log +SecureServer/Buggas -PvE -Cheats -Map Germany # -sv
/serverFiles/Unturned_Headless.x86_64 -logfile 2>&1 -batchmode -nographics +SecureServer/Buggas -PvE -Cheats -Map Germany # -sv

echo "Shutting Down Server"
