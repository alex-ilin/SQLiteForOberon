default: SQLite3Def.def SQLite3.lib

.INTERMEDIATE: SQLite3.h SQLite3.edf SQLite3.idf

Src/SQLite3.h Src/SQLite3.dll:
	@echo ***
	@echo  Put SQLite3.h and SQLite3.dll in the Src folder.
	@echo ***

SQLite3.h: Src/SQLite3.h SQLite3H.sed
	copy Src\SQLite3.h .\SQLite3.tmp
	sed -f SQLite3H.sed <SQLite3.tmp >SQLite3.h
	del .\SQLite3.tmp

SQLite3Def.def: SQLite3.h SQLite3.prj SQLite3Def.sed
	h2d =p SQLite3.prj
	sed -f SQLite3Def.sed <SQLite3Def.def >SQLite3Def.tmp
	del .\SQLite3.dir .\SQLite3Def.def
	rename SQLite3Def.tmp SQLite3Def.def

SQLite3.edf: Src/SQLite3.dll
	xlib /edf /nobak SQLite3.edf Src\SQLite3.dll

SQLite3.idf: SQLite3.edf  SQLite3Idf.sed
	sed -f SQLite3Idf.sed <SQLite3.edf >SQLite3.idf

SQLite3.lib: SQLite3.idf
	xlib /implib /nobak SQLite3.lib SQLite3.idf

../def/Amadeus/SQLite3Def.def: SQLite3Def.def
	copy /Y SQLite3Def.def ..\def\Amadeus\SQLite3Def.def

../SQLite3.lib: SQLite3.lib
	copy /Y SQLite3.lib ..\SQLite3.lib

install: ../def/Amadeus/SQLite3Def.def ../SQLite3.lib