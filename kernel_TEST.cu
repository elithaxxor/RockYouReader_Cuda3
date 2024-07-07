//
// Created by arobot on 7/7/2024.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include <cuda.h>

___global__ void vectorAdd(int* a, int* b, int* c, int size) {
    int i = threadIdx.x; // the .x value is the index of the thread
    if (i < size) {
        c[i] = a[i] + b[i];
        return;
    }
}


int main() {
    int a[] = {1, 2, 3, 4, 5};
    int b[] = {1, 2, 3, 4, 5};

    int c[sizeof(a) /sizeof(int)] = { 0 }; // array a and b are stored in array c

    // marks: the cpu calculation
    for (int i = 0; i < sizeof(c) / sizeof(int); i++) {
        c[i] = a[i] + b[i];
    }


    // marks: the sttart of GPU processing
    int* cudaA = 0;
    int* cudaB = 0;
    int* cudaC = 0;

    // allocate memory intoo the gpu by by creatin  pointers so  pointers into the gpu
    cudaMalloc(&cudaA, sizeof(a));
    cudaMalloc(&cudaB, sizeof(b));
    cudaMalloc(&cudaC, sizeof(c));

    //coopy the vectors into the  gpu --> puts the data into the gpu for processing
    cudaMemcpy(cudaA, a, sizeof(a), cudaMemcpyHostToDevice);
    cudaMemcpy(cudaB, b, sizeof(b), cudaMemcpyHostToDevice);
    //call to the function. must use <<< and 'GRID_SIZE' and 'BLOCK_SIZE' to call the function
    // IE-> vectorAdd<<<GRID_SIZE, BLOCK_SIZE>>>
    // GRID_SIZE is the number of blocks to use
    // BLOCK_SIZE is the number of threads to use

    // SET TO ONE BLOCK AND IS THE SIZE OF THE ARRAY (5)
    vectorAdd<<<1, sizeof(c) / sizeof(int)>>>(cudaA, cudaB, cudaC, sizeof(c) / sizeof(int));
    cudaMemcpy(cudaC, c, sizeof(c), cudaMemcpyHostToDevice); // copies the data out of c

    return 0;
}