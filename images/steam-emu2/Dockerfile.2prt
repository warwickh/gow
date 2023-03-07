FROM gow-steam-emu

RUN apt-get update -qq \
&&  apt-get install -y --no-install-recommends software-properties-common \
&&  apt-get install gpg gpg-agent -y \ 
&&  add-apt-repository ppa:pcsx2-team/pcsx2-daily -y \
&&  add-apt-repository -y ppa:drewwalton19216801/dolphin-master-cosmic -y \
&& apt-get install -qqy --no-install-recommends \
      $( \
          apt-cache show dolphin-emu-master \
            | sed -nE 's/Depends: //p' \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
        ) \
      libvulkan1 \
&& apt-get install -qqy --no-install-recommends dolphin-emu-master \
&& apt-get remove -y software-properties-common \
&& apt-get autoremove -y  \
&& rm -rf /var/lib/apt/lists/*

COPY --chmod=777 scripts/startup.sh /opt/gow/startup-app.sh
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#USER ${UNAME}

ENV XDG_RUNTIME_DIR=/tmp/.X11-unix

ARG IMAGE_SOURCE
LABEL org.opencontainers.image.source $IMAGE_SOURCE
#ENTRYPOINT []
#CMD /opt/gow/startup-app.sh
