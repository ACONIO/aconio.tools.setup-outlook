@echo off
setlocal


set "script_dir=%~dp0"

set "config_file=%script_dir%config.txt"

for /F "tokens=* delims=" %%i in (%config_file%) do (
    set %%i
)

echo %build_number% 
echo %target_user%

:: ===================
:: HKEY_LOCAL_MACHINE
:: ===================
echo Setting ObjectModelGuard in HKEY_LOCAL_MACHINE...

:: Set the ObjectModelGuard registry key in HKEY_LOCAL_MACHINE
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\%build_number%\Outlook\Security" /v "ObjectModelGuard" /t REG_DWORD /d 2 /f

if %errorlevel%==0 (
    echo ObjectModelGuard set successfully in HKEY_LOCAL_MACHINE.
) else (
    echo Failed to set ObjectModelGuard in HKEY_LOCAL_MACHINE.
    echo Exiting...
    pause
    exit /b
)

:: ===================
:: HKEY_CURRENT_USER
:: ===================
echo Setting security policies in HKEY_CURRENT_USER...


:: Get the SID for the target user
for /f "tokens=2 delims==," %%A in ('wmic useraccount where name^="%target_user%" get sid /value') do (
    set "userSID=%%A"
)

:: Verify that the SID was found
if "%userSID%"=="" (
    echo Failed to find SID for user %target_user%.
    echo Exiting...
    pause
    exit /b
)

echo SID for user %target_user% is %userSID%.

:: =============================
:: Create the required registry path if it doesn't exist
:: =============================
reg add "HKEY_USERS\%userSID%\Software\Policies\Microsoft\office\%build_number%\Outlook\Security" /f

:: Set the registry keys for the loaded user's hive
reg add "HKEY_USERS\%userSID%\Software\Policies\Microsoft\office\%build_number%\Outlook\Security" /v "PromptOOMSend" /t REG_DWORD /d 2 /f
reg add "HKEY_USERS\%userSID%\Software\Policies\Microsoft\office\%build_number%\Outlook\Security" /v "AdminSecurityMode" /t REG_DWORD /d 3 /f
reg add "HKEY_USERS\%userSID%\Software\Policies\Microsoft\office\%build_number%\Outlook\Security" /v "promptoomaddressinformationaccess" /t REG_DWORD /d 2 /f
reg add "HKEY_USERS\%userSID%\Software\Policies\Microsoft\office\%build_number%\Outlook\Security" /v "promptoomaddressbookaccess" /t REG_DWORD /d 2 /f

if %errorlevel%==0 (
    echo Registry keys set successfully for %targetUser%.
) else (
    echo Failed to set registry keys for %targetUser%.
)