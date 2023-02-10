ARG BASE_APP_IMAGE

# hadolint ignore=DL3006
FROM ${BASE_APP_IMAGE}

ARG DEBIAN_FRONTEND=noninteractive
ARG REQUIRED_PACKAGES=" \
    libdbus-1-3 libgtk-3-0 libegl1 libsdl2-2.0-0 \
    nano \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libnotify-bin \
    sudo \
    fuse \
    libfuse2 \
    libnss3 \
    rtkit \
    pulseaudio \
	wget \
	imagemagick \
	qtbase5-dev \
	qtchooser \
	qt5-qmake \
#    libboost-filesystem=1.71.0 \
	qtbase5-dev-tools \
	mupen64plus-qt \
	apt-utils \
	libopengl0 \
	locales \
	unzip \
    curl \
	libnvidia-gl-525 \
"

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends software-properties-common && \
    apt-get install -y --no-install-recommends $REQUIRED_PACKAGES && \
    # Cleanup \
    apt-get remove -y software-properties-common && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

#RUN curl -SL https://github.com/dh4/mupen64plus-qt/releases/download/1.15/mupen64plus-qt_linux_1.15.tar.gz | tar -xJC /usr/games

ADD https://github.com/dh4/mupen64plus-qt/releases/download/1.15/mupen64plus-qt_linux_1.15.tar.gz /tmp
#RUN ls /tmp

RUN tar -xpf /tmp/mupen64plus-qt_linux_1.15.tar.gz -C /usr/games --overwrite

#RUN ln -s /usr/share/games/mupen64plus /data 
#RUN ln -s /usr/lib/x86_64-linux-gnu/mupen64plus /plugins 
#RUN ln -s /home/${UNAME}/.config/mupen64plus /config 

WORKDIR $HOME
USER ${UNAME}

#COPY configs/retroarch.cfg /cfg/retroarch.cfg
COPY --chmod=777 scripts/startup.sh /opt/gow/startup-app.sh

ENV XDG_RUNTIME_DIR=/tmp/.X11-unix

ARG IMAGE_SOURCE
LABEL org.opencontainers.image.source $IMAGE_SOURCE

ENTRYPOINT []
CMD /opt/gow/startup-app.sh