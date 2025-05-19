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

## Smartview

- Para instalação do smartview é necessario o download no link versão linux [Instalação Smartview TDN](https://tdn.totvs.com.br/pages/releaseview.action?pageId=626636542)

- Renomear o ZIP para smartview.zip e copiar para a pasta /smartview

- Para executar a versão com smartview ```docker-compose -f docker-compose-smartview.yml up -d```

- Outra opção é excluir o docker-compose.yml e renomear o docker-compose-smartview.yml para docker-compose.yml e executar o comando ```docker-compose up -d``` na raiz do projeto.

- Para acessar o smartview, abrir o navegador e digitar o ip:porta informado no .env

- Exemplo: http://127.0.0.1:7190/smartview/