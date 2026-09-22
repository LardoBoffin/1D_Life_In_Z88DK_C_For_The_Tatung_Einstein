rem this batch file needs to be run from the folder where the source C file is placed

rem set some base file paths
SET "SOURCE_DIR=C:\z88dk\examples\tatung\OneD"
SET "MAME=C:\MAME\ES-DE\Emulators\MAME"
SET "ROMS=C:\MAME\ES-DE\Roms\einstein\EinTK02"
SET "DISCTOOLS=C:\Einstein\DiscTools"

rem compile program
zcc +cpm -lm -leinstein -o LIFE.COM OneDLife.c  || goto :error

rem C:\Einstein\DiscTools\einstein_dsk_v1.6.py -h

rem create a disc
%DISCTOOLS%\einstein_dsk_v1.6.py create LIFE.DSK || goto :error

rem add the program(s) and any data files etc.
%DISCTOOLS%\einstein_dsk_v1.6.py add LIFE.DSK LIFE.COM || goto :error

rem make the boot disc autoboot the disk we have just created
%DISCTOOLS%\einstein_dsk_v1.6.py add boot.DSK --autorun "1:LIFE" || goto :error

rem boot mame passing in the boot disc to flop 1 and the program disc to flop 2
%MAME%\mame.exe einstein -uimodekey 7_PAD -inipath "%MAME%" -cfg_directory "%MAME%\cfg\einstein\EinTK02\btp" -nowindow -skip_gameinfo -rompath "%ROMS%" -flop2 "%SOURCE_DIR%\LIFE.dsk" -flop1 "%SOURCE_DIR%\boot.dsk" -pipe tk02 -window  || goto :error

goto EOF

:error
timeout /t 30
exit /b %errorlevel%

:EOF
