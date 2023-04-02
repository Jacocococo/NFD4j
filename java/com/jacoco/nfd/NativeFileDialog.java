package com.jacoco.nfd;

import java.io.File;

import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;

public class NativeFileDialog {

    public static boolean loadingSucceeded = false;

    static {
        try {
            String lib = System.getProperty("nfd.libPath");
            if (lib == null) {
                String os = System.getProperty("os.name").toLowerCase();
                File libFile = null;
                if (os.contains("linux"))
                    libFile = new File("libnfd4j.so");
                else if (os.contains("windows"))
                    libFile = new File("nfd4j.dll");
                else if (os.contains("mac"))
                    libFile = new File("libnfd4j.dylib");
                lib = libFile.getAbsolutePath();
            }

            System.load(lib);
            loadingSucceeded = true;
        } catch (Throwable ex) {}
    }

    private static native String getFileNative(String defaultPath, String filter);
    private static native String[] getMultipleFilesNative(String defaultPath, String filter);
    private static native String getPathNative(String defaultPath);
    private static native String saveFileNative(String defaultPath, String filter);

    /**
     * Open a dialog where the user can select a single file.
     * @param defaultPath the path that the dialog will open at
     * @param filter a string describing a file format filter. Example "doc,docx;pdf;odf"
     * @return the file selected by the user 
     */
    public static String getFile(String defaultPath, String filter) {
        if (loadingSucceeded == true)
            return getFileNative(defaultPath, filter);

        JFileChooser fileChooser = new JFileChooser(defaultPath);
        fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
        fileChooser.setMultiSelectionEnabled(false);

        if (filter != null) {
            String[] filterSplit = filter.split(";");
            for (String singleFilter : filterSplit) {
                fileChooser.setFileFilter(new FileNameExtensionFilter(singleFilter, singleFilter.split(",")));
            }
        }

        fileChooser.showOpenDialog(null);
        File file = fileChooser.getSelectedFile();
        return (file != null) ? file.getAbsolutePath() : null;
    }

    /**
     * Open a dialog where the user can select multiple files
     * @param defaultPath the path that the dialog will open at
     * @param filter a string describing a file format filter. Example "doc,docx;pdf;odf"
     * @return an array of files selected by the user
     */
    public static String[] getMultipleFiles(String defaultPath, String filter) {
        if (loadingSucceeded == true)
            return getMultipleFilesNative(defaultPath, filter);

        JFileChooser fileChooser = new JFileChooser(defaultPath);
        fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
        fileChooser.setMultiSelectionEnabled(true);

        if (filter != null) {
            String[] filterSplit = filter.split(";");
            for (String singleFilter : filterSplit) {
                fileChooser.setFileFilter(new FileNameExtensionFilter(singleFilter, singleFilter.split(",")));
            }
        }

        fileChooser.showOpenDialog(null);
        File[] files = fileChooser.getSelectedFiles();
        String[] filesStr = new String[files.length];
        for (int i = 0; i < files.length; i++) {
            filesStr[i] = files[i].getAbsolutePath();
        }

        return filesStr;
    }
    
    /**
     * Open a dialog where the user can select a directory
     * @param defaultPath the path that the dialog will open at
     * @return a path to the selected directory
     */
    public static String getPath(String defaultPath) {
        if (loadingSucceeded == true)
            return getPathNative(defaultPath);

        JFileChooser fileChooser = new JFileChooser(defaultPath);
        fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        fileChooser.setMultiSelectionEnabled(false);
        fileChooser.showOpenDialog(null);
        File file = fileChooser.getSelectedFile();
        return (file != null) ? file.getAbsolutePath() : null;
    }

    /**
     * Open a dialog where the user can enter a file name to save to
     * @param defaultPath the path that the dialog will open at
     * @param filter a string describing a file format filter. Example "doc,docx;pdf;odf"
     * @return the path where the user wants to save the file
     */
    public static String saveFile(String defaultPath, String filter) {
        if (loadingSucceeded == true)
            return saveFileNative(defaultPath, filter);

        JFileChooser fileChooser = new JFileChooser(defaultPath);
        if (filter != null) {
            String[] filterSplit = filter.split(";");
            for (String singleFilter : filterSplit) {
                fileChooser.setFileFilter(new FileNameExtensionFilter(singleFilter, singleFilter.split(",")));
            }
        }

        fileChooser.showSaveDialog(null);
        File file = fileChooser.getSelectedFile();
        return (file != null) ? file.getAbsolutePath() : null;
    }
}

