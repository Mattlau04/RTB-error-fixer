@echo off
setlocal enabledelayedexpansion
title RTB error fixer by Mattlau04
echo Welcome to the RTB error fixer!
echo.
echo press any key to start the fixing.
pause > NUL
cls
echo checking for python problem...

python --version > NUL
if %ERRORLEVEL% EQU 0 GOTO HASPYTHON
if EXIST "%localappdata%\Programs\Python" goto notinpath
echo You need python 3 for this script to work
echo Please install python 3 (3.x.x) and click add to path during install then re-open this script
echo.
echo press any key to open the RTB wiki page on how to install python and close the script
pause > NUL
echo opening the RTB wiki page on how to install python...
start https://github.com/DeadBread76/Raid-Toolbox/wiki/How-to-install-Python
exit

:notinpath:
echo it look like you have a python folder (%localappdata%\Programs\Python), but python can't be used in the cmd.
echo this is often the result of a python not beeing in path, but it can also rarely be the result of a poor uninstallation
echo the tutorial you will be redirected to take in charge both cases
echo.
echo press any key to open the RTB wiki page on how to add python to path and close the script
pause > NUL
echo opening the RTB wiki page on how to add python to path...
start https://github.com/DeadBread76/Raid-Toolbox/wiki/How-to-add-python-to-path-post-installation
exit

:HASPYTHON
FOR /F "tokens=* USEBACKQ" %%F IN (`python --version`) DO (
SET pythonver=%%F
)
SET pythonver=%pythonver:~7,9%
IF %pythonver:~0,1% EQU 3 goto pipfixing
echo It looks like you aren't using python 3 but another version of python :/
echo please install python 3, add it to path and restart this script

:pipfixing:
echo no problem with python detected!
echo.
echo checking for problem with pip...
pip > NUL
if %errorlevel% EQU 9009 goto nopip
Echo No problem with pip detected!
goto nexttemp

:nopip:
echo It looks like pip is missing
echo Trying to install it automaticly...
timeout /T 1 /NOBREAK
echo Downloading pip...
curl --help > NUL
if NOT %errorlevel% EQU 0 goto nocurl
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
echo installing pip...
python get-pip.py
echo pip is installed!
echo loading next part of the fixing script...
timeout /t 3 > NUL
cls
goto nexttemp

:nocurl:
cls
echo we couldn't download pip automaticly :/
echo press any key to open the RTB wiki page on how to install pip manually and close the script
pause > NUL
echo opening the RTB wiki page on how to install python...
start https://github.com/DeadBread76/Raid-Toolbox/wiki/How-to-install-pip
exit

:nexttemp:
echo.
echo the script is over, if you still have issues, go ask on the server ( discord.gg/7RtuZEe )
echo press any key to exit...
pause > NUL 
exit