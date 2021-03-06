#!/bin/bash
# install hdf5
set -e

ROOTDIR=${ZZROOT:-$HOME/app}
NAME="hdf5"
TYPE=".tar.gz"
FILE="$NAME$TYPE"
DOWNLOADURL="https://s3.amazonaws.com/hdf-wordpress-1/wp-content/uploads/manual/HDF5/HDF5_1_10_5/source/hdf5-1.10.5.tar.gz -O hdf5.tar.gz"
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
make -j$(nproc) && make install

echo $NAME installed on $ROOTDIR
