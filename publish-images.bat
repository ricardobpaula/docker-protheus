@echo off
setlocal EnableDelayedExpansion

REM Configurações
set USERNAME=ricardobpaula
set CONTAINER_FOLDERS=appserver dbaccess mssql license smartview

REM Verifica se os parâmetros foram fornecidos
if "%1"=="" (
    echo Erro: Versão não fornecida!
    echo Uso: publish-images.bat ^<versao^> ^<latest^>
    echo Exemplo: publish-images.bat 1.0.0 S  ^(para gerar latest^)
    echo Exemplo: publish-images.bat 1.0.0 N  ^(para não gerar latest^)
    exit /b 1
)

if "%2"=="" (
    echo Erro: Opção de latest não fornecida!
    echo Uso: publish-images.bat ^<versao^> ^<latest^>
    echo Exemplo: publish-images.bat 1.0.0 S  ^(para gerar latest^)
    echo Exemplo: publish-images.bat 1.0.0 N  ^(para não gerar latest^)
    exit /b 1
)

set VERSION=%1
set RELEASE_CHOICE=%2

REM Limpa espaços e valida a opção
set "RELEASE_CHOICE=!RELEASE_CHOICE: =!"
if /i not "!RELEASE_CHOICE!"=="S" if /i not "!RELEASE_CHOICE!"=="N" (
    echo Erro: Opção de latest inválida! Use S ou N.
    echo Uso: publish-images.bat ^<versao^> ^<latest^>
    echo Exemplo: publish-images.bat 1.0.0 S  ^(para gerar latest^)
    echo Exemplo: publish-images.bat 1.0.0 N  ^(para não gerar latest^)
    exit /b 1
)

echo ====================================
echo INICIANDO BUILD E PUBLICACAO DOCKER
echo ====================================
echo Username: %USERNAME%
echo Versão: %VERSION%
echo Gerar Latest: !RELEASE_CHOICE!
echo Pastas: %CONTAINER_FOLDERS%
echo ====================================

REM Contador de sucessos e falhas
set SUCCESS_COUNT=0
set TOTAL_COUNT=0

REM Loop através de cada pasta
for %%f in (%CONTAINER_FOLDERS%) do (
    set /a TOTAL_COUNT+=1
    set CONTAINER_NAME=%%f-dev-protheus
    set CONTAINER_FOLDER=./%%f
    
    echo.
    echo ########################################
    echo PROCESSANDO: %%f
    echo Container: !CONTAINER_NAME!
    echo Pasta: !CONTAINER_FOLDER!
    echo ########################################
    
    REM Verifica se a pasta existe
    if not exist "!CONTAINER_FOLDER!" (
        echo AVISO: Pasta !CONTAINER_FOLDER! não encontrada. Pulando...
        continue
    )
    
    REM 1. Criar build
    echo.
    echo [1/3] Criando build da imagem !CONTAINER_NAME!...
    docker build -t %USERNAME%/!CONTAINER_NAME! !CONTAINER_FOLDER!
    if !errorlevel! neq 0 (
        echo ERRO: Falha no build da imagem !CONTAINER_NAME!!
        continue
    )
    echo Build de !CONTAINER_NAME! concluído com sucesso!
    
    REM 2. Criar tag
    echo.
    echo [2/3] Criando tag da imagem !CONTAINER_NAME!...
    docker image tag %USERNAME%/!CONTAINER_NAME! %USERNAME%/!CONTAINER_NAME!:%VERSION%
    if !errorlevel! neq 0 (
        echo ERRO: Falha ao criar tag da imagem !CONTAINER_NAME!!
        continue
    )
    echo Tag de !CONTAINER_NAME! criada com sucesso!
    
    REM 3. Publicar
    echo.
    echo [3/3] Publicando imagem !CONTAINER_NAME!...
    docker push %USERNAME%/!CONTAINER_NAME!:%VERSION%
    if !errorlevel! neq 0 (
        echo ERRO: Falha ao publicar imagem !CONTAINER_NAME!!
        continue
    )
    echo Imagem !CONTAINER_NAME! publicada com sucesso!
    
    set /a SUCCESS_COUNT+=1
    echo ✓ !CONTAINER_NAME! processado com sucesso!
)

echo.
echo ====================================
echo RESUMO DA EXECUÇÃO
echo ====================================
echo Total de containers: %TOTAL_COUNT%
echo Sucessos: %SUCCESS_COUNT%
set /a FAILED_COUNT=%TOTAL_COUNT%-%SUCCESS_COUNT%
echo Falhas: %FAILED_COUNT%
echo ====================================

if %SUCCESS_COUNT% gtr 0 (
    echo.
    echo Imagens criadas com sucesso:
    for %%f in (%CONTAINER_FOLDERS%) do (
        if exist "./%%f" (
            echo - %USERNAME%/%%f-dev-protheus:%VERSION%
        )
    )
    
    if /i "!RELEASE_CHOICE!"=="S" (
        echo.
        echo ====================================
        echo PUBLICANDO COMO RELEASE (latest)
        echo ====================================
        
        for %%f in (%CONTAINER_FOLDERS%) do (
            if exist "./%%f" (
                set CONTAINER_NAME=%%f-dev-protheus
                echo.
                echo Criando tag latest para !CONTAINER_NAME!...
                docker image tag %USERNAME%/!CONTAINER_NAME!:%VERSION% %USERNAME%/!CONTAINER_NAME!:latest
                if !errorlevel! equ 0 (
                    echo Publicando !CONTAINER_NAME!:latest...
                    docker push %USERNAME%/!CONTAINER_NAME!:latest
                    if !errorlevel! equ 0 (
                        echo ✓ !CONTAINER_NAME!:latest publicado com sucesso!
                    ) else (
                        echo ✗ Erro ao publicar !CONTAINER_NAME!:latest
                    )
                ) else (
                    echo ✗ Erro ao criar tag latest para !CONTAINER_NAME!
                )
            )
        )
        
        echo.
        echo ====================================
        echo RELEASE CONCLUÍDO!
        echo ====================================
    ) else (
        echo.
        echo ====================================
        echo RELEASE NÃO SOLICITADO
        echo ====================================
        echo Apenas as imagens com versão específica foram publicadas.
        echo Nenhuma tag 'latest' foi criada ou publicada.
    )
) else (
    echo.
    echo ====================================
    echo NENHUMA IMAGEM FOI PUBLICADA
    echo ====================================
    echo Todas as operações falharam.
)

echo.
echo ====================================
echo PROCESSO FINALIZADO!
echo ====================================

endlocal 