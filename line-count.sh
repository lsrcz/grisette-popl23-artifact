#!/bin/bash

echo "---- Grisette ----"
echo "Bonsai-NanoScala,$(cloc -csv grisette-haskell-legacy/grisette-benchmarks/{bonsai-lib,bonsai-nanoscala} | grep Haskell | cut -d, -f5)"
echo "Bonsai-LetPoly,$(cloc -csv grisette-haskell-legacy/grisette-benchmarks/{bonsai-lib,bonsai-letpoly} | grep Haskell | cut -d, -f5)"
echo "Cosette,$(cloc -csv grisette-haskell-legacy/grisette-benchmarks/cosette | grep Haskell | cut -d, -f5)"
echo "Ferrite,$(cloc -csv grisette-haskell-legacy/grisette-benchmarks/ferrite | grep Haskell | cut -d, -f5)"
echo "Fluidics,$(cloc -csv grisette-haskell-legacy/grisette-benchmarks/fluidics | grep Haskell | cut -d, -f5)"
echo "IFCL,$(cloc -csv grisette-haskell-legacy/grisette-benchmarks/ifcl | grep Haskell | cut -d, -f5)"
echo "RegexCont,$(cloc -csv grisette-haskell-legacy/grisette-benchmarks/{regex-delim,regex-common} | grep Haskell | cut -d, -f5)"
echo "RegexFree,$(cloc -csv grisette-haskell-legacy/grisette-benchmarks/{regex,regex-common} | grep Haskell | cut -d, -f5)"

pushd leanette-popl22-artifact/interface > /dev/null
./run.sh
popd > /dev/null
