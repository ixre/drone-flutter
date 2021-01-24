#!/usr/bin/env bash

set -e
SDK_ROOT="/home/mobiledevops/.flutter-sdk"

if [ "${PLUGIN_CN_NET}" = "true" ];then
  echo "[ drone-flutter][ info]: used the flutter mirror optimize for china"
  export PUB_HOSTED_URL=https://pub.flutter-io.cn
  export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
fi

if [ "${PLUGIN_PUB_CACHE}" != "" ];then
  CACHE_PATH="${PLUGIN_PUB_CACHE}"
  if [[ "${PLUGIN_PUB_CACHE}" != /* ]];then
    if [[ "${PLUGIN_PUB_CACHE}" == ./* ]];then
      CACHE_PATH="$(pwd)${PLUGIN_PUB_CACHE:1}"
    else
      CACHE_PATH="$(pwd)/${PLUGIN_PUB_CACHE}"
    fi
  fi
  echo "[ drone-flutter][ info]: use ${CACHE_PATH} as flutter pub cache folder..."
  export PUB_CACHE="${CACHE_PATH}"

  #if [[ "${PLUGIN_PUB_CACHE}" = ~^/.* ]];then
  #  ln -s "${PLUGIN_PUB_CACHE}" "${SDK_ROOT}/.pub-cache"
  #else
  #  mkdir -p "${PLUGIN_PUB_CACHE}"
  #  ln -s "$(pwd)/${PLUGIN_PUB_CACHE}" "${SDK_ROOT}/.pub-cache"
  #fi
fi

if [ "${PLUGIN_GRALE_USER_HOME}" != "" ];then
  GRADLE_HOME="${PLUGIN_GRALE_USER_HOME}"
  if [[ "${PLUGIN_GRALE_USER_HOME}" != /* ]];then
    if [[ "${PLUGIN_GRALE_USER_HOME}" == ./* ]];then
      GRADLE_HOME="$(pwd)${PLUGIN_GRALE_USER_HOME:1}"
    else
      GRADLE_HOME="$(pwd)/${PLUGIN_GRALE_USER_HOME}"
    fi
  fi
  echo "[ drone-flutter][ info]: use ${GRADLE_HOME} as gradle user home folder..."
  export GRALE_USER_HOME="${GRADLE_HOME}"
fi

cd "${PLUGIN_SOURCE}"

sh -c "${PLUGIN_COMMAND} ${PLUGIN_ARGS}"
cd - && echo "[ drone-flutter][ info]: build success."

echo "---- list output folder ----"
ls -al "${PLUGIN_SOURCE}"/build/app/outputs/apk/release
