FROM alpine:edge

ENV PORT        3000
ENV PASSWORD    ChangeThis
ENV METHOD      aes-256-gcm
ENV PV          4.38.3
ENV WSPATH="/ChangeThis"


RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add --no-cache shadowsocks-libev curl && \
    curl -sL https://github.com/teddysun/v2ray-plugin/releases/download/v${PV}/v2ray-plugin-linux-amd64-v${PV}.tar.gz | tar zxC /usr/bin/ && \
    chmod a+x /usr/bin/v2ray-plugin_linux_amd64

CMD ss-server -s 0.0.0.0 -p ${PORT} -k ${PASSWORD} -m $METHOD --plugin /usr/bin/v2ray-plugin_linux_amd64 --plugin-opts "server;path=${WSPATH}"
