@echo off
setlocal enabledelayedexpansion

echo Verificando arquivo .env...

if not exist .env (
    echo Arquivo .env nao encontrado.
    echo Criando arquivo .env baseado no example.env...
    
    if exist example.env (
        copy example.env .env
        echo Arquivo .env criado com sucesso!
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
    docker-compose up -d --build
    echo.
    echo Containers iniciados!
) else (
    echo.
    echo Operacao cancelada pelo usuario.
)

pause
