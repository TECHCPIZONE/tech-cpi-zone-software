@echo off
setlocal EnableExtensions

title TECH CPI ZONE - Automatic Installer

echo ==========================================
echo     TECH CPI ZONE - Automatic Installer
echo ==========================================
echo.

set "ZIP_FILE=C:\Users\Administrator\Downloads\TCZ_1.1.0.zip"
set "EXTRACT_DIR=C:\Users\Administrator\Downloads\TCZ_1.1.0"
set "EXE_FILE=%EXTRACT_DIR%\TCZ_1.1.0\dist\TECH CPI ZONE Setup 1.1.0.exe"

echo [1/3] Checking ZIP file...
echo.

if not exist "%ZIP_FILE%" (
    echo ERROR: ZIP file not found!
    echo.
    echo %ZIP_FILE%
    echo.
    pause
    exit /b 1
)

echo ZIP file found.
echo.

echo [2/3] Extracting TCZ 1.1.0...
echo.

if exist "%EXTRACT_DIR%" (
    rmdir /s /q "%EXTRACT_DIR%"
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
"$ErrorActionPreference='Stop'; try { Expand-Archive -LiteralPath '%ZIP_FILE%' -DestinationPath '%EXTRACT_DIR%' -Force; exit 0 } catch { Write-Host $_.Exception.Message; exit 1 }"

if errorlevel 1 (
    echo.
    echo ERROR: Extraction failed!
    echo.
    pause
    exit /b 1
)

echo Extraction completed.
echo.

echo [3/3] Starting TECH CPI ZONE Setup...
echo.

if not exist "%EXE_FILE%" (
    echo ERROR: Setup EXE not found!
    echo.
    echo Expected:
    echo %EXE_FILE%
    echo.
    pause
    exit /b 1
)

echo Setup found:
echo %EXE_FILE%
echo.

start "" "%EXE_FILE%"

if errorlevel 1 (
    echo.
    echo ERROR: Could not start Setup EXE.
    echo.
    pause
    exit /b 1
)

echo.
echo TECH CPI ZONE Setup started successfully.
echo.

echo Cleaning up downloaded ZIP...
del /f /q "%ZIP_FILE%" >nul 2>&1

if exist "%ZIP_FILE%" (
    echo WARNING: ZIP could not be deleted.
) else (
    echo ZIP deleted successfully.
)

echo.
echo ==========================================
echo        SETUP STARTED SUCCESSFULLY
echo ==========================================
echo.

pause
exit /b 0
