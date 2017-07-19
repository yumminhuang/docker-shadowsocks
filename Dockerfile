FROM alpine:latest

MAINTAINER Yaming Huang <yumminhuang@gmail.com>

ENV SS_VERSION=3.0.7 \
    SS_PORT=31913 \
    SS_ENCRYPT_METHOD="aes-256-gcm" \
    SS_PASSWORD="shadowsocks"

RUN set -ex && \
    apk add --no-cache --virtual .build-deps \
                                autoconf \
                                build-base \
                                curl \
                                libev-dev \
                                libtool \
                                linux-headers \
                                libsodium-dev \
                                mbedtls-dev \
                                pcre-dev \
                                tar \
                                udns-dev && \
    cd /tmp && \
    curl -sSL https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_VERSION/shadowsocks-libev-$SS_VERSION.tar.gz | tar xz --strip 1 && \
    ./configure --prefix=/usr --disable-documentation && \
    make install && \
    cd .. && \
    runDeps="$( \
       scanelf --needed --nobanner /usr/bin/ss-* \
       | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
       | xargs -r apk info --installed \
       | sort -u \
    )" && \
    apk add --no-cache --virtual .run-deps $runDeps && \
    apk del .build-deps && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE $SS_PORT/tcp $SS_PORT/udp

ENTRYPOINT ss-server -s '0.0.0.0' -p $SS_PORT -k $SS_PASSWORD -m $SS_ENCRYPT_METHOD -v
CMD ["--fast-open", "-d", "8.8.8.8", "-d", "8.8.4.4"]
