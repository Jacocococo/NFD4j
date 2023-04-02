for %%a in (.) do set currentfolder=%%~na
IF NOT %currentfolder%=="build" (
    echo "You must run this from java/build"
    exit /b 1
)

IF "%JAVA_HOME%"=="" (
    echo "JAVA_HOME not found"
    exit /b 1
)

SET ARCH=
SET DEFAULT_ARCH="x64"

IF "%PARAM%" == "--arch" (
    SHIFT
    IF NOT "%ARG%" == "" (
        SET ARCH=%ARG%
        SHIFT
    ) ELSE (
        SET ARCH=%DEFAULT_ARCH%
    )
)

javac -source 8 -target 8 ..\com\jacoco\nfd\NativeFileDialog.java -d ..\dist
jar -c -f ..\dist\NativeFileDialog.jar -e com.jacoco.nfd.NativeFileDialog -C ..\dist com\jacoco\nfd\NativeFileDialog.class

gcc -c -I%JAVA_HOME%\include -I%JAVA_HOME%\include\win32 -I..\..\src\include ..\com\jacoco\nfd\com_jacoco_nfd_NativeFileDialog.c -o ..\dist\com\jacoco\nfd\com_jacoco_nfd_NativeFileDialog.o
gcc -shared -o ..\dist\libnfd4j.so ..\dist\com\jacoco\nfd\com_jacoco_nfd_NativeFileDialog.o ..\..\build\lib\Release\%arch%\* -Wl,--add-stdcall-alias
