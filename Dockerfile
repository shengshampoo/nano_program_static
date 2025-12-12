FROM alpine:latest

# https://mirrors.alpinelinux.org/
RUN sed -i 's@dl-cdn.alpinelinux.org@ftp.halifax.rwth-aachen.de@g' /etc/apk/repositories

RUN apk update
RUN apk upgrade

# required nano 
RUN apk add --no-cache \
  gcc make groff linux-headers musl-dev ncurses-dev ncurses-static \
  zlib-dev zlib-static curl libmagic-static texinfo file-dev \
  bash xz git grep


ENV XZ_OPT=-e9
COPY build-static-nano.sh build-static-nano.sh
RUN chmod +x ./build-static-nano.sh
RUN bash ./build-static-nano.sh
