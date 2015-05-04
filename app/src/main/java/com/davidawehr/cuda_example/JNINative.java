package com.davidawehr.cuda_example;


public class JNINative {
    static {
        System.loadLibrary("gnustl_shared");
        System.loadLibrary("cuda_jni_example");
    }

    public static native float[] addArrays(float[] a, float[] b);
}
