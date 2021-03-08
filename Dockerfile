#flutter version: v1.22.5

FROM mobiledevops/flutter-sdk-image:1.22.5

ENV PLUGIN_SOURCE="."
ENV PLUGIN_CN_NET=false
ENV PLUGIN_GRADLE_USER_HOME=".gradle"
ENV PLUGIN_PUB_CACHE=".pub_cache"
ENV PLUGIN_DIST_FOLDER="./dist"
ENV PLUGIN_COMMAND="flutter build apk"
ENV PLUGIN_ARGS=""
USER root

COPY entrypoint.sh /
RUN flutter --version

CMD ["bash","/entrypoint.sh"]

