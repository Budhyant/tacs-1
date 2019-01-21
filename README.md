[![Build Status](https://travis-ci.org/gjkennedy/tacs.svg?branch=master)](https://travis-ci.org/gjkennedy/tacs)

# TACS Overview #

The Toolkit for the Analysis of Composite Structures (TACS) is a parallel finite-element code for analysis and gradient-based design of advanced structures. Originally, TACS was primarily designed as a tool for the analysis of shell structures, such as wing-boxes. More recently it has been extended to perform topology optimization of large three-dimensional structures using gradient-based methods.

TACS has been under continuous development since 2010 by the [Structural and Multidisciplinary Design Optimization group at Georgia Tech](http://gkennedy.gatech.edu) and by the [Multidisciplinary Design Optimization Lab at the University of Michigan](http://mdolab.engin.umich.edu/).

# How to cite TACS #

If you use TACS, please cite one or more of the following papers.

This paper describes the time-dependent flexible multibody dynamics and adjoint capabilities implemented in TACS:

K. Boopathy and G. J. Kennedy.  "Parallel Finite Element Framework for Rotorcraft Multibody Dynamics and Discrete Adjoint Sensitivities", 2019, https://doi.org/10.2514/1.J056585 

This paper describes the core functionality of TACS, including the adjoint-based gradient evaluation techniques it implements:

Kennedy, G. J. and Martins, J. R. R. A, "A parallel finite-element framework for large-scale gradient-based design optimization of high-performance structures", Finite Elements in Analysis and Design, 2014, doi:http://dx.doi.org/10.1016/j.finel.2014.04.011

These papers describe in detail the aggregation functional implementation in TACS:

Kennedy, G. J. and Hicken, J. E., "Improved Constraint-Aggregation Methods", Computer Methods in Applied Mechanics and Engineering, 2015, doi:10.1016/j.cma.2015.02.017

Kennedy, G. J., "Strategies for adaptive optimization with aggregation constraints using interior-point methods", 2015, doi:10.1016/j.compstruc.2015.02.024

# Setting up and installing TACS #

In addition to a working implementation of MPI, BLAS and LAPACK, TACS requires Metis 5.1 for mesh partitioning. The latest version of Metis can be obtained [here](http://glaros.dtc.umn.edu/gkhome/metis/metis/download). TACS can optionally use the approximate minimum degree ordering routines from AMD/UFConfig. These were distributed separately, but can now be obtained from SuiteSparse package. If you use AMD, be sure to define the TACS_HAS_AMD_LIBRARY flag within the Makefile.in configuration file.

To convert TACS FH5 output files to tecplot-compatible files, you must install TecIO. This can be placed in the tacs/extern directory. There is also a FH5 to VTK converter as well that produces (large) ASCII files.

Once the external dependencies are installed, copy Makefile.in.info to Makefile.in. Open Makefile.in and follow the directions within to set the variables. In particular, set the following:

1. TACS_DIR: the root directory of TACS
2. CXX: the C++ compiler - must be MPI-enabled
3. LAPACK_LIBS: the linking arguments for the LAPACK libraries
4. METIS_INCLUDE/METIS_LIB: the include/linking arguments for METIS
5. AMD_INCLUDE/AMD_LIBS: the include/linking arguments for AMD

Note that the default values can often be used without modification. Of all these options, it is most important for performance reasons to link to an optimized version of LAPACK, if possible.

### Setting up the Python interface ###

The python interface can be created with a call to setup.py. The setup.cfg.info contains the recommended defaults for the configuration script. For development, create a local development installation by executing

python setup.py develop --user

You can subsequently execute the following command to update the python interface after changes.

python setup.py build_ext --inplace 

This command is also executed by the command make interface.

### Converting FH5 files ###

The utility f5totec can be used to convert the .f5 files generated by TACS to tecplot .plt files. This utility is located under tacs/extern/f5totec/. I find it convenient to create a symbolic link to f5totec in a bin directory.
