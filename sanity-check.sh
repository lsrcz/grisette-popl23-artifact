#!/bin/bash

echo "---- Grisette ----"
pushd grisette-haskell-legacy > /dev/null
PATH=scripts/solvers:$PATH stack run sanity-check 2>/dev/null
popd > /dev/null

echo "---- Rosette ----"
pushd leanette-popl22-artifact/ > /dev/null
raco cross -q --workspace rosette-4 racket examples/correct-ex-1.rkt
raco cross -q --workspace rosette-4 racket examples/incorrect-ex-1.rkt
raco cross -q --workspace rosette-3 racket examples/correct-ex-1.rkt
raco cross -q --workspace rosette-3 racket examples/rosette-3.rkt
popd > /dev/null
