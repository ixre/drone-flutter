#!/usr/bin/env sh

set -e

if [ ! $(PLUGIN_CN) = "true" ];then
  export PUB_HOSTED_URL=https://pub.flutter-io.cn
  export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
fi
cd "${PLUGIN_SOURCE}"
echo "---- list source folder ----"
ls -al .
sh -c "flutter build apk ${PLUGIN_ARGS}"
echo "build success."

echo "---- list output folder ----"
ls -al "${PLUGIN_SOURCE}"/build/app/outputs/apk
