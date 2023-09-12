#pragma once

#include "omp_extra.h"

#include <pybind11/pybind11.h>
namespace py = pybind11;
using namespace pybind11::literals;

// See : https://www.openmp.org/spec-html/5.0/openmpsu32.html#x51-710002.5.3

void init_omp_extra(py::module &m);