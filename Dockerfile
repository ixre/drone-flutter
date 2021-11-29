#flutter version: v2.5.3

FROM mobiledevops/android-sdk-image:30.0.3

ENV FLUTTER_VERSION="2.5.3"
ENV FLUTTER_HOME "/home/mobiledevops/.flutter-sdk"
ENV PATH $PATH:$FLUTTER_HOME/bin

ENV PLUGIN_SOURCE="."
ENV PLUGIN_CN_NET=false
ENV PLUGIN_GRADLE_USER_HOME=".gradle"
ENV PLUGIN_PUB_CACHE=".pub_cache"
ENV PLUGIN_DIST_FOLDER="./dist"
ENV PLUGIN_COMMAND="flutter build apk"
ENV PLUGIN_ARGS=""
USER root

COPY entrypoint.sh /

# Download and extract Flutter SDK
RUN mkdir $FLUTTER_HOME \
    && cd $FLUTTER_HOME \
    && curl --fail --remote-time --silent --location -O https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz --strip-components=1 \
    && rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && flutter upgrade && rm -rf .git \
    && flutter precache

CMD ["bash","/entrypoint.sh"]

