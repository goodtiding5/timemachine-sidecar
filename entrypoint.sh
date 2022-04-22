#!/bin/bash

set -euo pipefail

TM_LICHOST=${TM_LICHOST:-127.0.0.1}
TM_LICPORT=${TM_LICPORT:-57777}
TM_LICPASS=${TM_LICPASS:-docker}

FROM_DIR=${FROM_DIR:-/dist}
INTO_DIR=${INTO_DIR:-/opt/ssstm}

[ -f /dist/bin/tmdeploy ] && /dist/bin/tmdeploy
[ -d /opt/ssstm/data ] || mkdir -p /opt/ssstm/data
[ -d /opt/ssstm/log  ] || mkdir -p /opt/ssstm/log

echo "Sidecar for kubernetes is ready!"

# If we have an interactive container
if [ "$#" -gt 0 ]; then
    eval "exec $@"
else 
    exec /usr/sbin/tmagent
fi

# Will not reach here 
exit 0
