#flutter version: v3.10.1

FROM mobiledevops/android-sdk-image:33.0.2

ENV FLUTTER_VERSION="3.10.1"
ENV FLUTTER_HOME "/home/mobiledevops/.flutter-sdk"
ENV PATH $PATH:$FLUTTER_HOME/bin

ENV PLUGIN_SOURCE="."
ENV PLUGIN_CN_NET=false
ENV PLUGIN_GRADLE_USER_HOME=".gradle"
ENV PLUGIN_PUB_CACHE=".pub-cache"
ENV PLUGIN_DIST_FOLDER="./dist"
ENV PLUGIN_COMMANDS="flutter build apk --split-per-abi --no-tree-shake-icons"
USER root

COPY entrypoint.sh /

# Download and extract Flutter SDK
RUN mkdir $FLUTTER_HOME \
    && cd $FLUTTER_HOME \
    && curl --fail --remote-time --silent --location -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz --strip-components=1 \
    && rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \ 
    && git config --global --add safe.directory /home/mobiledevops/.flutter-sdk \
    && flutter precache \
    && flutter doctor

CMD ["bash","/entrypoint.sh"]

