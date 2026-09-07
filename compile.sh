#!/bin/bash
# ProgramBench-style build: must produce ./executable at the repo root.
set -e
cd "$(dirname "$0")"
rm -rf build
# Static libgromacs so the copied gmx binary is self-contained (no @rpath dylib).
# Bundled fftpack (no external FFTW); trim optional components; cap parallelism.
cmake -B build -DCMAKE_BUILD_TYPE=Release -DGMX_FFT_LIBRARY=fftpack \
    -DBUILD_SHARED_LIBS=OFF -DGMX_BUILD_HELP=OFF -DBUILD_TESTING=OFF \
    -DGMXAPI=OFF -DGMX_OPENMP=OFF >/dev/null
cmake --build build --parallel 2 --target gmx
cp build/bin/gmx executable
