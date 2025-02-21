# Use a imagem base do Oracle Linux 9
FROM oraclelinux:9

# Instale dependências necessárias (se houver)
RUN yum update -y && \
    yum install -y unzip libicu && \
    yum clean all

# Crie o diretório /usr/sbin/smart-view
RUN mkdir -p /usr/sbin/smart-view

# Adicione o arquivo ZIP para o diretório /usr/sbin/smart-view
ADD smartview.zip /usr/sbin/smart-view/

# Copie o script de inicialização
COPY smartview-init.sh /usr/sbin/smart-view/

# Descompacte o arquivo ZIP (se necessário)
RUN unzip /usr/sbin/smart-view/smartview.zip -d /usr/sbin/smart-view/ && \
    rm /usr/sbin/smart-view/smartview.zip && \
    chmod +x /usr/sbin/smart-view/smartview-init.sh

# Defina o diretório de trabalho
WORKDIR /usr/sbin/smart-view

# Defina o comando para iniciar o TReports.Agent
CMD ["/usr/sbin/smart-view/smartview-init.sh"]