# This is a SED helper script for creating SQLite3Def definition module.
# This script post-processes SQLite3Def.def created by H2D.
# Copyright (c) Alexander Iljin, 2010.

# remove two first lines containing comments with H2D version and creation time
1,2 d

# insert the ENUMSIZE directive, otherwise invalid code will be generated
3 i\<* ENUMSIZE="4" *>

# remove some ugly prefixes from type and constant names
s/H2D_Ptr/Ptr/g

# some points in the header require insertion of additional TYPE or CONST keywords
# for some reason H2D does not handle those places properly
/ SQLITE_OK = 0;/ i\CONST
/ SQLITE_FCNTL_LOCKSTATE = 1;/ i\CONST
/ SQLITE_ACCESS_EXISTS = 0;/ i\CONST
/ SQLITE_CONFIG_SINGLETHREAD = 1;/ i\CONST
/ SQLITE_DENY = 1;/ i\CONST
/ SQLITE_LIMIT_LENGTH = 0;/ i\CONST
/ SQLITE_INTEGER = 1;/ i\CONST
/ SQLITE_UTF8 = 1;/ i\CONST
/ SQLITE_INDEX_CONSTRAINT_EQ = 2;/ i\CONST
/ SQLITE_MUTEX_FAST = 0;/ i\CONST
/ SQLITE_TESTCTRL_FIRST = 5;/ i\CONST
/ SQLITE_STATUS_MEMORY_USED = 0;/ i\CONST
/ SQLITE_DBSTATUS_LOOKASIDE_USED = 0;/ i\CONST
/ SQLITE_STMTSTATUS_FULLSCAN_STEP = 1;/ i\CONST
/ sqlite3_mutex = sqlite3;/ i\TYPE

# since all array parameters are actually pointers, allow to pass NIL everywhere
s/VAR \([A-Za-z_]\+\): ARRAY OF/VAR [NIL] \1: ARRAY OF/g
