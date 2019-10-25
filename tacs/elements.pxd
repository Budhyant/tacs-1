#  This file is part of TACS: The Toolkit for the Analysis of Composite
#  Structures, a parallel finite-element code for structural and
#  multidisciplinary design optimization.
#
#  Copyright (C) 2014 Georgia Tech Research Corporation
#
#  TACS is licensed under the Apache License, Version 2.0 (the
#  "License"); you may not use this software except in compliance with
#  the License.  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0

# distutils: language=c++

# Import numpy
from libc.string cimport const_char

# Import the major python version
from cpython.version cimport PY_MAJOR_VERSION

# Import numpy
cimport numpy as np
import numpy as np

# Import from constitutive for definitions
from constitutive cimport *
from TACS cimport *

cdef extern from "TACSElementBasis.h":
    cdef cppclass TACSElementBasis(TACSObject):
        ElementLayout getLayoutType()
        int getNumNodes()
        int getNumParameters()

cdef class ElementBasis:
    cdef TACSElementBasis *ptr

cdef inline _init_ElementBasis(TACSElementBasis *ptr):
    basis = ElementBasis()
    basis.ptr = ptr
    basis.ptr.incref()
    return basis

cdef extern from "TACSElementModel.h":
    cdef cppclass TACSElementModel(TACSObject):
        int getSpatialDim()
        int getVarsPerNode()

cdef class ElementModel:
    cdef TACSElementModel *ptr

cdef inline _init_ElementModel(TACSElementModel *ptr):
    model = ElementModel()
    model.ptr = ptr
    model.ptr.incref()
    return model

cdef extern from "TACSElementVerification.h":
    int TacsTestElementBasis(TACSElementBasis*, double, int, double, double)

cdef extern from "TACSTetrahedralBasis.h":
    cdef cppclass TACSLinearTetrahedralBasis(TACSElementBasis):
        TACSLinearTetrahedralBasis()

    cdef cppclass TACSQuadraticTetrahedralBasis(TACSElementBasis):
        TACSQuadraticTetrahedralBasis()

    cdef cppclass TACSCubicTetrahedralBasis(TACSElementBasis):
        TACSCubicTetrahedralBasis()

cdef extern from "TACSHexaBasis.h":
    cdef cppclass TACSLinearHexaBasis(TACSElementBasis):
        TACSLinearHexaBasis()

    cdef cppclass TACSQuadraticHexaBasis(TACSElementBasis):
        TACSQuadraticHexaBasis()

    cdef cppclass TACSCubicHexaBasis(TACSElementBasis):
        TACSCubicHexaBasis()

cdef extern from "TACSQuadBasis.h":
    cdef cppclass TACSLinearQuadBasis(TACSElementBasis):
        TACSLinearQuadBasis()

    cdef cppclass TACSQuadraticQuadBasis(TACSElementBasis):
        TACSQuadraticQuadBasis()

    cdef cppclass TACSCubicQuadBasis(TACSElementBasis):
        TACSCubicQuadBasis()

cdef extern from "TACSTriangularBasis.h":
    cdef cppclass TACSLinearTriangleBasis(TACSElementBasis):
        TACSLinearTriangleBasis()

    cdef cppclass TACSQuadraticTriangleBasis(TACSElementBasis):
        TACSQuadraticTriangleBasis()

    cdef cppclass TACSCubicTriangleBasis(TACSElementBasis):
        TACSCubicTriangleBasis()

cdef extern from "TACSHeatConduction.h":
    cdef cppclass TACSHeatConduction2D(TACSElementModel):
        TACSHeatConduction2D(TACSPlaneStressConstitutive*)

    cdef cppclass TACSHeatConduction3D(TACSElementModel):
        TACSHeatConduction3D(TACSSolidConstitutive*)

cdef extern from "TACSLinearElasticity.h":
    enum ElementStrainType:
        TACS_LINEAR_STRAIN
        TACS_NONLINEAR_STRAIN

    cdef cppclass TACSLinearElasticity2D(TACSElementModel):
        TACSLinearElasticity2D(TACSPlaneStressConstitutive*,
                               ElementStrainType)

    cdef cppclass TACSLinearElasticity3D(TACSElementModel):
        TACSLinearElasticity3D(TACSSolidConstitutive*,
                               ElementStrainType)

