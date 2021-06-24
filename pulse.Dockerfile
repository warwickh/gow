FROM ubuntu:20.04 AS base

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ="Europe/London"

ENV UNAME retro

# Taken from https://github.com/jessfraz/dockerfiles/blob/master/pulseaudio/
RUN apt-get update && apt-get install -y --no-install-recommends \
    alsa-utils \
    libasound2 \
    libasound2-plugins \
    pulseaudio \
    pulseaudio-utils \
    # x11 utils needed for xdpyinfo
    x11-utils \
    && rm -rf /var/lib/apt/lists/*

ENV HOME /home/$UNAME
# Set up the user
# Taken from https://github.com/TheBiggerGuy/docker-pulseaudio-example
RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} audio

WORKDIR $HOME
USER $UNAME

COPY configs/pulseaudio/default.pa /etc/pulse/default.pa
COPY configs/pulseaudio/client.conf /etc/pulse/client.conf
COPY configs/pulseaudio/daemon.conf /etc/pulse/daemon.conf
COPY scripts/pulse_startup.sh /startup.sh

EXPOSE 4713

CMD /bin/bash /startup.sh