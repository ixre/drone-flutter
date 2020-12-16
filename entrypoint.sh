#!/usr/bin/env sh

set -e

if [ "${PLUGIN_CN}" = "true" ];then
  echo "use flutter chinese mirror"
  export PUB_HOSTED_URL=https://pub.flutter-io.cn
  export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
fi
cd "${PLUGIN_SOURCE}"

sh -c "${PLUGIN_COMMAND} ${PLUGIN_ARGS}"
cd - && echo "build success."

echo "---- list output folder ----"
ls -al "${PLUGIN_SOURCE}"/build/app/outputs/apk
