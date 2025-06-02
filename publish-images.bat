@echo off
setlocal EnableDelayedExpansion

REM Configurações
set USERNAME=ricardobpaula
set FOLDERS=appserver dbaccess mssql license smartview

REM Verifica versao
if "%1"=="" (
    echo Uso: publish-images.bat ^<versao^> [latest]
    echo Exemplo: publish-images.bat 1.0.0
    echo Exemplo: publish-images.bat 1.0.0 latest
    exit /b 1
)

set VERSION=%1
set PUBLISH_LATEST=N
if /i "%2"=="latest" set PUBLISH_LATEST=S

echo ========================================
echo PUBLICANDO IMAGENS DOCKER - v%VERSION%
if /i "%PUBLISH_LATEST%"=="S" echo [COM LATEST]
echo ========================================

set SUCCESS=0
set TOTAL=0

REM Processa cada pasta
for %%f in (%FOLDERS%) do (
    set /a TOTAL+=1
    set NAME=%%f-dev-protheus
    
    if exist "./%%f" (
        echo.
        echo [%%f] Buildando...
        docker build -t %USERNAME%/!NAME! ./%%f > nul 2>&1
        
        if !errorlevel! equ 0 (
            echo [%%f] Taggeando...
            docker tag %USERNAME%/!NAME! %USERNAME%/!NAME!:%VERSION% > nul 2>&1
            
            echo [%%f] Publicando versao...
            docker push %USERNAME%/!NAME!:%VERSION% > nul 2>&1
            
            if !errorlevel! equ 0 (
                if /i "%PUBLISH_LATEST%"=="S" (
                    echo [%%f] Taggeando latest...
                    docker tag %USERNAME%/!NAME! %USERNAME%/!NAME!:latest > nul 2>&1
                    echo [%%f] Publicando latest...
                    docker push %USERNAME%/!NAME!:latest > nul 2>&1
                )
                
                if !errorlevel! equ 0 (
                    echo [%%f] [OK] SUCESSO
                    set /a SUCCESS+=1
                ) else (
                    echo [%%f] [ERRO] PUSH LATEST FALHOU
                )
            ) else (
                echo [%%f] [ERRO] PUSH FALHOU
            )
        ) else (
            echo [%%f] [ERRO] BUILD FALHOU
        )
    ) else (
        echo [%%f] [ERRO] PASTA NAO ENCONTRADA
    )
)

echo.
echo ========================================
echo RESULTADO: %SUCCESS%/%TOTAL% IMAGENS PUBLICADAS
echo ========================================

if %SUCCESS% equ %TOTAL% (
    echo STATUS: [OK] TODAS AS IMAGENS FORAM PUBLICADAS
    exit /b 0
) else (
    echo STATUS: [ERRO] ALGUMAS IMAGENS FALHARAM
    exit /b 1
)

endlocal 