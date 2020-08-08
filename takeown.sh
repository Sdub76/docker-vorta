#!/usr/bin/with-contenv sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

log() {
    echo "[cont-init.d] $(basename $0): $*"
}

if [ "${TAKE_CONFIG_OWNERSHIP:-1}" -eq 1 ]; then
    if ! chown $USER_ID:$GROUP_ID /locations; then
        # Failed to take ownership of /locations.  This could happen when,
        # for example, the folder is mapped to a network share.
        # Continue if we have write permission, else fail.
        if s6-setuidgid $USER_ID:$GROUP_ID [ ! -w /locations ]; then
            log "ERROR: Failed to take ownership and no write permission on /locations."
            exit 1
        fi
    fi
fi