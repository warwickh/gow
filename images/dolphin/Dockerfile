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
    libnvidia-gl-525 \
"

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends software-properties-common && \
    apt-get install -y --no-install-recommends $REQUIRED_PACKAGES && \
    # Cleanup \
    apt-get remove -y software-properties-common && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
	cmake \
	pkg-config \
	git \
	libao-dev \
	libasound2-dev \
	libavcodec-dev \
	libavformat-dev \
	libbluetooth-dev \
	libenet-dev \
	libgtk2.0-dev \
	liblzo2-dev \
	libminiupnpc-dev \
	libopenal-dev \
	libpulse-dev \
	libreadline-dev \
	libsfml-dev \
	libsoil-dev \
	libsoundtouch-dev \
	libswscale-dev \
	libusb-1.0-0-dev \
	libwxbase3.0-dev \
#	libwxgtk3.0-dev \
	libxext-dev \
	libxrandr-dev \
	portaudio19-dev \
	zlib1g-dev \
	libudev-dev \
	libevdev-dev \
	"libpolarssl-dev|libmbedtls-dev" \
	libcurl4-openssl-dev \
	libegl1-mesa-dev \
	libpng-dev \
	qtbase5-private-dev \
	build-essential \
	ca-certificates \
	qtbase5-dev \ 
	make \
	gcc \
    minizip \
	libavutil-dev \
	libxi-dev \
	libmbedtls-dev \
	libhidapi-dev \
	libsystemd-dev \
	libpugixml-dev \
	libbz2-dev \
	libzstd-dev \
	gettext \
	&& cd /usr/src/ \
	&& git clone https://github.com/dolphin-emu/dolphin.git \
	&& cd dolphin \
    && git submodule update --init Externals/mGBA \
    && git submodule update --init Externals/spirv_cross \
    && git submodule update --init Externals/zlib-ng \
    && git submodule update --init Externals/libspng \
    && git submodule update --init Externals/VulkanMemoryAllocator \
    && git submodule update --init --recursive Externals/cubeb \
    && git submodule update --init Externals/implot \
    && git submodule update --init Externals/gtest \
    && git pull --recurse-submodules \
	&& mkdir build && cd build \
	&& cmake .. \
	&& make -j ${THREADS:-`cat /proc/cpuinfo | grep processor | wc -l`} \
	&& make install \
    && apt-get autoremove -y \
	&& cd / \
	&& rm -rf /usr/src/dolphin/ /var/lib/apt/lists/*

WORKDIR $HOME
USER ${UNAME}

#COPY configs/retroarch.cfg /cfg/retroarch.cfg
COPY --chmod=777 scripts/startup.sh /opt/gow/startup-app.sh

ENV XDG_RUNTIME_DIR=/tmp/.X11-unix

ARG IMAGE_SOURCE
LABEL org.opencontainers.image.source $IMAGE_SOURCE

ENTRYPOINT []
CMD /opt/gow/startup-app.sh