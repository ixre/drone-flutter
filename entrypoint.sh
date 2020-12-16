#!/usr/bin/env sh

set -e
cd "${PLUGIN_SOURCE}"
echo "---- list source folder ----"
ls -al .
sh -c "flutter build apk ${PLUGIN_ARGS}"
echo "build success."

echo "---- list output folder ----"
ls -al "${PLUGIN_SOURCE}"/build/app/outputs/apk
