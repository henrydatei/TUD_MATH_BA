@ECHO OFF

REM Testdatei zum Loeschen nicht benoetigter TeX-Dateien

ECHO ====================================================
ECHO Es werden alle Dateien mit den Endungen
ECHO      *.aux  *.log  *.out  *.synctex.gz  *.thm  *.idx  *.toc
ECHO geloescht.
ECHO ====================================================
ECHO.

REM zweite zeile ueberprueft auf (nicht)existenz von uebergabeparameter und fordert eingabe
REM dritte zeile ueberprueft auf existenz des uebergebenen verzeichnisses
REM
ECHO Geben Sie das zu untersuchende Verzeichnis ein:
IF [%1]==[] SET /p EIN="" & ECHO ...fertig.
IF EXIST %1 SET "EIN=%~1" & ECHO ...fertig.
IF NOT EXIST "%EIN%" ECHO. & ECHO ACHTUNG : Verzeichnis nicht vorhanden. & COLOR 4F & GOTO EOF

ECHO.
ECHO -------------------------------------
ECHO.

ECHO Loeschvorgang starten ...
DEL /F /Q /S "%EIN%\*.aux" 2>NUL
DEL /F /Q /S "%EIN%\*.log" 2>NUL
DEL /F /Q /S "%EIN%\*.out" 2>NUL
DEL /F /Q /S "%EIN%\*.synctex.gz" 2>NUL
DEL /F /Q /S "%EIN%\*.thm" 2>NUL
DEL /F /Q /S "%EIN%\*.idx" 2>NUL
DEL /F /Q /S "%EIN%\*.toc" 2>NUL
DEL /F /Q /S "%EIN%\*.snm" 2>NUL
DEL /F /Q /S "%EIN%\*.nav" 2>NUL
DEL /F /Q /S "%EIN%\*.bbg" 2>NUL
DEL /F /Q /S "%EIN%\*.bbl" 2>NUL
ECHO ... fertig.
ECHO.

ECHO -------------------------------------

COLOR 2F

:EOF
ECHO.
ECHO Um das Programm zu beenden, druecken Sie eine beliebige Taste.
PAUSE >NUL
COLOR 0F
