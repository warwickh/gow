FROM andrewmackrodt/ubuntu-x11-i386

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      #python python-pip python-setuptools python-dev \
      wget \
      imagemagick \
      qtbase5-dev \
      qtchooser \
      qt5-qmake \
      qtbase5-dev-tools \
      mupen64plus-qt \
      nano \
      ffmpeg \
      apt-utils \
      #libcap2-bin \
      libopengl0 \
      locales \
      unzip \
      libnvidia-gl-525 \
 && rm -rf /var/lib/apt/lists/*

# add ubuntu user to rtkit to access input devices
RUN adduser ubuntu rtkit


# add PCSX2 bin to path
#RUN ln -s /usr/games/pcsx2 /usr/local/bin/pcsx2

# create directories
RUN for d in /games /data /plugins; do \
      mkdir "$d"; \
      chgrp adm "$d"; \
      chmod 2775 "$d"; \
    done

#RUN mkdir -p /usr/share/games
#RUN mkdir -p /usr/lib/x86_64-linux-gnu
RUN ln -s /usr/share/games/mupen64plus /data 
RUN ln -s /usr/lib/x86_64-linux-gnu/mupen64plus /plugins 

# copy files to container
COPY mupen64-bootstrap /usr/local/bin/mupen64-bootstrap

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# link /data to mupen config
RUN mkdir -p /home/ubuntu/.config \
 && ln -s /config /home/ubuntu/.config/mupen64plus

# create .local/share for recently-used.xbel
RUN mkdir -p /home/ubuntu/.local/share

# export volumes
VOLUME /data
VOLUME /plugins

# set directories to be chowned on container start
ENV USER_DIRS /data:/plugins${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/mupen64-bootstrap

################################################################################
# labels
################################################################################

ARG LABEL_NAME
ARG LABEL_VERSION
ARG LABEL_USAGE
ARG LABEL_VENDOR
ARG LABEL_VCS_URL
ARG LABEL_VCS_REF

LABEL org.label-schema.name="$LABEL_NAME" \
  org.label-schema.version="$LABEL_VERSION" \
  org.label-schema.usage="$LABEL_USAGE" \
  org.label-schema.vendor="$LABEL_VENDOR" \
  org.label-schema.vcs-url="$LABEL_VCS_URL" \
  org.label-schema.vcs-ref="$LABEL_VCS_REF" \
  org.label-schema.schema-version="1.0"
