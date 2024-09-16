# docker-protheus

Esse repositorio usa como base as imagens disponibilizadas pela totvs adaptado para uso do MSSQL.

O Protheus em ambiente docker não está homologado para uso em ambientes produtivos.

Duvidas consultar a documentação oficial da totvs em: https://docker-protheus.engpro.totvs.com.br

# Ambiente

- Crie uma copia do arquivo env-example com o nome .env

- Crie uma pasta conforme a variavel $PROTHEUS_PATH do .env

- Copia para $PROTHEUS_PATH/apo o rpo padrao com nome tttm120.RPO

- Copia para $PROTHEUS_PATH/protheus_data a pasta protheus_data

# Execucao

docker-compose up -d

# Problemas e Soluções

-   Problema: Erro na execução de scripts no Windows

Solução:

> Sempre salvar os aquivos .sh com end of line LF.

-   Problema: Falha ao conectar ao banco

Solução:

> Verificar versão do arquivo /opt/microsoft/msodbcsql17/lib64/libmsodbcsql dentro do container dbaccess

> caso divergente da versão no docker/totvs-dbaccess-docker/build/odbc.ini corrigir e subir container novamente

-   Problema: Versão de appserver/dbaccess