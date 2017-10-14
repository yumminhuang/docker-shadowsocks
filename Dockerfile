FROM alpine:latest

MAINTAINER Yaming Huang <yumminhuang@gmail.com>

ENV SS_VERSION=3.1.0 \
    SS_PORT=31913

RUN set -ex && \
    apk add --no-cache --virtual .build-deps \
                                autoconf \
                                automake \
                                build-base \
                                c-ares-dev \
                                curl \
                                git \
                                libev-dev \
                                libtool \
                                linux-headers \
                                libsodium-dev \
                                mbedtls-dev \
                                pcre-dev \
                                tar && \
    cd /tmp && \
    curl -sSL https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_VERSION/shadowsocks-libev-$SS_VERSION.tar.gz | tar xz --strip 1 && \
    ./configure --prefix=/usr --disable-documentation && \
    make install && \
    git clone --depth 1 --recursive https://github.com/shadowsocks/simple-obfs.git && \
    cd /tmp/simple-obfs && ./autogen.sh && ./configure --prefix=/usr --disable-documentation && \
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

ENTRYPOINT ss-server -c /etc/config.json -v
CMD ["-d", "8.8.8.8", "-d", "8.8.4.4", "--plugin", "obfs-local", "--plugin-opts", "obfs=http;obfs-host=www.bing.com"]
