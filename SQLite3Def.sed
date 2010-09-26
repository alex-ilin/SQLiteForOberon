# This is a SED helper script for creating SQLite3Def definition module.
# This script post-processes SQLite3Def.def created by H2D.
# Copyright (c) Alexander Iljin, 2008.

# remove two first lines containing comments with H2D version and creation time
1,2 d

# insert the ENUMSIZE directive, otherwise invalid code will be generated
3 i\<* ENUMSIZE="4" *>

# set calling convention to StdCall
s/DEFINITION MODULE \["C"\]/DEFINITION MODULE ["StdCall"]/

# remove some ugly prefixes from type and constant names
s/H2D_Ptr/Ptr/g
s/ FI_/ /g

s/PROCEDURE \([a-zA-Z0-9_]\+\)/PROCEDURE FI_\1/

# some points in the header require insertion of additional TYPE or CONST keywords
# for some reason H2D does not handle those places properly
/ BOOL = LONGINT;/ i\TYPE
/ SEEK_SET = / i\CONST
/ RGBA_RED = / i\CONST
/ FIICCPROFILE = RECORD/ i\TYPE
/ BMP_DEFAULT = / i\CONST

# we will use a regular boolean type instead of integer replacement
s/BOOL = LONGINT;/BOOL = SYSTEM.BOOL32;/

# replace some SYSTEM.int parameters with corresponding enums
s/_enum = ($/ = (/

# the following definitions should be removed since they are not used
# most of these are replaced by enums with the same name
/ H2D_Type_LONG = LONGINT;/ d
/ FORMAT = SYSTEM.int;/ d
/ FITYPE = SYSTEM.int;/ d
/ COLOR_TYPE = SYSTEM.int;/ d
/ QUANTIZE = SYSTEM.int;/ d
/ DITHER = SYSTEM.int;/ d
/ JPEG_OPERATION = SYSTEM.int;/ d
/ TMO = SYSTEM.int;/ d
/ FILTER = SYSTEM.int;/ d
/ COLOR_CHANNEL = SYSTEM.int;/ d
/ MDTYPE = SYSTEM.int;/ d
/ MDMODEL = SYSTEM.int;/ d

# FIF_UNKNOWN and FIF_IFF are treated incorrectly by H2D. Here is the fix
/ FORMAT = (/,/);/ {
   /FIF_UNKNOWN/ d
   /FIF_IFF/ d
   # append the following text after the FORMAT type declaration:
   /);/ a\
\
CONST\
  FIF_UNKNOWN = -1;\
  FIF_IFF = FIF_LBM;\
\
TYPE
}

# FIMD_NODATA is treated incorrectly by H2D. Here is the fix
/ MDMODEL = (/,/);/ {
   /FIMD_NODATA/ d
   # append the following text after the MDMODEL type declaration:
   /);/ a\
\
CONST\
  FIMD_NODATA = -1;\
\
TYPE
}

# remove dummy variable added to struct types for differentiation
/[A-Za-z]\+ = RECORD/ {
   N
   s/\([A-Za-z]\+\) = RECORD.* dummy\1[ ]*: SYSTEM.int;/\1 = RECORD/
}

# since all array parameters are actually pointers, allow to pass NIL everywhere
s/VAR \([A-Za-z_]\+\): ARRAY OF/VAR [NIL] \1: ARRAY OF/g

# the FI_SetOutputMessage procedure accepts a procedure as a parameter, and the
# procedure should have the "C" calling convention. This is currently not
# supported by our definition module. We only leave in the
# FI_SetOutputMessageStdCall version that accepts the parameter with
# "StdCall" calling convention
/PROCEDURE FI_SetOutputMessage / d
