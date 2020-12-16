FROM mobiledevops/flutter-sdk-image:v1.12.13-hotfix.8

ENV PLUGIN_SOURCE="."
ENV PLUGIN_ARGS=""

WORKDIR /src
COPY entrypoint.sh /
RUN flutter upgrade && flutter --version

CMD ["sh","/entrypoint.sh"]

