@echo off

SET CONTAINER_EXTN=mpg
:: Recursively search for media containers
for /f "delims=" %%f in ('dir "*.%CONTAINER_EXTN%" /s/b') do @call:thefun "%%f"
goto:eof

:thefun
:: Resolving filenames
SET THE_ORIGINAL_NAME="%~f1"
SET THE_DRIVE_LETTER=%~d1
SET THE_PATH=%~p1
SET THE_FILE=%~n1
SET THE_EXTN=%~x1
SET THE_BACKUP_NAME="%THE_DRIVE_LETTER%%THE_PATH%%THE_FILE%original.%CONTAINER_EXTN%"

:: Backup the original video
move /Y %THE_ORIGINAL_NAME% %THE_BACKUP_NAME%
:: Process with FFMPEG
ffmpeg -y -i %THE_BACKUP_NAME% -c:v copy -c:a copy %THE_ORIGINAL_NAME%
goto:eof

