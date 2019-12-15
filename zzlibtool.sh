#!/bin/bash
# install libtool
set -e

ROOTDIR=${ZZROOT:-$HOME/app}
NAME="libtool"
TYPE=".tar.gz"
FILE="$NAME$TYPE"
DOWNLOADURL="http://mirror-hk.koddos.net/gnu/libtool/libtool-2.4.6.tar.gz"
echo $NAME will be installed in $ROOTDIR

mkdir -p $ROOTDIR/downloads
cd $ROOTDIR

if [ -f "downloads/$FILE" ]; then
    echo "downloads/$FILE exist"
else
    echo "$FILE does not exist, downloading from $DOWNLOADURL"
    wget $DOWNLOADURL -O $FILE
    mv $FILE downloads/
fi

mkdir -p src/$NAME
tar xf downloads/$FILE -C src/$NAME --strip-components 1

cd src/$NAME

./configure --prefix=$ROOTDIR
make -j && make install

echo $NAME installed on $ROOTDIR