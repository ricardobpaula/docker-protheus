@echo off
setlocal enabledelayedexpansion

set ENV_FILE=.env

echo Verificando arquivo %ENV_FILE%...

if not exist %ENV_FILE% (
    echo Arquivo %ENV_FILE% nao encontrado.
    echo Criando arquivo %ENV_FILE% baseado no example.env...
    
    if exist example.env (
        copy example.env %ENV_FILE%
        echo Arquivo %ENV_FILE% criado com sucesso!
    ) else (
        echo ERRO: Arquivo example.env nao encontrado!
        pause
        exit /b 1
    )
)

echo.
echo Deseja iniciar os containers do Protheus? (S/N)
set /p resposta=

if /i "%resposta%"=="S" (
    echo.
    echo Iniciando containers...
    docker-compose --env-file %ENV_FILE% up -d --build
    echo.
    echo Containers iniciados!
) else (
    echo.
    echo Operacao cancelada pelo usuario.
)

pause
