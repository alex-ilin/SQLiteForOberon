# This is a SED helper script. It converts SQLite3 export definition file
# (edf) to SQLite3 import definition file (idf).
# Copyright (c) Alexander Iljin, 2010.

# the list of imported functions must be comma-separated. Luckily, all
# functions have the same prefix, so we put comma before that. We start with
# the 6th line, which is the line with the second function name.
6,$ s/   sqlite3_/,  sqlite3_/

# Replace "LIBRARY Name" with "FROM Name IMPORT"
s/LIBRARY \([a-zA-Z0-9\.]*\)/FROM \1 IMPORT/
# remove EXPORTS keyword
s/EXPORTS//

# delete empty lines (not necessary)
/^$/ d

# append semicolon to the file, thus terminating the function list
$,$ a\;