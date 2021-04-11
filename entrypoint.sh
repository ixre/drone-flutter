#!/usr/bin/env bash

set -e
SDK_ROOT="/home/mobiledevops/.flutter-sdk"

flutter --version

if [ "${PLUGIN_CN_NET}" = "true" ];then
  echo "[ drone-flutter][ info]: used the flutter mirror optimize for china"
  export PUB_HOSTED_URL=https://pub.flutter-io.cn
  export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
  #export PUB_HOSTED_URL=https://mirrors.sjtug.sjtu.edu.cn/dart-pub
  #export FLUTTER_STORAGE_BASE_URL=https://mirrors.sjtug.sjtu.edu.cn
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

if [ "${PLUGIN_GRADLE_USER_HOME}" != "" ];then
  GRADLE_HOME="${PLUGIN_GRADLE_USER_HOME}"
  if [[ "${PLUGIN_GRADLE_USER_HOME}" != /* ]];then
    if [[ "${PLUGIN_GRADLE_USER_HOME}" == ./* ]];then
      GRADLE_HOME="$(pwd)${PLUGIN_GRADLE_USER_HOME:1}"
    else
      GRADLE_HOME="$(pwd)/${PLUGIN_GRADLE_USER_HOME}"
    fi
  fi
  echo "[ drone-flutter][ info]: use ${GRADLE_HOME} as gradle user home folder..."
  export GRADLE_USER_HOME="${GRADLE_HOME}"
fi

cd "${PLUGIN_SOURCE}" > /dev/null

echo 'cleaning last build cache!' && flutter clean

sh -c "${PLUGIN_COMMAND} ${PLUGIN_ARGS}" && cd - > /dev/null

echo "---- list output folder ----"
if [ "${PLUGIN_DIST_FOLDER}" != "" ];then
  mkdir -p "${PLUGIN_DIST_FOLDER}" \
  && mv "${PLUGIN_SOURCE}"/build/app/outputs/apk/release/* "${PLUGIN_DIST_FOLDER}/" \
  && ls -al "${PLUGIN_DIST_FOLDER}/" \
  && echo "[ drone-flutter][ info]: build success! files saved in ${PLUGIN_DIST_FOLDER}."
else
  ls -al "${PLUGIN_SOURCE}"/build/app/outputs/apk/release/* 
fi




