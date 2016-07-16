@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------- 
ECHO CHANGE ETHERNET INTERFACE FROM STATIC TO DHCP 
goto inputAdapterName

:inputAdapterName
	echo.
	echo A list of your current network settings will be shown below. 
	echo.
	echo Search for your ethernet adapter's name 
	echo.
	echo E.g. 'Adapter Ethernet Ethernet' or 'Adapter Ethernet Local Area Connection'
	echo.
	pause
	ipconfig
	echo.
	SET /P netName=From the list above...Please input your Ethernet Adapter name: 
	GOTO checkAdapterName

:checkAdapterName
	echo.
	netsh interface ip show address "%netName%" &&  GOTO confirmAdapter 2>nul GOTO inputAdapterName

:confirmAdapter
	echo. 
	SET /P confirm=Is the above adaptor correct[y/n]?
	IF /I {%confirm%}=={y} (
		GOTO success
	)ELSE (
		goto inputAdapterName
	)

:success	
	netsh interface ip set address "%netName%" dhcp && ECHO Success!
	echo.
	ECHO Current configuration...
	echo.
	netsh interface ip show address "%netName%"
	PAUSE 
