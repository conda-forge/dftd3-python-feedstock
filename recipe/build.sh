#!/usr/bin/env bash

set -ex

cat > ${SRC_DIR}/pkgconfig.ini <<EOF
[binaries]
pkgconfig = '$BUILD_PREFIX/bin/pkg-config'
EOF

mv python/mesonpep517.toml python/pyproject.toml

${PYTHON} -m build \
   -Csetup-args="--warnlevel=0" \
   -Csetup-args="--cross-file=${SRC_DIR}/pkgconfig.ini" \
   --outdir . \
   --no-isolation \
   --wheel \
   python/

${PYTHON} -m pip install *.whl --no-deps -vv
