######## BUILDER ########

# Set the base image
FROM steamcmd/steamcmd:ubuntu-22 as builder

# Set environment variables
ENV USER root
ENV HOME /root/installer

# Set working directory
WORKDIR $HOME

# Install prerequisites
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl tar

# Donload and unpack installer
RUN curl http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
    --output steamcmd.tar.gz --silent
RUN tar -xvzf steamcmd.tar.gz && rm steamcmd.tar.gz

######## INSTALL ########

# Set the base image
#FROM alpine:3
FROM steamcmd/steamcmd:ubuntu-22

# Set environment variables
ENV USER root
ENV HOME /root

# Set working directory
WORKDIR $HOME

#Create Scripts and Backup Folder
RUN mkdir /scripts && mkdir /root/.steam/sdk64
COPY start.sh /scripts/start.sh
COPY unturnedStart.sh /scripts/unturnedStart.sh
RUN chmod +x /scripts/*.sh

# Expose Ports
EXPOSE 27015 27015/udp
EXPOSE 27016 27016/udp

# Install prerequisites
####&& rm -rf /var/cache/apk/*

RUN apt-get update && \
    apt-get install -y pigz unzip tar curl coreutils lib32gcc-s1 libgdiplus && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy steamcmd files from builder
COPY --from=builder /root/installer/steamcmd.sh /usr/lib/games/steam/
COPY --from=builder /root/installer/linux32/steamcmd /usr/lib/games/steam/
COPY --from=builder /usr/games/steamcmd /usr/bin/steamcmd

# Copy required files from builder
COPY --from=builder /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /lib/i386-linux-gnu /lib/
COPY --from=builder /root/installer/linux32/libstdc++.so.6 /lib/

# Update SteamCMD and verify latest version
RUN steamcmd +quit

# Set default command
ENTRYPOINT ["/bin/bash", "/scripts/start.sh"]