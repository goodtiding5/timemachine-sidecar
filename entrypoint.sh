#!/bin/bash

# set -euo pipefail
set -ex

export TM_LICHOST=${TM_LICHOST:-127.0.0.1}
export TM_LICPORT=${TM_LICPORT:-57777}
export TM_LICPASS=${TM_LICPASS:-docker}
export TM_DOMAIN=${TM_DOMAIN:-"$HOSTNAME"}
export TM_DBFILE=${TM_DBFILE:-""}
export TM_CONTAINER_EXT=${TM_CONTAINER_EXT:-"false"}

export FROM_DIR=${FROM_DIR:-/dist}
export INTO_DIR=${INTO_DIR:-/opt/ssstm}

[ -d /opt/ssstm/lib ] || mkdir -p /opt/ssstm/lib
[ -d /opt/ssstm/log  ] || mkdir -p /opt/ssstm/log
[ -f /dist/bin/tmdeploy ] && /dist/bin/tmdeploy -d

echo "Sidecar for kubernetes is ready!"

# If we have an interactive container
if [ "$#" -gt 0 ]; then
    eval "exec $@"
else 
    exec /usr/sbin/tmagent
fi

# Will not reach here 
exit 0
