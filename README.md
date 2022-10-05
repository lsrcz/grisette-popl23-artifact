# "Symbolic Compilation as a Monadic Library: Artifact

This repo is the artifact associated with the POPL 2023 submission "Symbolic Compilation as a Monadic Library". The [submitted version of the paper](popl23-paper97.pdf) is included in the artifact.

The artifact is packaged as a docker image. Please refer to the [hardware requirements](#hardware-requirements) and [installation](#installation-and-sanity-testing) sections for the details.
This repository contains several scripts for repreducing the paper results, as well as the source code of Grisette as a submodule. We also included a repository adapted from [Leanette's POPL'22 artifact](https://github.com/uw-unsat/leanette-popl22-artifact/) as a submodule for the Rosette 3 and Rosette 4 benchmarks. We will compare Grisette with them.

## List of Claims
### Statistics of the Benchmarks
We ported the Rosette benchmarks to Grisette, and collected their statistics.
This corresponds to the Section 5.1 and Table 1 in the paper.

The original Rosette benchmarks are available at [leanette-popl22-artifact/rosette-benchmarks-3/](leanette-popl22-artifact/rosette-benchmarks-3/) and [leanette-popl22-artifact/rosette-benchmarks-4/](leanette-popl22-artifact/rosette-benchmarks-4/), and the ported benchmarks are available at [grisette-haskell-legacy/grisette-benchmarks](grisette-haskell-legacy/grisette-benchmarks).

| Benchmark | Grisette Folder | Rosette Folder |
| --------- | --------------- | -------------- |
| Bonsai-NanoScala | [grisette-haskell-legacy/grisette-benchmarks/bonsai-nanoscala-nomemo](grisette-haskell-legacy/grisette-benchmarks/bonsai-nanoscala-nomemo) | [leanette-popl22-artifact/rosette-benchmarks-*/bonsai](leanette-popl22-artifact/rosette-benchmarks-3/bonsai) (entry point: `nanoscala.rkt`) |
| Bonsai-LetPoly | [grisette-haskell-legacy/grisette-benchmarks/bonsai-letpoly-nomemo](grisette-haskell-legacy/grisette-benchmarks/bonsai-letpoly-nomemo) | [leanette-popl22-artifact/rosette-benchmarks-*/bonsai](leanette-popl22-artifact/rosette-benchmarks-3/bonsai) (entry point: `letpoly.rkt`) |
| Cosette | [grisette-haskell-legacy/grisette-benchmarks/cosette](grisette-haskell-legacy/grisette-benchmarks/cosette) | [leanette-popl22-artifact/rosette-benchmarks-*/cosette](leanette-popl22-artifact/rosette-benchmarks-3/cosette) |
| Ferrite | [grisette-haskell-legacy/grisette-benchmarks/ferrite](grisette-haskell-legacy/grisette-benchmarks/ferrite) | [leanette-popl22-artifact/rosette-benchmarks-*/ferrite](leanette-popl22-artifact/rosette-benchmarks-3/ferrite) |
| Fluidics | [grisette-haskell-legacy/grisette-benchmarks/fluidics](grisette-haskell-legacy/grisette-benchmarks/fluidics) | [leanette-popl22-artifact/rosette-benchmarks-*/fluidics](leanette-popl22-artifact/rosette-benchmarks-3/fluidics) |
| IFCL | [grisette-haskell-legacy/grisette-benchmarks/ifcl](grisette-haskell-legacy/grisette-benchmarks/ifcl) | [leanette-popl22-artifact/rosette-benchmarks-*/ifcl](leanette-popl22-artifact/rosette-benchmarks-3/ifcl) |
| RegexCont | [grisette-haskell-legacy/grisette-benchmarks/regex-delim-nomemo](grisette-haskell-legacy/grisette-benchmarks/regex-delim-nomemo) | |
| RegexFree | [grisette-haskell-legacy/grisette-benchmarks/regex-nomemo](grisette-haskell-legacy/grisette-benchmarks/regex-nomemo) | |

### Porting Cosette
We showed that with Grisette we can tune the performance easily and avoid performance bugs with static types by a case study on Cosette.
This corrsponds to the Section 5.2 in the paper.

We implemented an optimized version of Cosette by changing the types and fixing the type errors, and backported the efficient version to the Rosette.

The Grisette implementation is at [grisette-haskell-legacy/grisette-benchmarks/cosette-optimized-merge](grisette-haskell-legacy/grisette-benchmarks/cosette-optimized-merge), and the Rosette implementation is at [leanette-popl22-artifact/rosette-benchmarks-*/cosette-optimized](leanette-popl22-artifact/rosette-benchmarks-3/cosette-optimized).

### Evaluation of Grisette's performance
We compared the performance of Grisette with Rosette 3 / 4, and a variant of Grisette with MEG encodings on the benchmarks described above.
This corrsponds to the Section 5.3 and Table 2 / 3 in the paper.

The implementation of Grisette (MEG) and the corresponding benchmarks are available at [grisette-haskell-legacy/grisette-unordered](grisette-haskell-legacy/grisette-unordered).

The [grisette-haskell-legacy/grisette-unordered/src](grisette-haskell-legacy/grisette-unordered/src) folder contains the implementation for Grisette (MEG), and the benchmarks are in those folders with the same name as the original Grisette implementation but with the suffix `-unordered`.

### Comparing the Default Error Encoding with the CBMC Error Encoding

We compared our default error encoding with the CBMC error encoding. This is implemented by replacing the `ExceptT` monad transformer with a customized `CBMCExceptT` transformer.
This corresponds to the Section 5.4 and Table 4 in the paper.

The CBMC error encoding is implemented at
[grisette-haskell-legacy/grisette-core/src/Grisette/Core/Control/Monad/CBMCExcept.hs](grisette-haskell-legacy/grisette-core/src/Grisette/Core/Control/Monad/CBMCExcept.hs).

The corresponding benchmarks are in the [grisette-haskell-legacy/grisette-cbmcencoding](grisette-haskell-legacy/grisette-cbmcencoding) folder with the suffix `-cbmc`.

### Evaluation of the Effectiveness of Memoization

We compared the performance of Grisette programs with and without memoization.
This corresponds to the Section 5.5 and Table 5 in the paper.

There are several benchmarks with the suffix `-memo` in the [grisette-haskell-legacy/grisette-benchmarks](grisette-haskell-legacy/grisette-benchmarks) folder. The memoized version are in the subfolders without the suffix `-memo`.

## Hardware Requirements

To use this artifact, you will need a x86-64 machine capable of running Docker with at least 16GB of RAM.
The docker image would be about 10GB in size.
Our artifact does **not** work on ARM-based systems such as Apple M1, and we do not guarantee that the
precompiled binaries will work on legacy CPUs that does not support modern ISAs including AVX/AVX2.

The results shown in the paper were obtained on a physical machine running Ubuntu 22.04 LTS with an AMD Ryzen Threadripper 1950X processor and 128 GB of RAM, and we have tested the docker image on the same machine.

The results you obtain may also vary from ours depending on your hardware and software configuration.
For example, we observed a significant performance degradation of Grisette when running the benchmarks on a virtual machine on i7-1185G7 where AVX/AVX2 are not available due to a conflict between VirtualBox and WSL2 (Windows Subsystem of Linux 2).

## Installation and Sanity Testing

To use this artifact, you will need to install Docker on your machine.
See [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/) for the installation instructions.

After installing Docker, you can download and run the Docker image by running:

```bash
# Download the image (~3GB download)
$ docker pull lsrcz/grisette-popl23-artifact:latest

# Run Image
$ docker run -it --name grisette-popl23-artifact lsrcz/grisette-popl23-artifact:latest
```

You will be dropped into a bash shell inside the docker container, in the `/workspace` directory.
There would be three scripts in the `/workspace` directory: `sanity-check.sh`, `line-count.sh` and `run-all.sh`. These would be the main scripts you would use to test your installation and reproduce the results.

After starting the docker image, you can detach from it by pressing `Ctrl+P` and `Ctrl+Q` and reattach to it by running `docker attach grisette-popl23-artifact`.
You can left the container simply by running `exit`.
If you left the container and want to get back, you can restart it with `docker start -ia grisette-popl23-artifact`. If you want to start with a fresh copy of the image, you can run `docker rm grisette-popl23-artifact` to remove the container and then run `docker run -it --name grisette-popl23-artifact lsrcz/grisette-popl23-artifact:latest` again to start a new container.

### Sanity Check
The `sanity-check.sh` script does all the sanity checks for you.
It first run the Grisette using both z3 and boolector solvers to ensure that they are working,
and then validate that Rosette 3 and Rosette 4 are installed correctly by running the sanity check scripts provided by them.

The expected output of the script should look like:

```text
---- Grisette ----
Grisette solver z3 check successful
Grisette solver boolector check successful
---- Rosette ----
(unsat)
(model
 [y 0])
examples/correct-ex-1.rkt:12:4: assume: unbound identifier
  in: assume
  location...:
   examples/correct-ex-1.rkt:12:4
  context...:
   /workspace/leanette-popl22-artifact/rosette-3/rosette/rosette/base/form/module.rkt:16:0
raco cross: command failed
(model
 [y -1])
```

## Reproducing the Results

### Statistics of the Benchmarks (Table 1)

**Expected time**: less than 1 minute.

**Script for this step**:
```bash
$ ./line-count.sh
```

To reproduce the results in Table 1, you can run the `line-count.sh` script.
It calls `cloc` directly to collect the LoC statistics for the Grisette benchmarks,
and uses the statistics collecting facilities of the Leanette artifact ([leanette-popl22-artifact/interface/run.sh](leanette-popl22-artifact/interface/run.sh), [leanette-popl22-artifact/interface/line-count.rkt](leanette-popl22-artifact/interface/line-count.rkt)) to collect the statistics for the Rosette benchmarks.

**Expected output should looks like**:

```text
---- Grisette ----
Bonsai-NanoScala,663
Bonsai-LetPoly,750
Cosette,661
Ferrite,538
Fluidics,141
IFCL,653
RegexCont,239
RegexFree,219
---- Rosette 4 ----
nanoscala,439
letpoly,427
cosette,532
ferrite,348
fluidics,98
ifcl,483
---- Rosette 3 ----
nanoscala,439
letpoly,427
cosette,532
ferrite,348
fluidics,98
ifcl,483
```

### Porting Cosette

**Expected time**: N/A.

**Script for this step**: N/A

You can find the original ported Cosette benchmarks in the [grisette-haskell-legacy/grisette-benchmarks/cosette](grisette-haskell-legacy/grisette-benchmarks/cosette) folder,
and the optimized version in the [grisette-haskell-legacy/grisette-benchmarks/cosette-optimized-merge](grisette-haskell-legacy/grisette-benchmarks/cosette-optimized-merge) folder.

You may compare the two implementations, and we recommend starting the comparison from line 20 of the `Table.hs` file.
We changed the type of `tableContent` from `UnionM RawTable` to `RawTable` here, constraining the table content's lengths to be the same in different execution paths.
Then all the other changes come from adapting the algorithm and fixing the type errors.

If you wish, you can make the same change and try to fix the type errors by yourself. However, this may require knowledge of the Cosette system and may take more time than you have.

After you do the change, you can run `cosette` with
```bash
stack run cosette
```

or run `cosette-optimized-merge` with
```bash
stack run cosette-optimized-merge
```

The performance comparison would be in Table 2 and will be reproduced in the next step.

### Reproducing Table 2-5

**Expected time**: 3-4 hours.

**Script for this step**:

```bash
$ ./run-all.sh
```

The results of Table 2-5 would be reproduced with the [run-all.sh](run-all.sh) script. It runs all the benchmarks we need, collect the results, and then analyze the data and generate the tables.

It first calls [leanette-popl22-artifact/perf/perf.sh](leanette-popl22-artifact/perf/perf.sh) file to run the benchmarks for Rosette 3 and Rosette 4.
The result of this would be two csv files: `r3.csv` and `r4.csv` under [leanette-popl22-artifact/perf/](leanette-popl22-artifact/perf/) folder.

Then it calls [grisette-haskell-legacy/scripts/report.py](grisette-haskell-legacy/scripts/report.py), which calls [grisette-haskell-legacy/scripts/runallbench.sh](grisette-haskell-legacy/scripts/runallbench.sh) to run all the benchmarks needed for Grisette and Grisette (MEG).
Then the `report.py` file would analyze the results and generate the tables.

The generated table would be in latex format and can be compiled with a latex compiler.
The Table 2-5 in our paper are directly copied from the generated latex code.

**Expected output should looks like**:
Note that the following output are collected from the docker container and is slightly different from the output in the paper. You should expect similar minor differences when you run the script on your system.

```latex
\begin{tabular}{lrrrrrrrrrrrrrrrrrrrrr}
  \hline
  \multirow{2}{*}{Benchmark}&\multicolumn{5}{c}{\textsc{Grisette}}&&\multicolumn{5}{c}{\textsc{Grisette} (MEG)}&&\multicolumn{4}{c}{\textsc{Rosette} 3}&&\multicolumn{4}{c}{\textsc{Rosette} 4}\\
  \cline{2-6}\cline{8-12}\cline{14-17}\cline{19-22}
                     &T    &E   &L    &S    &Tm   &&T    &E    &L    &S    &Tm   &&T    &E   &S    &Tm   &&T    &E   &S    &Tm   \\
  \hline
  \textsc{Ferrite}   &2.6  &.82 &.37  &1.8  &12   &&9.5  &2.3  &1.7  &7.2  &56   &&27   &17  &9.7  &34   &&39   &20  &19   &40   \\
  \textsc{IFCL}      &38   &5.0 &3.3  &33   &91   &&44   &11   &7.6  &33   &222  &&231  &14  &217  &383  &&174  &15  &159  &438  \\
  \textsc{Fluidics}  &13   &2.8 &2.0  &10   &67   &&222  &138  &131  &84   &1371 &&26   &8.8 &17   &284  &&31   &9.3 &22   &308  \\
  \textsc{Cosette}   &.3   &.11 &.041 &.2   &1.5  &&1.3  &.55  &.23  &.71  &8.4  &&16   &8.1 &8.3  &114  &&13   &8.3 &4.4  &128  \\
  \textsc{DOT}       &1.7  &1.2 &.73  &.49  &21   &&5.7  &4.7  &2.9  &     &71   &&29   &24  &4.4  &664  &&57   &52  &5.0  &1222 \\
  \textsc{LetPoly}   &137  &18  &5.9  &120  &102  &&1272 &1001 &840  &271  &1725 &&1521 &194 &1326 &4908 &&1395 &143 &1252 &5152 \\
  \hline
  \textsc{Cosette-1} &.024 &.01 &.003 &.015 &.077 &&.026 &.01  &.003 &.015 &.077 &&.32  &.15 &.17  &.13  &&.31  &.14 &.17  &.13  \\
  \hline
  \textsc{RegexCont} &7.2  &6.9 &.68  &.28  &16   &&77   &70   &44   &6.9  &311  &&     &    &     &     &&     &    &     &     \\
  \textsc{RegexFree} &8.5  &8.3 &.6   &.28  &16   &&81   &72   &45   &8.8  &318  &&     &    &     &     &&     &    &     &     \\
  \hline
\end{tabular}
\begin{tabular}{lrrrrrrrrrrrrrrr}
  \hline  \multirow{2}{*}{Version}&\multicolumn{3}{c}{Total time}&&\multicolumn{3}{c}{Eval time}&&\multicolumn{3}{c}{Solve time}&&\multicolumn{3}{c}{Term count}\\
  \cline{2-4}\cline{6-8}\cline{10-12}\cline{14-16}
                        &best  &worst &mean  &&best  &worst &mean  &&best  &worst &mean &&best  &worst   &mean   \\
  \hline
\textsc{Grisette} (MEG) &17.3x &1.1x  &3.7x  &&57.2x &1.1x  &6.2x  &&8.4x  &1.0x  &2.5x &&4.9\% &100.0\% &20.1\% \\
\textsc{Rosette} 3      &53.7x &2.0x  &10.7x &&75.9x &2.8x  &12.5x &&41.8x &1.7x  &8.4x &&1.3\% &60.6\%  &10.1\% \\
\textsc{Rosette} 4      &41.7x &2.4x  &11.7x &&77.8x &3.0x  &13.8x &&22.2x &2.2x  &8.5x &&1.1\% &59.2\%  &8.5\%  \\
  \hline
\end{tabular}
\begin{tabular}{lrrrrrrrrrrr}
  \hline
  \multirow{2}{*}{Benchmark}&\multicolumn{5}{c}{\textsc{Grisette}}&&\multicolumn{5}{c}{\textsc{Grisette} (CBMC error encoding)}\\  \cline{2-6}\cline{8-12}
                   &Total &Eval &Lower &Solve &Term &&Total &Eval &Lower &Solve &Term \\
  \hline
  \textsc{IFCL}    &38    &5.0  &3.3   &33    &91   &&84    &5.0  &3.4   &79    &91   \\
  \textsc{DOT}     &1.7   &1.2  &.73   &.49   &21   &&1.7   &1.1  &.66   &.6    &20   \\
  \textsc{LetPoly} &137   &18   &5.9   &120   &102  &&79    &17   &5.3   &62    &91   \\
  \hline
\end{tabular}
\begin{tabular}{lrrrrrrrrrrrr}
  \hline
  \multirow{2}{*}{Benchmark}&\multicolumn{4}{c}{no memoization}&&\multicolumn{4}{c}{with memoization}&&\multicolumn{2}{c}{speedup ratio}\\
  \cline{2-5}\cline{7-10}\cline{12-13}
                     &Total &Eval &Lower &Solv &&Total &Eval &Lower &Solv &&Total &Eval \\
  \hline
  \textsc{DOT}       &2.9   &2.4  &.7    &.48  &&1.7   &1.2  &.73   &.49  &&1.7x  &2.0x \\
  \textsc{LetPoly}   &162   &41   &5.1   &121  &&137   &18   &5.9   &120  &&1.2x  &2.3x \\
  \textsc{RegexCont} &50    &49   &.46   &.27  &&7.2   &6.9  &.68   &.28  &&6.9x  &7.2x \\
  \textsc{RegexFree} &72    &71   &.43   &.29  &&8.5   &8.3  &.6    &.28  &&8.4x  &8.6x \\
  \hline
\end{tabular}
```
