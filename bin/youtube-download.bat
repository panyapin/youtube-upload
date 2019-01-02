@setlocal enableextensions enabledelayedexpansion
@echo off
set id=%1
echo.
set cmd="youtube-dl -f 299 %%id%% -o %%(title)s.%%(ext)s %%id%%"
rem set "fname=%%(title)"
for /f "tokens=*" %%i IN (' %cmd% ^| findstr .mp4') DO (
	SET "X=%%i"
	goto :next
)
:next
rem ^| findstr .mp4
set "X=%X:~24,1000%"
youtube-dl --extract-audio --audio-format "aac" --audio-quality 0 %id% --youtube-skip-dash-manifest -o %%(title)s.aac
set "fname=%X:~0,-4%"
ffmpeg -i "%X%" -i "%fname%.aac" -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -y "%fname%.flv"
echo.