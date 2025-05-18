# Use a imagem base do Oracle Linux 9
FROM oraclelinux:9

# Instale dependências necessárias (se houver)
RUN yum update -y && \
    yum install -y unzip libicu && \
    yum clean all

# Crie o diretório /totvs/totvslicensevirtual
RUN mkdir -p /totvs/totvslicensevirtual

# Adicione o arquivo ZIP para o diretório /totvs/totvslicensevirtual
ADD license.zip /totvs/totvslicensevirtual/

# Descompacte o arquivo ZIP (se necessário)
RUN unzip /totvs/totvslicensevirtual/license.zip -d /totvs/totvslicensevirtual/ && \
    rm /totvs/totvslicensevirtual/license.zip && \
    chmod -R 777 /totvs/totvslicensevirtual && \
    chmod +x /totvs/totvslicensevirtual/bin/appserver/appsrvlinux

# Defina o diretório de trabalho
WORKDIR /totvs/totvslicensevirtual/bin/appserver

# Copie o script de inicialização
COPY license-init.sh /totvslicensevirtual-init.sh

RUN chmod +x /totvslicensevirtual-init.sh

# Defina o comando para iniciar o license
CMD ["/totvslicensevirtual-init.sh"]