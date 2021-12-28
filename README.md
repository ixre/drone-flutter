# drone-flutter
Flutter CI/DI tools for drone

# Usage
```
kind: pipeline
name: default

steps:
  - name: flutter
    image: jarry6/drone-flutter:2
    settings:
      cn_net: true
      source: "."
      commands: >
        flutter build apk
trigger:
  branch:
    - master
```

# Advance
```
kind: pipeline
name: default

steps:
  - name: restore-cache
    image: drillster/drone-volume-cache
    volumes:
      - name: cache
        path: /cache
    settings:
      restore: true
      mount: [".pub-cache",".gradle"]
  - name: flutter
    image: jarry6/drone-flutter:2
    settings:
      cn_net: true
      pub_cache: ".pub-cache"
      gradle_user_home: ".gradle"
      source: "."
      version: "2.2.3"
      commands: >
        flutter build apk --verbose --split-per-abi --no-tree-shake-icons"
  - name: rebuild-cache
    image: drillster/drone-volume-cache
    volumes:
      - name: cache
        path: /cache
    settings:
      rebuild: true
      mount: [".pub-cache",".gradle"]
  - name: publish
    image: appleboy/drone-scp
    settings:
      host: 127.0.0.1
      username: root
      password:
        from_secret: server_password
      port: 22000
      source: build/app/outputs/apk/release/app-armeabi-v7a-release.apk
      target: /data/files/app-nightly.apk
      when:
        status: [ success ]
      command:
        - echo "upload success!"
  - name: dingding
    image: lddsb/drone-dingtalk-message
    settings:
      token: eb1aed6eb4676bff328d8da36a7ecbf1a8941c3820aaa4f4c38d36a5e90c3fc7
      type: markdown
trigger:
  branch:
    - master
volumes:
  - name: cache
    host:
      path: /tmp/cache
```
If your flutter version is less than v2.0, please use `jarry6/drone-flutter:1`
