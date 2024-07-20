


#include <ctime>
#include <cuda.h>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
// Theads are organized in blocks in GPUS (since they have so much more threads than CPUs)
// The blocks are organized in a grid (a 3D array of blocks)
//  This is a test to see if the GPU can add two arrays together

using namespace std;
int count = 1000; // number of elements in the array


// THE VARIABLE "ID" IS GOING TO BE A UNINQUE INDEX OF THE THREAD, SO MANY THREADS CAN RUN AT THE SAME TIME
__global__ void vectorAdd(int* a, int* b, int* c, int size) {
    int id = blockIdx.x * blockDim.x + threadIdx.x; // the .x value is the index of the thread
	printf(" the id is %d\n", id, "\n", "The size is %d\n", size, "\n\n" Block Index X: "%d\n", blockIdx.x, "\n", "Thread Index X: %d\n", threadIdx.x, "\n\n");
    if (i < size) {
        c[i] = a[i] + b[i];
        return;
    }
}
int main2() {

    srand(time(NULL));
    int *arrA = new int [count];
    int *arrB = new int [count];


    // MARK: the array is filled with random numbers (0-1000)
    for (int  i = 0 ; i < count; i++) {
        arrA[i] = rand() % 1000;
        arrB[i] = rand() % 1000;
    }

    printf("5 elements of the arrays, prior to addtion(running CPU calculation)", h_a, "\n", h_b);
    for(int i = 0; i < count; i++) {
        printf("%d + %d = %d\n", h_a[i], h_b[i], "\n",  h_a[i] + h_b[i]);
    }

    // MARK: Check if memory allocation condionts are met
    if(cudaMalloc(d_a, sizeof(int) * count) != cudaSuccess) {
        printf("Error allocating memory for d_a\n");
        cudaFree(d_b);
        return 1;
    }
    if(cudaMalloc(&d_b, sizeof(int) * count) != cudaSuccess) {
        printf("Error allocating memory for d_b\n");
        cudaFree(d_a);
        return 1;
    }

    // Copys the value from the hosts calculation to the GPU
    if(cudaMemcpy(d_a, arrA, sizeof(int) * count, cudaMemcpyHostToDevice) != cudaSuccess) {
        printf("Error copying memory to d_a\n");
        cudaFree(d_a);
        cudaFree(d_b);
        return 1;
    }
    if(cudaMemcpy(d_b, arrB, sizeof(int) * count, cudaMemcpyHostToDevice) != cudaSuccess) {
        printf("Error copying memory to d_b\n");
        cudaFree(d_a);
        cudaFree(d_b);
        return 1;
    }

    // MARK: The GPU calculation, calls the kernal
    //->> this is where  the threads per block and the number of blocks are set
    vectorAdd<<<count / 256 + 1, 256>>(d_a, d_b, d_c, count);

    if(cudaGetLastError() != cudaSuccess) {
        printf("Error launching the kernal\n");
        cudaFree(d_a);
        cudaFree(d_b);
        delete[] arrA;
        delete[] arrB;
        return 1;
    }

    // Checks if GPU calculation was successful by comparing to CPU calculation
    print("5 elements of the arrays, after addtion(running GPU calculation)\n");
    for(int i = 0, i < count; i++) {
        print("%d + %d = %d\n", arrA[i], arrB[i], arrC[i]);
    }

    cudaFree(d_a);
    cudaFree(d_b);
    delete[] arrA;
    delete[] arrB;

}


return 0 ;
}
