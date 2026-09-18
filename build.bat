rem this batch file needs to be run from the folder where the source C file is placed

rem compile program
zcc +cpm -lm -leinstein -o LIFE.COM OneDLife.c  || goto :error

rem C:\Einstein\DiscTools\einstein_dsk_v1.6.py -h

rem create a disc
C:\Einstein\DiscTools\einstein_dsk_v1.6.py create LIFE.DSK || goto :error

rem add the program(s) and any data files etc.
C:\Einstein\DiscTools\einstein_dsk_v1.6.py add LIFE.DSK LIFE.COM || goto :error

rem make the boot disc autoboot the disk we have just created
C:\Einstein\DiscTools\einstein_dsk_v1.6.py add boot.DSK --autorun "1:LIFE" || goto :error

rem boot mame passing in the boot disc to flop 1 and the program disc to flop 2
D:\ES-DE\Emulators\MAME\mame.exe einstein -uimodekey 7_PAD -inipath "D:\ES-DE\Emulators\MAME" -cfg_directory "D:\ES-DE\Emulators\MAME\cfg\einstein\EinTK02\btp" -nowindow -skip_gameinfo -rompath "D:\ES-DE\Roms\einstein\EinTK02" -flop2 "C:\z88dk\examples\tatung\OneD\LIFE.dsk" -flop1 "C:\z88dk\examples\tatung\OneD\boot.dsk" -pipe tk02 -window  || goto :error

goto EOF

:error
timeout /t 30
exit /b %errorlevel%

:EOF