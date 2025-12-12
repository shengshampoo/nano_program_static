
#! /bin/bash

set -e

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# nano
cd $WORKSPACE
aa=8.7
curl -sL https://www.nano-editor.org/dist/v8/nano-$aa.tar.xz | tar x --xz
cd nano-$aa
LDFLAGS="-static -no-pie -s" LIBS="-lz" ./configure --prefix=/usr/local/nanomm --enable-libmagic --disable-wrapping --enable-utf8 --enable-static
make
make install

cd /usr/local
tar vcJf ./nanomm.tar.xz nanomm

mv ./nanomm.tar.xz /work/artifact/
