#!/bin/bash

set -e

source /opt/gow/bash-lib/utils.sh

gow_log "Waiting for X Server $DISPLAY to be available"
/opt/gow/wait-x11

# Launch the container's startup script
gow_log "At the end of the base-app script about to run /opt/gow/startup-app.sh"
exec /opt/gow/startup-app.sh
