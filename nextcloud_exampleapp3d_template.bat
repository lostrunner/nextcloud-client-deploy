setlocal EnableDelayedExpansion
msg * Nextcloud installation begins. After the process is complete a new message will appear with new info.
taskkill -im nextcloud /f
set "url=https://download.nextcloud.com/desktop/releases/Windows/"
set "extension=.msi"
for /f "delims=" %%a in ('curl -s %url% ^| findstr /i %extension% ^| sort /r') do set "latest=%%a" & goto download
:download
set "cloudfile=!latest:*href=!"
set "cloudfile=!cloudfile:*>=!"
for /F "tokens=1 delims=<" %%a in ("%cloudfile%") do set "filename=%%a"
curl -O "%url%%filename%"
msiexec.exe /i "%filename%" ALLUSERS=1 /qn /norestart 
:deleteExe  
del /f "%filename%"  
if exist "%filename%" goto deleteExe
:customise
cd "%systemdrive%\Users\"
curl -O https://cloud.exampledomain.com/index.php/s/RANDOMG8P6NjB8l/download
for /d %%a in (%systemdrive%\Users\*) do (
	set "username=%%~nxa"
    if /I not "!username!"=="Administrator" if /I not "!username!"=="localadmin" if /I not "!username!"=="Public" (
        mkdir %%a\AppData\Roaming\Nextcloud
		mkdir %%a\sampleapp3D
		tar -xf %systemdrive%\Users\download -C %%a
		del "%%a\Desktop\sampleapp3D.lnk" 
		mklink "%%a\Desktop\sampleapp3D.lnk" "%%a\sampleapp3D\sampleapp3D.exe"
			for /d %%b in (%%a\AppData\Roaming\Nextcloud) do (
				if exist "%%b\nextcloud.cfg" (echo f | xcopy "%%b\nextcloud.cfg" "%%b\nextcloud.cfg.bak" /y /f)
				del /f "%%b\nextcloud.cfg"
				if not exist "%%b\nextcloud.cfg" (
					echo [Accounts] >> "%%b\nextcloud.cfg"
					echo version=2 >> "%%b\nextcloud.cfg"
					echo 0\version=1 >>"%%b\nextcloud.cfg"	
					echo 0\url=https://cloud.exampledomain.com >> "%%b\nextcloud.cfg"
					echo 0\authType=webflow >> "%%b\nextcloud.cfg"
					for /f "tokens=3 delims=\" %%c in ('echo %%a') do (
						echo 0\webflow_user=%%c >> "%%b\nextcloud.cfg"
						echo 0\Folders\1\localPath=C:/Users/%%c/sampleapp3D/ >> "%%b\nextcloud.cfg"
					)				
					echo 0\Folders\1\targetPath=/sampleapp3D >> "%%b\nextcloud.cfg"
					echo 0\Folders\1\paused=false >> "%%b\nextcloud.cfg"
					echo 0\Folders\1\ignoreHiddenFiles=false >> "%%b\nextcloud.cfg"
					echo 0\Folders\1\virtualFilesMode=off >> "%%b\nextcloud.cfg"
					echo 0\Folders\1\version=2 >> "%%b\nextcloud.cfg"
				)
			)
        )
    )
:deldownload
del /f "%systemdrive%\Users\download"  
if exist "%systemdrive%\Users\download" goto deldownload
msg * Instalation complete. Content was downloaded. You need to finish login to nextcloud by opening the app, pressing the login button and finishing the web process. Then close and reopen nextloud for the config to be loaded.