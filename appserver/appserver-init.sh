#!/bin/sh
set -e

/bin/sed 's/{{DBACCESS_SERVER}}/'"${DBACCESS_SERVER}"'/' -i /opt/totvs/appserver/appserver.ini
/bin/sed 's/{{DBACCESS_ALIAS}}/'"${DBACCESS_ALIAS}"'/' -i /opt/totvs/appserver/appserver.ini
/bin/sed 's/{{DBACCESS_PORT}}/'"${DBACCESS_PORT}"'/' -i /opt/totvs/appserver/appserver.ini
/bin/sed 's/{{LICENSE_SERVER}}/'"${LICENSE_SERVER}"'/' -i /opt/totvs/appserver/appserver.ini

# Cria a pasta principal
mkdir -p /opt/totvs/protheus

# Inicializa a pasta protheus_data se estiver vazia
if [ ! "$(ls -A /opt/totvs/protheus/protheus_data 2>/dev/null)" ]; then
    echo "Pasta protheus_data vazia, inicializando..."
    mkdir -p /opt/totvs/protheus/protheus_data
    if [ -d "/opt/totvs/protheus_bkp/protheus_data" ]; then
        cp -r /opt/totvs/protheus_bkp/protheus_data/* /opt/totvs/protheus/protheus_data/
        echo "Copiado conteúdo para protheus_data"
    fi
fi

# Inicializa a pasta apo se estiver vazia
if [ ! "$(ls -A /opt/totvs/protheus/apo 2>/dev/null)" ]; then
    echo "Pasta apo vazia, inicializando..."
    mkdir -p /opt/totvs/protheus/apo
    if [ -d "/opt/totvs/protheus_bkp/apo" ]; then
        cp -r /opt/totvs/protheus_bkp/apo/* /opt/totvs/protheus/apo/
        echo "Copiado conteúdo para apo"
    fi
fi

# Copia outros arquivos e pastas (exceto protheus_data e apo)
for item in /opt/totvs/protheus_bkp/*; do
    basename=$(basename "$item")
    if [ "$basename" != "protheus_data" ] && [ "$basename" != "apo" ]; then
        if [ ! -e "/opt/totvs/protheus/$basename" ]; then
            cp -r "$item" "/opt/totvs/protheus/"
            echo "Copiado $basename para /opt/totvs/protheus/"
        fi
    fi
done

exec "/opt/totvs/appserver/appsrvlinux"