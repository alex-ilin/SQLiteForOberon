This folder contains the make script to create files necessary to import
functions from SQLite3.dll. To make use of the scripts, place the following
files in the Src subfolder:
  Src\SQLite3.dll
  Src\SQLite3.h
and run 'make' from the command prompt.

The following tools must be available in the PATH environment variable:
make.exe - GNU Make
sed.exe  - GNU Stream EDitor
xlib.exe - XDS librarian
h2d.exe  - XDS Header to Definition converter

The following files will be created on success:
  SQLite3Def.def
  SQLite3.lib
