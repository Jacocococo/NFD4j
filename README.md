# Native File Dialog For Java

A fork of [mlabbe/nativefiledialog](<https://github.com/mlabbe/nativefiledialog>) that adds JNI bindings for Java. When prompted to choose a file, the library will try to load the platform's native file dialog, but if the native shared object file fails to load, it will fall back to a JFileChooser.

*Note: This has currently only been tested with the standard Linux build on x64, but it will hopefully work on other platforms as well.*

# Example Usage

```java
import com.jacoco.nfd.NativeFileDialog;

...

// Get a single file
String file = NativeFileDialog.getFile("/home/user/Documents", "pdf");

// Let the user select multiple files
String[] files = NativeFileDialog.getMultipleFiles(null, null);

// Select a directory
String directory = NativeFileDialog.getPath("/home/user/Pictures");

// Save a file
String file = NativeFileDialog.saveFile(null, "doc,docx;odf;pdf");
```

Java-docs are included in [NativeFileDialog.java](java/com/jacoco/nfd/NativeFileDialog.java)

# Overriding Shared Object Path

The library will automatically search for a shared object file that matches the OS in the current directory. This can be overridden by setting the System property `nfd.libPath` before the first time NativeFileDialog is accessed.

Example:

```java
// Setting the property to usr lib directory
System.setProperty("nfd.libPath", "/usr/lib/libnfd4j.so");
```

The library is read when anything in the NativeFileDialog class is first initialized. Therefore the following will not work, as the library has already been read when the property is set.

```java
NativeFileDialog.getFile("", "");
// Will NOT work
System.setProperty("nfd.libPath", "/usr/lib/libnfd4j.so");
```

# Screenshots from upstream

![Windows rendering a dialog](screens/open_win.png?raw=true)
![GTK3 on Linux rendering a dialog](screens/open_gtk3.png?raw=true)
![Cocoa on MacOS rendering a dialog](screens/open_cocoa.png?raw=true)

## Building

This project uses GCC and Javac for building.

To build it, you first need to enter `build/gmake2_<platform>`  and run make from there. For more instructions, refer to [Upstream](<https://github.com/mlabbe/nativefiledialog/blob/master/README.md#building>). While upstream supports other compilers, the following build scripts only work with GCC.

After building the static library from upstream, enter `java/build` and run the build script that matches your platform. You can use `--arch="<build_architecture>"`  on Linux and Mac or `--arch "<build_architecture>"`  on Windows to select an architecture other than the default (which is x64 on Linux and Windows, and ARM64 on Mac).

*Note: The only build script that has been tested is `build_linux.sh`  on the x64 architecture. Other build scripts are not guaranteed to work but will hopefully at least act as a guide. If you manage to build the shared object on another platform, please let me know so I can update this repository.*

## File Filter Syntax

There is a form of file filtering in every file dialog API, but no consistent means of supporting it.  NFD provides support for filtering files by groups of extensions, providing its own descriptions (where applicable) for the extensions.

A wildcard filter is always added to every dialog.

### Separators

* `;` Begin a new filter.
* `,` Add a separate type to the filter.

#### Examples

`txt` The default filter is for text files.  There is a wildcard option in a dropdown.

`png,jpg;psd` The default filter is for png and jpg files.  A second filter is available for psd files.  There is a wildcard option in a dropdown.

`null` Only the wildcard option is shown.

# Original Copyright Notice and Credits

Copyright © 2014-2019 [Frogtoss Games](http://www.frogtoss.com), Inc. File [LICENSE](LICENSE) covers all files in this repo.

Native File Dialog by Michael Labbe
[mike@frogtoss.com](mailto:mike@frogtoss.com)

Tomasz Konojacki for [microutf8](http://puszcza.gnu.org.ua/software/microutf8/)

[Denis Kolodin](https://github.com/DenisKolodin) for mingw support.

[Tom Mason](https://github.com/wheybags) for Zenity support.
