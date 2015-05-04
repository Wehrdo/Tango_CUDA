CDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
javah -verbose -o $CDIR/app/src/main/jni/jni_native.h -classpath /home/dawehr/Android/Sdk/platforms/android-19/android.jar:$CDIR/app/build/intermediates/classes/armv7/debug com.davidawehr.cuda_example.JNINative