cdef extern from "TACSThermoelasticity.h":
    cdef cppclass TACSLinearThermoelasticity2D(TACSElementModel):
        TACSLinearThermoelasticity2D(TACSPlaneStressConstitutive*,
                                     ElementStrainType)

    cdef cppclass TACSLinearThermoelasticity3D(TACSElementModel):
        TACSLinearThermoelasticity3D(TACSSolidConstitutive*,
                                     ElementStrainType)

cdef extern from "TACSElement2D.h":
    cdef cppclass TACSElement2D(TACSElement):
        TACSElement2D(TACSElementModel*, TACSElementBasis*)

cdef extern from "TACSElement3D.h":
    cdef cppclass TACSElement3D(TACSElement):
        TACSElement3D(TACSElementModel*, TACSElementBasis*)

# cdef extern from "TACSGibbsVector.h":
#     cdef cppclass TACSGibbsVector(TACSObject):
#         TACSGibbsVector(TacsScalar, TacsScalar, TacsScalar)

# cdef extern from "TACSRigidBody.h":
#     cdef cppclass TACSRefFrame(TACSObject):
#         TACSRefFrame(TACSGibbsVector*, TACSGibbsVector*, TACSGibbsVector*)

#     cdef cppclass TACSRigidBodyViz(TACSObject):
#         TACSRigidBodyViz(int, int, TacsScalar*, int*, TACSGibbsVector*)
#         TACSRigidBodyViz(TacsScalar, TacsScalar, TacsScalar)

#     cdef cppclass TACSRigidBody(TACSElement):
#         TACSRigidBody(TACSRefFrame*, const TacsScalar, const TacsScalar*,
#                       const TacsScalar*, TACSGibbsVector*,
#                       TACSGibbsVector*, TACSGibbsVector*, TACSGibbsVector*)
#         void setDesignVarNums(int, const int*, const int*)
#         void setVisualization(TACSRigidBodyViz*)

# cdef extern from "KinematicConstraints.h":
#     cdef cppclass TACSFixedConstraint(TACSElement):
#         TACSFixedConstraint(TACSRigidBody *bodyA,
#                             TACSGibbsVector *point)

#     cdef cppclass TACSSphericalConstraint(TACSElement):
#         TACSSphericalConstraint(TACSRigidBody *bodyA, TACSRigidBody *bodyB,
#                                 TACSGibbsVector *point)
#         TACSSphericalConstraint(TACSRigidBody *bodyA,
#                                 TACSGibbsVector *point)

#     cdef cppclass TACSRevoluteConstraint(TACSElement):
#         TACSRevoluteConstraint(TACSRigidBody *bodyA, TACSRigidBody *bodyB,
#                                TACSGibbsVector *point, TACSGibbsVector *eA)
#         TACSRevoluteConstraint(TACSRigidBody *bodyA,
#                                TACSGibbsVector *point, TACSGibbsVector *eA)

#     cdef cppclass TACSRigidLink(TACSElement):
#         TACSRigidLink(TACSRigidBody*)

#     cdef cppclass TACSRevoluteDriver(TACSElement):
#         TACSRevoluteDriver(TACSGibbsVector*, TacsScalar)

#     cdef cppclass TACSMotionDriver(TACSElement):
#         TACSMotionDriver(TACSGibbsVector*, TacsScalar, int)

#     cdef cppclass TACSAverageConstraint(TACSElement):
#         TACSAverageConstraint(TACSRigidBody*, TACSGibbsVector*,
#                               TACSRefFrame*, int)

# cdef extern from "TACSElementWrapper.h":
#     cdef cppclass TACSElementWrapper(TACSElement):
#         TACSElementWrapper(PyObject *obj, int, int)

#         # Member functions
#         void (*getinitconditions)( void *, int, int,
#                                    TacsScalar *, TacsScalar *,
#                                    TacsScalar *, const TacsScalar * )

#         void (*addresidual)( void *, int, int, double time, TacsScalar *,
#                              const TacsScalar *,
#                              const TacsScalar *,
#                              const TacsScalar *,
#                              const TacsScalar * )

#         void (*addjacobian)( void *, int, int, double time, TacsScalar *,
#                              double alpha, double beta, double gamma,
#                              const TacsScalar *,
#                              const TacsScalar *,
#                              const TacsScalar *,
#                              const TacsScalar * )

#         void addadjresproduct(void * , int, int, double,
#                            TacsScalar, TacsScalar *, int,
#                            const TacsScalar *,
#                            const TacsScalar *,
#                            const TacsScalar *,
#                            const TacsScalar *,
#                            const TacsScalar * )
