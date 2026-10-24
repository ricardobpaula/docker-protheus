# Estagio de instalacao: o pacote da TOTVS agora vem como instalador (installer.jar)
FROM oraclelinux:9 AS installer

RUN yum update -y && \
    yum install -y tar gzip java-17-openjdk-headless && \
    yum clean all

# O instalador tenta registrar e iniciar o servico no systemd, que nao existe em container.
# Um systemctl falso (so neste estagio) evita o "Process execution failed" do instalador.
RUN mkdir -p /etc/systemd/system /totvs/totvslicensevirtual && \
    printf '#!/bin/sh\nexit 0\n' > /usr/local/bin/systemctl && \
    chmod +x /usr/local/bin/systemctl

COPY license.tar.gz /tmp/license.tar.gz
COPY installer.properties /tmp/license/installer.properties

# Descompacta o pacote (install, installer.jar, license.png) e roda a instalacao silent
RUN tar -xzf /tmp/license.tar.gz -C /tmp/license && \
    rm /tmp/license.tar.gz && \
    cd /tmp/license && \
    bash install 2 && \
    chmod +x /totvs/totvslicensevirtual/bin/appserver/appsrvlinux

# Estagio final: sem java e sem o instalador
FROM oraclelinux:9

RUN yum update -y && \
    yum install -y libicu dmidecode nmap-ncat && \
    yum clean all

COPY --from=installer /totvs/totvslicensevirtual /totvs/totvslicensevirtual

WORKDIR /totvs/totvslicensevirtual/bin/appserver

# licenseserver.ini customizado, copiado para bin/appserver na criacao do container (ver license-init.sh)
COPY licenseserver.ini /totvs/totvslicensevirtual/licenseserver_bkp.ini

# Copie o script de inicialização
COPY license-init.sh /totvslicensevirtual-init.sh

RUN chmod +x /totvslicensevirtual-init.sh

# Defina o comando para iniciar o license
CMD ["/totvslicensevirtual-init.sh"]
