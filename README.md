# Docker image for shadowsocks

[![Docker Pulls](https://img.shields.io/docker/pulls/yumminhuang/docker-shadowsocks.svg)](https://hub.docker.com/r/yumminhuang/docker-shadowsocks/)
[![Docker Automated build](https://img.shields.io/docker/automated/yumminhuang/docker-shadowsocks.svg)](https://github.com/yumminhuang/docker-shadowsocks)
[![Docker Build Status](https://img.shields.io/docker/build/yumminhuang/docker-shadowsocks.svg)](https://hub.docker.com/r/yumminhuang/docker-shadowsocks/builds/)

Docker image for [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev).

## Run docker

You can launch a shadowsocks server container with the command below:

```bash
docker run -d --name ss -p 31913:31913 yumminhuang/docker-shadowsocks
```
which uses

* Encrypt Method: `aes-256-cfb` (can change by specifying `-e SS_ENCRYPY_METHOD='aes-256-gcm'` in `docker run` command);;
* Server Port: `31913` (can change by specifying `-e SS_PORT=8338` in `docker run` command);
* Password: `shadowsocks` (can change by specifying `-e 'SS_PASSWORD=strongpassword'` in `docker run` command).

and default options `--fast-open -d 8.8.8.8 -d 8.8.4.4 -v`

Append the customized options at the end of `docker run` command, like:

```bash
docker run -d --name ss -p 8388:8388 -e 'SS_PASSWORD=strongpassword' -e 'SS_PORT=8388' yumminhuang/docker-shadowsocks -u -v -t 60
```

## Reference
* [playniuniu/docker-shadowsocks](https://github.com/playniuniu/docker-shadowsocks)
* [shadowsocks-libev/docker/alpine/Dockerfile](https://github.com/shadowsocks/shadowsocks-libev/blob/master/docker/alpine/Dockerfile)
