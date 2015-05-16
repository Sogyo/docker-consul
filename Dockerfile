FROM gliderlabs/alpine:3.1

MAINTAINER Kevin van der Vlist <kvdvlist@sogyo.nl>

RUN apk update \
  && apk add wget \
  && cd /tmp \
  && wget --no-check-certificate -O consul.zip https://dl.bintray.com/mitchellh/consul/0.5.1_linux_amd64.zip \
  && wget --no-check-certificate -O ui.zip https://dl.bintray.com/mitchellh/consul/0.5.1_web_ui.zip \
  && unzip consul.zip \
  && unzip ui.zip \
  && mv consul /bin/consul \
  && mv dist /ui \
  && rm ui.zip \
  && apk del wget \
  && rm -rf /var/cache/apk/*

ENV GOMAXPROCS 2

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

VOLUME [ "/data", "/config" ]

ENTRYPOINT [ "/bin/consul" ]

CMD []