#!/bin/sh

# Copyright 2021 Martin Riedl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# handle arguments
echo "arguments: $@"
SCRIPT_DIR=$1
SOURCE_DIR=$2
TOOL_DIR=$3
OUT_DIR=$4
CPUS=$5
FFMPEG_SNAPSHOT=$6
FFMPEG_LIB_FLAGS=$7

# load functions
. $SCRIPT_DIR/functions.sh

# version
if [ $FFMPEG_SNAPSHOT = "YES" ]; then
    VERSION="snapshot"
else
    # load version
    VERSION=$(cat "$SCRIPT_DIR/../version/ffmpeg")
    checkStatus $? "load version failed"
fi
echo "version: $VERSION"

# start in working directory
cd "$SOURCE_DIR"
checkStatus $? "change directory failed"
#mkdir "ffmpeg"
#checkStatus $? "create directory failed"
cd "ffmpeg/"
checkStatus $? "change directory failed"

# download ffmpeg source
#download https://ffmpeg.org/releases/ffmpeg-$VERSION.tar.bz2 "ffmpeg.tar.bz2"
#checkStatus $? "ffmpeg download failed"

# unpack ffmpeg
#mkdir "ffmpeg"
#checkStatus $? "create directory failed"
#bunzip2 "ffmpeg.tar.bz2"
#checkStatus $? "unpack failed (bunzip2)"
#tar -xf ffmpeg.tar -C ffmpeg --strip-components=1
#checkStatus $? "unpack failed (tar)"
cd "ffmpeg/"
checkStatus $? "change directory failed"

# prepare build
EXTRA_VERSION="https://www.martin-riedl.de"
FF_FLAGS="-L${TOOL_DIR}/lib -I${TOOL_DIR}/include"
export LDFLAGS="$FF_FLAGS"
export CFLAGS="$FF_FLAGS"
# --pkg-config-flags="--static" is required to respect the Libs.private flags of the *.pc files
./configure --prefix="$OUT_DIR" --pkg-config-flags="--static" --extra-version="$EXTRA_VERSION" \
    --enable-gray --enable-libxml2 $FFMPEG_LIB_FLAGS
checkStatus $? "configuration failed"

# start build
make -j $CPUS
checkStatus $? "build failed"

# install ffmpeg
make install
checkStatus $? "installation failed"
