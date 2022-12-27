# steamCMD-Unturned
## Dockerfile
The dockerfile that builds an ubuntu based docker image that contains an install of steamCMD with an Unturned Server.
## docker-compose.yml
The docker compose file that builds a container based of the image produced by the Dockerfile.
## Docs.txt
Contains useful links to Unturned related mods / files
## start.sh
Main entry point for docker container. Starts steamCMD and downloads / validates Unturned Server, fixes steamclient.so bug, starts unturnedStart.sh
## unturnedStart.sh
Bash script that gets launched from start.sh, proceeds to launch Unturned server executable
## Commands.dat
File that contains useful launch commands for your Unturned Server
