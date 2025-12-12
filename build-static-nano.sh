
#! /bin/bash

set -e

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# nano
cd $WORKSPACE
a1=$(git ls-remote --tags git://git.git.savannah.gnu.org/nano.git | grep -Po 'refs/tags/\K[v0-9]+' | tail -n 1)
a2=$(git ls-remote --tags git://git.git.savannah.gnu.org/nano.git | grep -Po 'refs/tags/v\K[0-9.]+' | tail -n 1)
curl -sL https://www.nano-editor.org/dist/$a1/nano-$a2.tar.xz | tar x --xz
cd nano-$a2
LDFLAGS="-static -no-pie -s" LIBS="-lz" ./configure --prefix=/usr/local/nanomm --enable-libmagic --disable-wrapping --enable-utf8 --enable-static
make
make install

cd /usr/local
tar vcJf ./nanomm.tar.xz nanomm

mv ./nanomm.tar.xz /work/artifact/
