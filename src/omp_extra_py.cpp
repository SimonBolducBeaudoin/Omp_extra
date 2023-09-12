#include "omp_extra_py.h"

// See : https://www.openmp.org/spec-html/5.0/openmpsu32.html#x51-710002.5.3

void init_omp_extra(py::module &m)
{
	m.def("set_dynamic", &omp_set_dynamic);
	m.def("get_dynamic", &omp_get_dynamic);
    m.def("set_num_threads", &omp_set_num_threads);
    m.def("get_max_threads", &omp_get_max_threads);
	m.def("set_schedule", &omp_set_schedule);
	m.def("get_schedule", &omp_get_schedule);
	m.def("get_proc_bind", &omp_get_proc_bind);
	m.def("get_thread_limit", &omp_get_thread_limit);
	m.def("set_max_active_levels", &omp_set_max_active_levels);
	m.def("get_max_active_levels", &omp_get_max_active_levels);
	m.def("set_nested", &omp_set_nested);
	m.def("get_active_level", &omp_get_active_level);
	m.def("get_level", &omp_get_level);
	m.def("get_cancellation", &omp_get_cancellation);
	m.def("set_affinity_format", &omp_set_affinity_format);
	m.def("get_affinity_format", &omp_get_affinity_format);
	m.def("set_default_device", &omp_set_default_device);
	m.def("get_default_device", &omp_get_default_device);
	m.def("get_max_task_priority", &omp_get_max_task_priority);
	// m.def("set_default_allocator", &omp_set_default_allocator); // gives not delcared error
	// m.def("get_default_allocator", &omp_get_default_allocator); // gives not delcared error
}
