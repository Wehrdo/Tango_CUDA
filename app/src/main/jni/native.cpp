#include "native.h"
#include "nativeCUDA.cuh"
/*
    Place any C++ code you'd like here
*/

float* doAdd(float* a, float* b, int n) {
  return CUDA_addVectors(a, b, n);
}

/*
    Below this are the JNI implementations
*/
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     com_davidawehr_cuda_example_JNINative
 * Method:    addArrays
 * Signature: ([F[F)[F
 */
JNIEXPORT jfloatArray
JNICALL Java_com_davidawehr_cuda_1example_JNINative_addArrays
(JNIEnv * env, jclass clas, jfloatArray j_a, jfloatArray j_b) {
  // Create float arrays from Java arrays
  jfloat* a_ptr = env->GetFloatArrayElements(j_a, 0);
  jfloat* b_ptr = env->GetFloatArrayElements(j_b, 0);
  jint numPts = env->GetArrayLength(j_a);

  float* c_ret = doAdd(a_ptr, b_ptr, numPts);

  // Set Java array location
  jfloatArray j_ret = env->NewFloatArray(numPts);
  env->SetFloatArrayRegion(j_ret, 0, numPts, c_ret);

  return j_ret;
}

#ifdef __cplusplus
}
#endif