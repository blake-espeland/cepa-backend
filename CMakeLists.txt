set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_MAKE_PROGRAM "ninja")

set(METAL_DIR, ${CMAKE_CURRENT_LIST_DIR}/src/metal)
set(HOME, ${ENV{HOME}})

project(CONTROL)

message(${HOME})

find_package(SYCL)

if(SYCL_FOUND)
    message("SYCL found")
endif()



add_executable(control )

