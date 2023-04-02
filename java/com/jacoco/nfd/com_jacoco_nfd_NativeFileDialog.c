#include "com_jacoco_nfd_NativeFileDialog.h"

#include "nfd.h"

#include <stdlib.h>

JNIEXPORT jstring JNICALL Java_com_jacoco_nfd_NativeFileDialog_getFileNative
  (JNIEnv* env, jclass, jstring jDefaultPath, jstring jFilterList)
{
    const char* defaultPath = (jDefaultPath != NULL) ? (*env)->GetStringUTFChars(env, jDefaultPath, NULL) : "";
    const char* filterList = (jFilterList != NULL) ? (*env)->GetStringUTFChars(env, jFilterList, NULL) : "";

    char* outPath = NULL;
    nfdresult_t result = NFD_OpenDialog(filterList, defaultPath, &outPath);

    jstring output = (*env)->NewStringUTF(env, outPath);
    free(outPath);
    return output;
}

JNIEXPORT jobjectArray JNICALL Java_com_jacoco_nfd_NativeFileDialog_getMultipleFilesNative
  (JNIEnv* env, jclass, jstring jDefaultPath, jstring jFilterList)
{
    const char* defaultPath = (jDefaultPath != NULL) ? (*env)->GetStringUTFChars(env, jDefaultPath, NULL) : "";
    const char* filterList = (jFilterList != NULL) ? (*env)->GetStringUTFChars(env, jFilterList, NULL) : "";

    nfdpathset_t pathSet;
    nfdresult_t result = NFD_OpenDialogMultiple(filterList, defaultPath, &pathSet);

    const jclass stringClass = (*env)->FindClass(env, "java/lang/String");
    if (result == NFD_OKAY) {
        const size_t count = NFD_PathSet_GetCount(&pathSet);
        jobjectArray output = (jobjectArray) (*env)->NewObjectArray(env, count, stringClass, (*env)->NewStringUTF(env, ""));

        for (int i = 0; i < count; i++) {
            nfdchar_t* path = NFD_PathSet_GetPath(&pathSet, i);
            (*env)->SetObjectArrayElement(env, output, i, (*env)->NewStringUTF(env, path));
        }

        return output;
    } else {
        jobjectArray output = (jobjectArray) (*env)->NewObjectArray(env, 0, stringClass, (*env)->NewStringUTF(env, ""));
        return output;
    }
}

JNIEXPORT jstring JNICALL Java_com_jacoco_nfd_NativeFileDialog_getPathNative
  (JNIEnv* env, jclass, jstring jDefaultPath)
{
    const char* defaultPath = (jDefaultPath != NULL) ? (*env)->GetStringUTFChars(env, jDefaultPath, NULL) : "";

    char* outPath = NULL;
    nfdresult_t result = NFD_PickFolder(defaultPath, &outPath);

    jstring output = (*env)->NewStringUTF(env, outPath);
    free(outPath);
    return output;
}

JNIEXPORT jstring JNICALL Java_com_jacoco_nfd_NativeFileDialog_saveFileNative
  (JNIEnv* env, jclass, jstring jDefaultPath, jstring jFilterList)
{
    const char* defaultPath = (jDefaultPath != NULL) ? (*env)->GetStringUTFChars(env, jDefaultPath, NULL) : "";
    const char* filterList = (jFilterList != NULL) ? (*env)->GetStringUTFChars(env, jFilterList, NULL) : "";

    char* outPath = NULL;
    nfdresult_t result = NFD_SaveDialog(filterList, defaultPath, &outPath);

    jstring output = (*env)->NewStringUTF(env, outPath);
    free(outPath);
    return output;
}

