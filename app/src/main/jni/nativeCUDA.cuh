#ifdef __CUDACC__
#define LOG_TAG "tango_jni"
#ifndef LOGI
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#endif
#endif

#define TPB 512


void launchAddKernel(float* d_a, float* d_b, float* d_ret);

float* CUDA_addVectors(float* a, float* b, int n);