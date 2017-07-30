FROM alpine:latest

MAINTAINER Yaming Huang <yumminhuang@gmail.com>

ENV SS_PORT=1984 \
    SS_ENCRYPT_METHOD="aes-256-cfb" \
    SS_PASSWORD="shadowsocks" \
    PROTOCOL="auth_aes128_md5" \
    PROTOCOLPARAM=32 \
    OBFS="tls1.2_ticket_auth_compatible" \
    OBFSPRARAM="cloudflare.com"

RUN set -ex && \
    apk add --no-cache git libsodium python && \
    git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git && \
    apk del git && \
    rm -rf /var/cache/apk/*

WORKDIR /shadowsocksr/shadowsocks

EXPOSE $SS_PORT/tcp $SS_PORT/udp

ENTRYPOINT python server.py -p $SS_PORT -k $SS_PASSWORD -m $SS_ENCRYPT_METHOD \
    -O $PROTOCOL -G $PROTOCOLPARAM -o $OBFS -g $OBFSPRARAM
