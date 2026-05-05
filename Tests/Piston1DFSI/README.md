# One-Dimensional Fluid–Structure Interaction (FSI) Example (A. Narkhede)

This repository contains a simple one-dimensional FSI problem involving a compressible, inviscid fluid interacting with a linear piston.

## 1. Compile the Piston Solver

Navigate to the `piston` directory and build the solver:

```bash
cd piston
cmake .
make
```

## 2. Compile the custom initial condition as a shared library:
```bash
g++ -O3 -fPIC -I/path/to/folder/that/contains/UserDefinedState.h -c UserDefinedState.cpp
g++ -shared UserDefinedState.o -o UserDefinedState.so
rm UserDefinedState.o
```

## 3. Run the coupled analysis

```bash
mpiexec -n 2 [path-to-m2c-executable] input.st : -n 1 piston/piston spring.st
```

## Post processing:
Two gnuplot scripts are provided: 1. Fluid pressure field visualization, 2. Piston displacement and fluid force history

