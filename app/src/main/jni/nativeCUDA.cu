#include "nativeCUDA.cuh"

#include <cuda_runtime.h>
#include <cuda.h>

#define DEBUG
inline
cudaError_t checkCuda(cudaError_t result) {
#if defined(DEBUG) || defined(_DEBUG)
		if (result != cudaSuccess) {
			LOGI("CUDA Runtime Error: %sn", cudaGetErrorString(result));
			//assert(result == cudaSuccess);
		}
#endif
		return result;
}

__global__ void addKernel(float* d_a, float* d_b, float* d_ret, int n);

void launchAddKernel(float* d_a, float* d_b, float* d_ret, int n) {
    addKernel<<<(n + TPB-1) / TPB, TPB>>>(d_a, d_b, d_ret, n);
}

float* CUDA_addVectors(float* a, float* b, int n) {
    size_t arr_size = n * sizeof(float);

    // Allocate space for sum
    float *ret, *d_ret;
    checkCuda( cudaMallocHost((void**) &ret, arr_size) ); // Host
    checkCuda( cudaMalloc((void**) &d_ret, arr_size) ); // Device
    // Allocate device space for a and b
    float *d_a, *d_b;
    checkCuda (cudaMalloc((void**) &d_a, arr_size) );
    checkCuda (cudaMalloc((void**) &d_b, arr_size) );
    // Copy a and b to device memory asynchronously
    checkCuda( cudaMemcpyAsync(d_a, a, arr_size, cudaMemcpyHostToDevice) );
    checkCuda( cudaMemcpyAsync(d_b, b, arr_size, cudaMemcpyHostToDevice) );
    // Wait for copies to complete
    cudaDeviceSynchronize();

    // Launch device kernel
    launchAddKernel(d_a, d_b, d_ret, n);
    // Wait for kernel to finish
    cudaDeviceSynchronize();
    // Check for any errors created by kernel
    checkCuda(cudaGetLastError());

    // Copy back sum array
    checkCuda( cudaMemcpy(ret, d_ret, arr_size, cudaMemcpyDeviceToHost) );

    // Free allocated memory
    cudaFree(d_ret);
    cudaFree(d_a);
    cudaFree(d_b);

    return ret;
}

// GPU kernel
__global__ void addKernel(float* d_a, float* d_b, float* d_ret, int n) {
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= n) {
        return;
    }
    d_ret[index] = d_a[index] + d_b[index];
}