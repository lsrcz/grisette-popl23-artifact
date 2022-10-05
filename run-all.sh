#!/bin/bash

# Run Rosette
pushd leanette-popl22-artifact/perf
./perf.sh
popd

# Run Grisette and print results
pushd grisette-haskell-legacy/scripts
./report.py --rerun --r3 ../../leanette-popl22-artifact/perf/r3.csv --r4 ../../leanette-popl22-artifact/perf/r4.csv
popd
