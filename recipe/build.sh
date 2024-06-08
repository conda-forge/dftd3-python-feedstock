#!/usr/bin/env bash

set -ex

cat > ${SRC_DIR}/pkgconfig.ini <<EOF
[binaries]
pkgconfig = '$BUILD_PREFIX/bin/pkg-config'
EOF

build_args=(
  "-Csetup-args=--warnlevel=0"
  "-Csetup-args=--cross-file=${SRC_DIR}/pkgconfig.ini"
)
if [ -f ${BUILD_PREFIX}/meson_cross_file.txt ]; then
  build_args=("${build_args[@]}" "-Csetup-args=--cross-file=${BUILD_PREFIX}/meson_cross_file.txt")
fi

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
  mv python/mesonpep517.toml python/pyproject.toml

  ${PYTHON} -m build \
    "${build_args[@]}" \
    --outdir . \
    --no-isolation \
    --wheel \
    python/

  ${PYTHON} -m pip install *.whl --no-deps -vv
else
  meson setup \
    ${MESON_ARGS} \
    --warnlevel=0 \
    --cross-file=${SRC_DIR}/pkgconfig.ini \
    _build \
    python/

  meson compile -C _build
  meson install -C _build
fi

