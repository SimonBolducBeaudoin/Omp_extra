#include "python_submodule.h"
#include "git_version.h"
#include <string>

// See Pybind11 FAQ «How can I reduce the build time ?» :
// https://pybind11.readthedocs.io/en/stable/faq.html#how-can-i-reduce-the-build-time

//Python Binding and Time_Quad class instances.
PYBIND11_MODULE(omp_extra, m)
{
    m.doc() = "Git tag : " + std::string(kGitTag) +"\n"+"Git hash : " + std::string(kGitHash) +"\n"+ "Some OpenMP functions to modify environnement variables";
	init_omp_extra(m);
}
