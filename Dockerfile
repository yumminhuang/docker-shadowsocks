FROM alpine:latest

LABEL maintainer="Yaming Huang <yumminhuang@gmail.com>"

ENV SS_VERSION=3.3.3

RUN set -ex && \
    apk add --no-cache --virtual .build-deps \
                                autoconf \
                                build-base \
                                c-ares-dev \
                                curl \
                                libev-dev \
                                libtool \
                                linux-headers \
                                libsodium-dev \
                                mbedtls-dev \
                                pcre-dev \
                                tar && \
    cd /tmp && \
    curl -sSL "https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_VERSION/shadowsocks-libev-$SS_VERSION.tar.gz" | tar xz --strip 1 && \
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

CMD ["ss-server"]
