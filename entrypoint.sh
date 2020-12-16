#!/usr/bin/env sh

set -e
SDK_ROOT="/home/mobiledevops/.flutter-sdk"
if [ "${PLUGIN_CN_NET}" = "true" ];then
  echo "[ drone-flutter][ info]: use flutter chinese mirror"
  export PUB_HOSTED_URL=https://pub.flutter-io.cn
  export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
fi
if [ "${PLUGIN_PUB_CACHE}" != "" ];then
  echo "[ drone-flutter][ info]: use ${REAL_PUB} as flutter pub cache folder..."
  if [ "${PLUGIN_PUB_CACHE}" == "/*" ];then
    ln -s "${PLUGIN_PUB_CACHE}" "${SDK_ROOT}/.pub-cache"
  else
    ln -s "$(pwd)/${PLUGIN_PUB_CACHE}" "${SDK_ROOT}/.pub-cache"
  fi
fi

cd "${PLUGIN_SOURCE}"

sh -c "${PLUGIN_COMMAND} ${PLUGIN_ARGS}"
cd - && echo "[ drone-flutter][ info]: build success."

echo "---- list output folder ----"
ls -al "${PLUGIN_SOURCE}"/build/app/outputs/apk/release
