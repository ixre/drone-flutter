FROM mobiledevops/flutter-sdk-image:v1.12.13-hotfix.8

ENV PLUGIN_SOURCE="."
ENV PLUGIN_CN_NET=false
ENV PLUGIN_PUB_CACHE=""
ENV PLUGIN_COMMAND="flutter build apk"
ENV PLUGIN_ARGS=""
USER root

COPY entrypoint.sh /
RUN flutter upgrade && flutter precache && flutter --version

CMD ["sh","/entrypoint.sh"]

