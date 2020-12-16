#!/usr/bin/env sh

echo "${PLUGIN_SOURCE}"
echo "${PLUGIN_ARGS}"
cd "${PLUGIN_SOURCE}"
sh -c "flutter build apk ${PLUGIN_ARGS}"
echo "build success."
ls -al .
ls -al "${PLUGIN_SOURCE}"/build/app/outputs/apk
