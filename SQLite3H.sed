# This is a SED helper script for creating SQLite3Def definition module.
# This script prepares SQLite3.h to be passed to H2D.
# Copyright (c) Alexander Iljin, 2010.

# stdarg.h is needed for the definition of va_list, which is used in
# sqlite3_vmprintf. For the time being, I decided to drop the function.
/#include <stdarg.h>/ d
/SQLITE_API char \*sqlite3_vmprintf/ d

# XDS compiler does not support 64-bit integers, so I had to replace those with
# simple arrays.
/#ifdef SQLITE_INT64_TYPE/,/#endif/ d
s/typedef sqlite_int64 sqlite3_int64;/typedef unsigned char sqlite3_int64[8];/
s/typedef sqlite_uint64 sqlite3_uint64;/typedef unsigned char sqlite3_uint64[8];/
