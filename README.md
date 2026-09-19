# 1D Life In C for the Tatung Einstein using Z88DK
An implementation of Life in 1D in C for the Tatung Einstein, based on BASIC from Nakazoto (thanks Nakazoto for the video and BASIC, it has reignited my retro programming enthusiasm) - see https://github.com/Nakazoto/CenturionComputer/blob/main/Software/New%20Software/1DLIFE.BAS

This is designed to run under Windows.

To run this program you will need to:-

Install Z88DK and ensure environment variables are set.
Have MAME installed and working.

Have Python installed and working.

Put the file OneDLife.c in a suitable project folder.

Put the build.bat file in the same folder.

Put the BOOT.DSK in the same folder.

Put the Einstein Disc Tools in a folder, either the project folder or a separate folder. einstein_dsk_v1.6.py or higher is required.

Edit the build.bat file to point to your folder structure. By default it assumes:

  The disc tools are in "C:\Einstein\DiscTools"
  
  The project folder is in "C:\z88dk\examples\tatung\OneD"
  
  MAME is in "D:\ES-DE\Emulators\MAME"
  
Run build.bat by double clicking it in file explorer.

This will build the program, create and update the appropriate discs and then launch MAME windowed, rather than full screen.

Windowed mode has been chosen so that it is easier to build / test / close MAME, amend and try again.

