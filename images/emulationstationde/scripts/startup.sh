#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh

gow_log "Starting Application"

CFG_DIR=$HOME/.config/retroarch

# Copying config in case it's the first time we mount from the host
mkdir -p "$CFG_DIR/cores/"

cp -u /cfg/retroarch.cfg "$CFG_DIR/retroarch.cfg"

gow_log "Copying custom config - es_systems.xml"
mkdir -p /home/retro/.emulationstation/custom_systems
cp -u /cfg/es_systems.xml /home/retro/.emulationstation/custom_systems

gow_log "Copying custom laucnh scripts for emulators"
mkdir -p /home/retro/.emulationstation/custom_scripts
cp -u /cfg/retroarch.sh /home/retro/.emulationstation/custom_scripts/Launch_Retroarch.sh
cp -u /cfg/rpcs3.sh /home/retro/.emulationstation/custom_scripts/Launch_rpcs3.sh
cp -u /cfg/yuzu.sh /home/retro/.emulationstation/custom_scripts/Launch_yuzu.sh
cp -u /cfg/pcsx2.sh /home/retro/.emulationstation/custom_scripts/Launch_pcsx2.sh
cp -u /cfg/dolphin.sh /home/retro/.emulationstation/custom_scripts/Launch_dolphin.sh
cp -u /cfg/xemu.sh /home/retro/.emulationstation/custom_scripts/Launch_xemu.sh



# if there are no cores, copy from the retroarch ppa
# shellcheck disable=SC2046
cp -u /usr/lib/$(uname -m)-linux-gnu/libretro/* "$CFG_DIR/cores/"

# if there are no assets, manually download them
if [ ! -d "$CFG_DIR/assets" ]; then
    wget -q --show-progress -P /tmp https://buildbot.libretro.com/assets/frontend/assets.zip
    7z x /tmp/assets.zip -bso0 -bse0 -bsp1 -o"$CFG_DIR/assets"
    rm /tmp/assets.zip
fi

gow_log "Installing AppImage Emulators"
mkdir -p /home/retro/Applications
chown ${UNAME}:${UNAME} /home/retro/Applications
cp -u /tmp/yuzu-emu.AppImage /home/retro/Applications/yuzu-emu.AppImage
chmod a+x /home/retro/Applications/yuzu-emu.AppImage	
cp -u /tmp/rpcs3-emu.AppImage /home/retro/Applications/rpcs3-emu.AppImage
chmod a+x /home/retro/Applications/rpcs3-emu.AppImage

gow_log "777 permissions on necessary folder"
mkdir -p /home/retro/.local/share/yuzu/keys/
chmod 777 /home/retro/.local/share/yuzu/keys/

sudo ln -s /usr/games/dolphin-emu /usr/bin/dolphin-emu
sudo ln -s /usr/games/dolphin-emu-nogui /usr/bin/dolphin-emu-nogui

gow_log "Installing Winetricks"
winetricks d3dx9

gow_log "Launching with Gamescope"
chown ${UNAME}:${UNAME} /usr/games/gamescope

if [ -n "$RUN_GAMESCOPE" ]; then
  GAMESCOPE_WIDTH=${GAMESCOPE_WIDTH:-1920}
  GAMESCOPE_HEIGHT=${GAMESCOPE_HEIGHT:-1080}
  GAMESCOPE_REFRESH=${GAMESCOPE_REFRESH:-60}
  GAMESCOPE_MODE=${GAMESCOPE_MODE:-"-b"}
  /usr/games/gamescope ${GAMESCOPE_MODE} -W ${GAMESCOPE_WIDTH} -H ${GAMESCOPE_HEIGHT} -r ${GAMESCOPE_REFRESH} -- /opt/gow/startup-es.sh
else
 exec /usr/bin/emulationstation
fi