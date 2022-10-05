## List of Claims
### Statistics of Benchmarks
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

