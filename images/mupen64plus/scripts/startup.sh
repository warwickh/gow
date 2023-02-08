#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh

gow_log "Starting Mupen64Plus"

exec /usr/games/mupen64plus-qt
sleep infinity
