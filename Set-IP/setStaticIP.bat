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
ECHO SET STATIC IP ADDRESS FOR ETHERNET INTERFACE
set filepath=%HOMEPATH%\Desktop\oldConfigEthernet.txt
set ip=192.168.99.20
set nm=255.255.255.0
set gw=192.168.99.1
GOTO inputAdapterName

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
		GOTO printVar
	)ELSE (
		goto inputAdapterName
	) 
	
	:confirmAction
	SET /P question=Do you want to use the above configuration[y/n]?
	IF /I {%question%}=={y} GOTO changeStatic
	IF /I {%question%}=={n} (
		GOTO setStatic
	)ELSE (
		echo.
		echo %question% is not a valide option.
		echo.
		goto confirmAction
	)
:printVar
	echo.
	echo Default static parameters: 
	echo.
	echo         IP=%ip%
	echo SubnetMask=%nm%
	echo    Gateway=%gw%
	echo.
	GOTO confirmAction

	
:setStatic
	echo.
	set /P ip="Enter IP: "
	set /P nm="Enter SubnetMask: "
	set /P gw="Enter Gateway: "
	echo.
	goto confirmAction

:changeStatic
	echo.
	netsh interface ip show address "%netName%" > %filepath%
	netsh interface ip set address "%netName%" static %ip% %nm% %gw% && ECHO Success...Saved old configuration files on %filepath% 2> echo Error while setting static IP

PAUSE 
