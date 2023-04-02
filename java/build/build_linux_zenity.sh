#!/bin/bash

if [ "$(basename $(dirname $PWD))/$(basename $PWD)" != "java/build" ]; then
    echo "Must only be run from java/build"
    exit 1
fi

if [ -z "$JAVA_HOME" ]; then
    echo "JAVA_HOME is not set"
    exit 1
fi

if [ ! -d "../dist" ]; then
    mkdir ../dist
fi

arch="x64"

for i in "$@"; do
    case $i in
        --arch=*) arch="${i#*=}" ;;
    esac
done

javac -source 8 -target 8 ../com/jacoco/nfd/NativeFileDialog.java -d ../dist
jar -c -f ../dist/NativeFileDialog.jar -e com.jacoco.nfd.NativeFileDialog -C ../dist com/jacoco/nfd/NativeFileDialog.class

gcc -c -fPIC -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I../../src/include ../com/jacoco/nfd/com_jacoco_nfd_NativeFileDialog.c -o ../dist/com/jacoco/nfd/com_jacoco_nfd_NativeFileDialog.o
gcc -shared -o ../dist/libnfd4j.so ../dist/com/jacoco/nfd/com_jacoco_nfd_NativeFileDialog.o ../../build/lib/Release/${arch}/* 
