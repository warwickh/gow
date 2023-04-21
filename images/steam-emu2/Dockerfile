ARG BASE_APP_IMAGE

# hadolint ignore=DL3006
FROM ${BASE_APP_IMAGE}

ARG DEBIAN_FRONTEND=noninteractive

ARG REQUIRED_PACKAGES=" \
    steam \
    libvulkan1 libvulkan1:i386 \
    mesa-vulkan-drivers mesa-vulkan-drivers:i386 \
    libdbus-1-3 libgtk-3-0 libegl1 libsdl2-2.0-0 \
    mupen64plus-qt \
    nano \
    sudo \
    lsof \
    lsb-release \
    xdg-user-dirs \
    xdg-utils \
    libxkbcommon-x11-dev \
#    libnvidia-gl-525 \
#    libnvidia-gl-525:i386 \
"

RUN apt-get update -qq \
&&  apt-get install -y --no-install-recommends software-properties-common \
&&  apt-get install gpg gpg-agent -y \ 
&&  add-apt-repository ppa:pcsx2-team/pcsx2-daily -y \
&&  add-apt-repository -y ppa:drewwalton19216801/dolphin-master-cosmic -y \
&&  add-apt-repository multiverse \    
&&  apt-get update -y \
&&  apt-get install -qqy --no-install-recommends \
      $( \
          apt-cache show pcsx2-unstable \
            | sed -nE 's/Depends: //p' \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
        ) \
      libcap2-bin \
      locales \
      unzip \
      $( \
          apt-cache show dolphin-emu-master \
            | sed -nE 's/Depends: //p' \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
        ) \
      libvulkan1 \
&& apt-get install -qqy --no-install-recommends pcsx2-unstable \
&& apt-get install -qqy --no-install-recommends dolphin-emu-master \
&& apt-get remove -y software-properties-common \
&& apt-get autoremove -y  \
&& rm -rf /var/lib/apt/lists/*

RUN apt-get update -y && \
    dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends $REQUIRED_PACKAGES 

ADD https://github.com/dh4/mupen64plus-qt/releases/download/1.15/mupen64plus-qt_linux_1.15.tar.gz /tmp
RUN tar -xpf /tmp/mupen64plus-qt_linux_1.15.tar.gz -C /usr/games --overwrite

COPY --chmod=777 scripts/startup.sh /opt/gow/startup-app.sh
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ENV XDG_RUNTIME_DIR=/tmp/.X11-unix
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

ARG IMAGE_SOURCE
LABEL org.opencontainers.image.source $IMAGE_SOURCE
