@echo off
title Ferramenta Tecnico Windows 2.0
color 0A

:menu
cls
echo ==================================
echo   FERRAMENTA TECNICO WINDOWS 2.0
echo ==================================
echo.
echo 1 - Limpeza Rapida
echo 2 - Limpeza Completa (Admin)
echo 3 - Reparar Windows (Admin)
echo 4 - Limpar Cache de Rede
echo 5 - Informacoes do Computador
echo 6 - Sair
echo.

set /p escolha=Escolha uma opcao:

if "%escolha%"=="1" goto limpeza_rapida
if "%escolha%"=="2" goto limpeza_completa
if "%escolha%"=="3" goto reparo
if "%escolha%"=="4" goto rede
if "%escolha%"=="5" goto info
if "%escolha%"=="6" goto sair

echo Opcao invalida
pause
goto menu

:barra
cls
echo Executando...
echo [##########....................]
timeout /t 1 >nul
cls
echo Executando...
echo [####################..........]
timeout /t 1 >nul
cls
echo Executando...
echo [##############################]
timeout /t 1 >nul
goto :eof

:limpeza_rapida
call :barra
echo Limpando arquivos temporarios...
del /s /f /q %temp%\* >nul 2>&1
echo Limpeza concluida!
pause
goto menu

:limpeza_completa

net session >nul 2>&1
if %errorlevel% neq 0 (
echo.
echo Esta opcao precisa ser executada como Administrador.
pause
goto menu
)

call :barra

echo Limpando TEMP do usuario...
del /s /f /q %temp%\* >nul 2>&1

echo Limpando TEMP do Windows...
del /s /f /q %SYSTEMROOT%\Temp\* >nul 2>&1

echo Limpando Prefetch...
del /s /f /q %SYSTEMROOT%\Prefetch\* >nul 2>&1

echo Limpando logs...
del /s /f /q %SYSTEMROOT%\Logs\* >nul 2>&1

echo Limpando cache do Windows Update...
del /s /f /q %SYSTEMROOT%\SoftwareDistribution\Download\* >nul 2>&1

echo Limpeza completa finalizada!
pause
goto menu

:reparo

net session >nul 2>&1
if %errorlevel% neq 0 (
echo.
echo Esta opcao precisa ser executada como Administrador.
pause
goto menu
)

call :barra

echo Verificando arquivos do sistema...
sfc /scannow

echo Reparando imagem do sistema...
DISM /Online /Cleanup-Image /RestoreHealth

pause
goto menu

:rede
call :barra

echo Limpando cache DNS...
ipconfig /flushdns

echo Resetando rede...
ipconfig /release
ipconfig /renew

echo Rede atualizada!
pause
goto menu

:info
cls
echo ==============================
echo   INFORMACOES DO COMPUTADOR
echo ==============================
echo.

systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
echo.

wmic cpu get name
echo.

wmic memorychip get capacity

echo.
pause
goto menu

:sair
echo.
echo Obrigado por usar a ferramenta!
timeout /t 2 >nul
exit

