@echo off
setlocal

REM Usage: build.bat [debug]

REM Ensure runtime deps are installed
echo Installing/validating Python dependencies...
pip install -r requirements.txt || goto :error

REM Install pyinstaller if not present
where pyinstaller >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing pyinstaller...
    pip install pyinstaller || goto :error
)

REM Qt WebEngine often needs these flags in packaged apps
set QTWEBENGINE_DISABLE_SANDBOX=1
set QTWEBENGINE_CHROMIUM_FLAGS=--no-sandbox

set NAME=Alt App Installer CN
set ICON=app\data\images\main.ico
set DATAS=--add-data "app\data\images;app\data\images" --add-data "app\data\xml;app\data\xml"
set HIDDEN=--hidden-import PyQt6 --hidden-import PyQt6.QtWebEngineWidgets --hidden-import PyQt6.QtWebEngineCore
set COLLECT=--collect-all PyQt6 --collect-all PyQt6.QtWebEngineWidgets --collect-submodules PyQt6.QtWebEngineCore

if /I "%1"=="debug" (
    echo Building DEBUG version...
    pyinstaller --noconfirm --clean --log-level DEBUG --noupx --console --debug=all ^
      --name "%NAME%" ^
      --icon "%ICON%" ^
      %DATAS% ^
      %HIDDEN% ^
      %COLLECT% ^
      app\main.py || goto :error
) else (
    echo Building RELEASE version...
    pyinstaller --noconfirm --clean --noupx --console ^
      --name "%NAME%" ^
      --icon "%ICON%" ^
      %DATAS% ^
      %HIDDEN% ^
      %COLLECT% ^
      app\main.py || goto :error
)

echo.
echo Build completed. See the dist folder.
goto :eof

:error
echo.
echo Build failed.
exit /b 1


