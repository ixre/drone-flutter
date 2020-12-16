#!/usr/bin/env sh

cd "${PLUGIN_SOURCE}"
flutter build apk "${PLUGIN_ARGS}"
echo "build success."
ls -al "${PLUGIN_SOURCE}"/build/app/outputs/apk
