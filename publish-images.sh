#!/bin/bash

# Configurações
USERNAME="ricardobpaula"
FOLDERS=(appserver dbaccess mssql license)
# Em Mac ARM as imagens precisam ser buildadas para amd64
PLATFORM="${PLATFORM:-linux/amd64}"

# Verifica versao
if [[ -z "$1" ]]; then
    echo "Uso: ./publish-images.sh <versao> [latest]"
    echo "Exemplo: ./publish-images.sh 1.0.0"
    echo "Exemplo: ./publish-images.sh 1.0.0 latest"
    exit 1
fi

VERSION="$1"
PUBLISH_LATEST="N"
[[ "$(echo "$2" | tr '[:upper:]' '[:lower:]')" == "latest" ]] && PUBLISH_LATEST="S"

echo "========================================"
echo "PUBLICANDO IMAGENS DOCKER - v$VERSION"
[[ "$PUBLISH_LATEST" == "S" ]] && echo "[COM LATEST]"
echo "========================================"

SUCCESS=0
TOTAL=0

# Processa cada pasta
for f in "${FOLDERS[@]}"; do
    TOTAL=$((TOTAL + 1))
    NAME="$f-dev-protheus"

    if [[ -d "./$f" ]]; then
        echo
        echo "[$f] Buildando..."
        if docker build --platform "$PLATFORM" -t "$USERNAME/$NAME" "./$f" > /dev/null 2>&1; then
            echo "[$f] Taggeando..."
            docker tag "$USERNAME/$NAME" "$USERNAME/$NAME:$VERSION" > /dev/null 2>&1

            echo "[$f] Publicando versao..."
            if docker push "$USERNAME/$NAME:$VERSION" > /dev/null 2>&1; then
                PUSH_OK=1
                if [[ "$PUBLISH_LATEST" == "S" ]]; then
                    echo "[$f] Taggeando latest..."
                    docker tag "$USERNAME/$NAME" "$USERNAME/$NAME:latest" > /dev/null 2>&1
                    echo "[$f] Publicando latest..."
                    docker push "$USERNAME/$NAME:latest" > /dev/null 2>&1 || PUSH_OK=0
                fi

                if [[ $PUSH_OK -eq 1 ]]; then
                    echo "[$f] [OK] SUCESSO"
                    SUCCESS=$((SUCCESS + 1))
                else
                    echo "[$f] [ERRO] PUSH LATEST FALHOU"
                fi
            else
                echo "[$f] [ERRO] PUSH FALHOU"
            fi
        else
            echo "[$f] [ERRO] BUILD FALHOU"
        fi
    else
        echo "[$f] [ERRO] PASTA NAO ENCONTRADA"
    fi
done

echo
echo "========================================"
echo "RESULTADO: $SUCCESS/$TOTAL IMAGENS PUBLICADAS"
echo "========================================"

if [[ $SUCCESS -eq $TOTAL ]]; then
    echo "STATUS: [OK] TODAS AS IMAGENS FORAM PUBLICADAS"
    exit 0
else
    echo "STATUS: [ERRO] ALGUMAS IMAGENS FALHARAM"
    exit 1
fi
