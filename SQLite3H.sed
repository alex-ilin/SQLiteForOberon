# This is a SED helper script for creating SQLite3Def definition module.
# This script prepares SQLite3.h to be passed to H2D.
# Copyright (c) Alexander Iljin, 2008.

# remove some calling convention specifications that H2D can't stomach
s/DLL_CALLCONV //
s/DLL_API //

# remove the ugly C-style prefixes
s/FreeImage_//g
s/FREE_IMAGE_TYPE/FITYPE/g
s/FREE_IMAGE_//g
s/FREEIMAGE_//g
# note that FREE_IMAGE_TYPE is now known as FITYPE. We can't simply
# call it TYPE, because it is a reserved word in Modula and Oberon

# remove some conditional compilation sections that get in our way
/#if defined(FREEIMAGE_LIB)/,/#endif \/\/ FREEIMAGE_LIB/ d
/#ifndef FALSE/,/#endif/ d
/#ifndef TRUE/,/#endif/ d
/#ifndef NULL/,/#endif/ d

# when H2D sees two typedefs making "struct { void *data }" it assumes that
# those are just aliases for the same type, cf. "Type synonyms" topic in
# h2d.hlp. I found no way to turn off this behaviour. FreeImage uses several
# distinct types, which are declared the same way. All of those types will
# become synonyms for FIBITMAP, unless special measures are taken. The bad
# thing is all procedures will accept FIBITMAP parameters, neglecting type
# differentiation and provoking programming mistakes. Here is the workaround
# I came up with: add a dummy variable with unique name to every such type,
# and remove it when H2D has finished its work
s/FI_STRUCT[ ]*(\([A-Za-z]\+\))[ ]*{/FI_STRUCT (\1) { int dummy\1; /

# wchar_t type is imported from <wchar.h> to support unicode version of some
# functions. XDS does not support multibyte characters, so we replace it with WORD
/#include <wchar.h>/ d
s/wchar_t/WORD/g