@echo off
title Ferramenta de Manutencao do Sistema
color 0A

:menu
cls
echo ================================
echo   FERRAMENTA DE MANUTENCAO
echo ================================
echo.
echo 1 - Limpeza Rapida
echo 2 - Limpeza Completa
echo 3 - Reparo do Sistema
echo 4 - Limpar Cache de Rede
echo 5 - Finalizar
echo.
set /p escolha=Escolha uma opcao:

if %escolha%==1 goto limpeza_rapida
if %escolha%==2 goto limpeza_completa
if %escolha%==3 goto reparo
if %escolha%==4 goto rede
if %escolha%==5 goto finalizar

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
echo Limpando TEMP...
del /s /f /q %temp%\*
echo Limpeza concluida!
pause
goto menu

:limpeza_completa
call :barra
echo Limpando TEMP do usuario...
del /s /f /q %temp%\*

echo Limpando TEMP do Windows...
del /s /f /q C:\Windows\Temp\*

echo Limpando Prefetch...
del /s /f /q C:\Windows\Prefetch\*

echo Limpando logs...
del /s /f /q C:\Windows\Logs\*

echo Limpeza completa finalizada!
pause
goto menu

:reparo
call :barra
echo Verificando arquivos do sistema...
sfc /scannow

echo Reparando imagem do sistema...
DISM /Online /Cleanup-Image /RestoreHealth

pause
goto menu

:rede
call :barra
echo Limpando cache de rede...
ipconfig /flushdns
echo Cache limpo!
pause
goto menu

:finalizar
cls
echo ================================
echo     MANUTENCAO FINALIZADA
echo ================================
echo Obrigado por utilizar a ferramenta!
pause
exit 
