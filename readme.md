# docker-protheus

Esse repositorio usa como base as imagens disponibilizadas pela totvs adaptado para uso do MSSQL.

O Protheus em ambiente docker não está homologado para uso em ambientes produtivos.

Duvidas consultar a documentação oficial da totvs em: https://docker-protheus.engpro.totvs.com.br

# Requisitos 

- Docker

- Docker Compose

# Windows

- Executar o bat ```start_docker.bat``` na raiz do projeto.

# Linux

- Crie uma copia do arquivo env-example com o nome .env

- Executar o comando ```docker-compose up -d``` na raiz do projeto.

# Problemas e Soluções

-   Problema: Erro na execução de scripts no Windows

Solução:

> Sempre salvar os aquivos .sh com end of line LF.

-   Problema: Falha ao conectar ao banco

Solução:

> Verificar versão do arquivo /opt/microsoft/msodbcsql17/lib64/libmsodbcsql dentro do container dbaccess

> caso divergente da versão no docker/totvs-dbaccess-docker/build/odbc.ini corrigir e subir container novamente

-   Problema: Versão de appserver/dbaccess

## Plataformas MacOs/ARM

- Incluir o docker-compose.override.yml

```
services:
  license:
    platform: linux/amd64

  database:
    platform: linux/amd64

  dbaccess:
    platform: linux/amd64

  appserver:
    platform: linux/amd64

  appserver-rest:
    platform: linux/amd64

  smartview:
    platform: linux/amd64 
```