@ECHO OFF  
  

cd %~dp0  
  

whoami /PRIV | FIND "SeLoadDriverPrivilege" > NUL  
IF not errorlevel 1 GOTO START  
  
powershell.exe -Command Start-Process "setup.bat" -Verb Runas  
exit  
  
:START  
  


net stop MSSQL$SQLEXPRESS  
net stop MSSQLFDLauncher$SQLEXPRESS  
net stop SQLBrowser  
net stop SQLTELEMETRY$SQLEXPRESS  
net stop ReportServer$SQLEXPRESS  
net stop SQLWriter  
net stop SQLAgent$SQLEXPRESS  

SET SQLSERVER_UNINSTALL_FILE=.\setup.ps1  
  
for /L %%i in (1,1,3) do (  
powershell -ExecutionPolicy Bypass -NoLogo %SQLSERVER_UNINSTALL_FILE%  
)  
  
 
if exist "%windir%\assembly\GAC\*SQLServer*" del /s /q /f "%windir%\assembly\GAC\*SQLServer*"   
if exist "%windir%\assembly\GAC_32\*SQLServer*" del /s /q /f "%windir%\assembly\GAC_32\*SQLServer*"   
if exist "%windir%\assembly\GAC_64\*SQLServer*" del /s /q /f "%windir%\assembly\GAC_64\*SQLServer*"   
if exist "%windir%\assembly\GAC_MSIL\*SQLServer*" del /s /q /f "%windir%\assembly\GAC_MSIL\*SQLServer*"   
  

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server" /f  
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server 2016 Redist" /f  
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server" /f  
  

if exist "%USERPROFILE%\Local Settings\Application Data\Microsoft\Microsoft SQL Server" rmdir /S /Q "%USERPROFILE%\Local Settings\Application Data\Microsoft\Microsoft SQL Server"   
if exist "%USERPROFILE%\Application Data\Microsoft\Microsoft SQL Server" rmdir /S /Q "%USERPROFILE%\Application Data\Microsoft\Microsoft SQL Server"   
if exist "%USERPROFILE%\All Users\Application Data\Microsoft\Microsoft SQL Server" rmdir /S /Q "%USERPROFILE%\All Users\Application Data\Microsoft\Microsoft SQL Server"   
if exist "%ProgramFiles%\Microsoft SQL Server" rmdir /S /Q "%ProgramFiles%\Microsoft SQL Server"   
if exist "%ProgramFiles(x86)%\Microsoft SQL Server" rmdir /S /Q "%ProgramFiles(x86)%\Microsoft SQL Server"   
  

cd %TEMP%  
del *.* /S /Q  
cd %systemroot%\temp  
del *.* /S /Q  
  

pause  
