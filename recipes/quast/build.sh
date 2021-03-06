#!/bin/bash

export INCLUDE_PATH="${PREFIX}/include"
export LIBRARY_PATH="${PREFIX}/lib"
export LD_LIBRARY_PATH="${PREFIX}/lib"
export BOOST_INCLUDE_DIR=${PREFIX}/include
export BOOST_LIBRARY_DIR=${PREFIX}/lib

export CXXFLAGS="-DUSE_BOOST -I${BOOST_INCLUDE_DIR} -L${BOOST_LIBRARY_DIR}"
export LDFLAGS="-L${BOOST_LIBRARY_DIR}"
export CFLAGS="-DUSE_BOOST -I${BOOST_INCLUDE_DIR} -L${BOOST_LIBRARY_DIR}"


sed -i 's|^CXXFLAGS.*||' libs/E-MEM-linux/Makefile
sed -i 's|^CFLAGS.*||' libs/E-MEM-linux/Makefile
sed -i 's|^LDFLAGS.*||' libs/E-MEM-linux/Makefile


BINARY_HOME=$PREFIX/bin
QUAST_HOME=$PREFIX/opt/quast-$PKG_VERSION

mkdir -p $BINARY_HOME
mkdir -p $QUAST_HOME

cp -R $SRC_DIR/* $QUAST_HOME

make CFLAGS="-Wall -Wextra -Wunused -mpopcnt -std=gnu++0x -fopenmp -I${PREFIX}/include" -C $PREFIX/opt/quast-4.1/libs/MUMmer3.23-linux

make CFLAGS="-Wall -Wextra -Wunused -mpopcnt -std=gnu++0x -fopenmp -I${PREFIX}/include" -C $PREFIX/opt/quast-4.1/libs/E-MEM-linux

#Linking to binfolder
chmod +x $QUAST_HOME/quast.py
ln -s "$QUAST_HOME/quast.py" "$BINARY_HOME/quast"

chmod +x $QUAST_HOME/metaquast.py
ln -s "$QUAST_HOME/metaquast.py" "$BINARY_HOME/metaquast"
