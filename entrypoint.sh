#!/usr/bin/env sh

set -e
SDK_ROOT="/home/mobiledevops/.flutter-sdk"
if [ "${PLUGIN_CN_NET}" = "true" ];then
  echo "[ drone-flutter][ info]: use flutter chinese mirror"
  export PUB_HOSTED_URL=https://pub.flutter-io.cn
  export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
fi
if [ "${PLUGIN_PUB_CACHE}" != "" ];then
  if [[ "${PLUGIN_PUB_CACHE}" = ~^/.* ]];then
    echo "[ drone-flutter][ warning]: PUB_CACHE must starts with \'/\', otherwise can not be cached."
  fi
  echo "[ drone-flutter][ info]: use ${PLUGIN_PUB_CACHE} as flutter pub cache folder..."
  export PUB_CACHE="${PLUGIN_PUB_CACHE}"

  #if [[ "${PLUGIN_PUB_CACHE}" = ~^/.* ]];then
  #  ln -s "${PLUGIN_PUB_CACHE}" "${SDK_ROOT}/.pub-cache"
  #else
  #  mkdir -p "${PLUGIN_PUB_CACHE}"
  #  ln -s "$(pwd)/${PLUGIN_PUB_CACHE}" "${SDK_ROOT}/.pub-cache"
  #fi
fi

cd "${PLUGIN_SOURCE}"

sh -c "${PLUGIN_COMMAND} ${PLUGIN_ARGS}"
cd - && echo "[ drone-flutter][ info]: build success."

echo "---- list output folder ----"
ls -al "${PLUGIN_SOURCE}"/build/app/outputs/apk/release
