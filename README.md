# 1D Life In C for the Tatung Einstein using Z88DK
An implementation of Life in 1D in C for the Tatung Einstein, based on BASIC from Nakazoto (thanks to Nakazoto for the video and BASIC) - see https://github.com/Nakazoto/CenturionComputer/blob/main/Software/New%20Software/1DLIFE.BAS

This is designed to run under Windows.

To run this program you will need to:-

1) Install Z88DK (https://github.com/z88dk/z88dk/wiki) and ensure environment variables are set.
2) Have MAME installed and working, using the Tatung Bytes package (https://www.tatungbytes.co.uk/guides/setting-up-mame-to-emulate-the-tatung-einstein).
3) Have Python installed and working.
4) Put the file OneDLife.c in a suitable project folder.
5) Put the build.bat file in the same folder.
6) Put the BOOT.DSK in the same folder.
7) Put the Einstein Disc Tools (https://www.tatungbytes.co.uk/downloads/einstein-disc-tools) in a folder, either the project folder or a separate folder. 'einstein_dsk_v1.6.py' or higher is required.
8) Edit the build.bat file to point to your folder structure. By default it assumes:

   a) The disc tools are in "C:\Einstein\DiscTools"
   
   b) The project folder is in "C:\z88dk\examples\tatung\OneD"
   
   c) MAME is in "D:\ES-DE\Emulators\MAME"
   
10) Run build.bat by double clicking it in file explorer.

This will build the program, create and update the appropriate discs and then launch MAME windowed, rather than full screen.

Windowed mode has been chosen so that it is easier to build / test / close MAME, amend and try again.


The core of this process is the build.bat file. This contains the following lines:

1) zcc +cpm -lm -leinstein -o LIFE.COM OneDLife.c  || goto :error

This line uses Z88Dk to compile the file OneDLife.c into the program file LIFE.COM and places it in the project folder. If it fails to compile it jumps to the error handling section, reports the error and stop.

2) C:\Einstein\DiscTools\einstein_dsk_v1.6.py create LIFE.DSK || goto :error

This line creates a blank disc called LIFE.DSK. If an error is reported this jumps to the error handler.  

3) C:\Einstein\DiscTools\einstein_dsk_v1.6.py add LIFE.DSK LIFE.COM || goto :error

This line adds the program LIFE.COM to the freshly created disc LIFE.DSK. The process of creating the disc and adding the program can be done in one step but is separated out to make it easier to add multiple files, e.g. if the program relies on separate data files to run.

4) C:\Einstein\DiscTools\einstein_dsk_v1.6.py add boot.DSK --autorun "1:LIFE" || goto :error

This line makes the boot disc for Drive 0 autoboot the program LIFE in Drive 1 to save typing this every time.

5) D:\ES-DE\Emulators\MAME\mame.exe einstein -uimodekey 7_PAD -inipath "D:\ES-DE\Emulators\MAME" -cfg_directory "D:\ES-DE\Emulators\MAME\cfg\einstein\EinTK02\btp" -nowindow -skip_gameinfo -rompath "D:\ES-DE\Roms\einstein\EinTK02" -flop2 "C:\z88dk\examples\tatung\OneD\LIFE.dsk" -flop1 "C:\z88dk\examples\tatung\OneD\boot.dsk" -pipe tk02 -window  || goto :error

This rather complex line boots MAME and tells it which discs to use. It was derived from existing example .bat files present in the MAME setup from TatungBytes (see https://www.tatungbytes.co.uk/guides/setting-up-mame-to-emulate-the-tatung-einstein). 

Each section of this line with a path will need to be amended to fit your folder structure.

This breaks down as:

a) D:\ES-DE\Emulators\MAME\mame.exe einstein -uimodekey 7_PAD -inipath "D:\ES-DE\Emulators\MAME" 

Start MAME and tell it where the inipath is.

b) -cfg_directory "D:\ES-DE\Emulators\MAME\cfg\einstein\EinTK02\btp" -nowindow -skip_gameinfo 

Define configuration directories.

c) -rompath "D:\ES-DE\Roms\einstein\EinTK02" 

Tell it where the Roms are.

d) -flop2 "C:\z88dk\examples\tatung\OneD\LIFE.dsk" 

This is the program file built by the compiler and subsequent disc programs.

e) -flop1 "C:\z88dk\examples\tatung\OneD\boot.dsk" 

This is the boot disc that is required to autoboot LIFE.COM. 

f) -pipe tk02 -window  || goto :error

The '-pipe' is optional - it launches MAME with the 80 column card present. The last part is the error handling code in case it fails to launch.

6) goto EOF

:error

timeout /t 30

exit /b %errorlevel%

:EOF

This is the error handling code for the batch file. Assuming no errors have been reported the line 'goto EOF' jumps to the end of the file so it closes correctly.
If one of the lines triggers an error then a timer is started in order to prevent the window from auto closing and hiding the error. You will get 30 seconds to review the error before the window closes. Pressing a key will close it immediately. Changing /t ## can give you more or less time.

Each line that does anything will raise an error if it fails.

Typical errors:

Compile error - something in the C source file is not right. 

Cannot set '--autorun "1:LIFE"'. Ensure you are using a bootable XTAL DOS master disc. The included disc works.

Can't open MAME due to a file locking issue - this generally happens when MAME is still open.
