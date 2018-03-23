#!/bin/sh

set -e

if [ "$1" = 'ss-server' ]; then
    exec ss-server "$@"
fi

exec "$@"
