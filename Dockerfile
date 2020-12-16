FROM mobiledevops/flutter-sdk-image:v1.12.13-hotfix.8

RUN flutter -v

CMD ["flutter","doctor"]

