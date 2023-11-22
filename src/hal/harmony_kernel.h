/*
Data-parallelizable version of the harmony function
*/
#include <CL/sycl.hpp>
#include "dpc_common.h"

template<T> 
T harmony1(T* x, int size);

