FROM mobiledevops/flutter-sdk-image:v1.12.13-hotfix.8

ENV PLUGIN_SOURCE="."
ENV PLUGIN_ARGS=""
ENV PLUGIN_CN=false

COPY entrypoint.sh /
RUN flutter --version

CMD ["sh","/entrypoint.sh"]

