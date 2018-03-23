# Docker image for shadowsocks

[![Docker Pulls](https://img.shields.io/docker/pulls/yumminhuang/docker-shadowsocks.svg)](https://hub.docker.com/r/yumminhuang/docker-shadowsocks/)
[![Docker Automated build](https://img.shields.io/docker/automated/yumminhuang/docker-shadowsocks.svg)](https://github.com/yumminhuang/docker-shadowsocks)
[![Docker Build Status](https://img.shields.io/docker/build/yumminhuang/docker-shadowsocks.svg)](https://hub.docker.com/r/yumminhuang/docker-shadowsocks/builds/)

Docker image for [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev).

## Run docker

You can launch a shadowsocks server container with the command below:

```bash
docker run -d --name ss -p 8389:8389 \
    -v "$(pwd)/config.json:/config.json" \
    yumminhuang/docker-shadowsocks ss-server -c /config.json
```
Make sure expose the port that defined as `server_port` in `config.json`.

Or append the customized options at the end of `docker run` command, like:

```bash
docker run -d --name ss -p 8388:8388 yumminhuang/docker-shadowsocks \
    ss-server -s '0.0.0.0' -p 8388 -k PASSWORD -m aes-256-cfb
```

## Reference
* [playniuniu/docker-shadowsocks](https://github.com/playniuniu/docker-shadowsocks)
* [shadowsocks-libev/docker/alpine/Dockerfile](https://github.com/shadowsocks/shadowsocks-libev/blob/master/docker/alpine/Dockerfile)
