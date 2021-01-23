# drone-flutter
Flutter CI/DI tools for drone

# Usage

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
      mount: ["/.pub_cache"]
  - name: flutter
    image: jarry6/drone-flutter
    settings:
      cn_net: true
      pub_cache: "/.pub_cache"
      source: "."
      args: "--verbose --split-per-abi --no-tree-shake-icons"
  - name: rebuild-cache
    image: drillster/drone-volume-cache
    volumes:
      - name: cache
        path: /cache
    settings:
      rebuild: true
      mount: ["/.pub_cache"]
  - name: publish
    image: appleboy/drone-scp
    settings:
      host: 127.0.0.1
      username: root
      password:
        from_secret: server_password
      port: 22000
      source: build/app/outputs/apk/release/app-universal-release.apk
      target: /data/files/app-nightly.apk
      when:
        status: [ success ]
      command:
        - echo "upload success!"
  - name: dingding
    image: lddsb/drone-dingtalk-message
    settings:
      token: eb1aed6eb4676bff328d8da36a7ecbf1a8941c3820aaa4f4c38d36a5e90c3fb7
      type: markdown
trigger:
  branch:
    - master
volumes:
  - name: cache
    host:
      path: /tmp/cache
```
