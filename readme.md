# docker-protheus

Esse repositorio usa como base as imagens disponibilizadas pela totvs adaptado para uso do MSSQL.

O Protheus em ambiente docker não está homologado para uso em ambientes produtivos.

Duvidas consultar a documentação oficial da totvs em: https://docker-protheus.engpro.totvs.com.br

# Requisitos 

- Docker

- Docker Compose

# Pré-requisitos para montagem das imagens de arquivos

> Nao necessario caso use as imagens do docker hub

Os pacotes da TOTVS não são versionados (`*.zip` e `*.tar.gz` estão no `.gitignore`). Antes de executar o build das imagens, baixe-os no portal da TOTVS e coloque cada um **na pasta indicada, com o nome exato**:

| Pasta | Arquivo | Descrição |
|-------|---------|-----------|
| `appserver/` | `appserver.tar.gz` | AppServer Linux |
| `appserver/` | `webapp.zip` | `webapp.so` Linux |
| `appserver/` | `protheus.zip` | `protheus_data` e pasta `apo` (RPOs) |
| `dbaccess/` | `dbaccess.tar.gz` | DBAccess Linux |
| `license/` | `license.tar.gz` | Instalador do License Server Linux |

Estrutura esperada:

```
appserver/
  appserver.tar.gz
  webapp.zip
  protheus.zip
dbaccess/
  dbaccess.tar.gz
license/
  license.tar.gz
```

Estrutura interna do `protheus.zip`:

```
apo/
  debug/tttm120.rpo
  dev/tttm120.rpo
  rest/tttm120.rpo
  tttm120.rpo
protheus_data/
  system/
  systemload/
```

Observações:

- A pasta `mssql/` não precisa de nenhum pacote.
- Ao compactar no macOS, o `__MACOSX/` pode ir dentro dos `.zip`. O Dockerfile do `webapp.zip` já o ignora.
- O RPO dentro do `protheus.zip` deve corresponder à release informada em `RELEASE` no `.env`.

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
```