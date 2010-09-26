# This is a SED helper script. It converts SQLite3 export definition file
# (edf) to SQLite3 import definition file (idf).
# Copyright (c) Alexander Iljin, 2008.

# the list of imported functions must be comma-separated. Luckily, all
# functions except the first one have underscore in front of name, so we put
# comma before that
s/   _/   ,_/

# rename imported functions to shorten the ugly C-style prefix
s/FreeImage_\([a-zA-Z_0-9]*\)\([@0-9]*\)/FreeImage_\1\2 AS FI_\1/

# Replace "LIBRARY Name" with "FROM Name IMPORT"
s/LIBRARY \([a-zA-Z0-9\.]*\)/FROM \1 IMPORT/
# remove EXPORTS keyword
s/EXPORTS//

# delete empty lines (not necessary)
/^$/ d

# append semicolon to the file, thus terminating the function list
$,$ a\;