cmake_minimum_required(VERSION 3.28)
project(RockYouReader_Cuda3 CUDA)

set(CMAKE_CUDA_STANDARD 17)

add_library(RockYouReader_Cuda3 STATIC library.cu)

set_target_properties(RockYouReader_Cuda3 PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
