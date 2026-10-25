# Use a imagem base do Oracle Linux 9
FROM oraclelinux:9 AS builder

WORKDIR /protheus

# Instale dependências necessárias (se houver)
RUN yum update -y && \
    yum install -y unzip libicu && \
    yum clean all

ADD protheus.zip /protheus/
ADD webapp.zip /webapp/

RUN unzip /protheus/protheus.zip -d /protheus/ && \
    rm /protheus/protheus.zip && \
    chmod -R 777 /protheus

RUN unzip /webapp/webapp.zip -x '__MACOSX/*' -d /webapp/ && \
    rm /webapp/webapp.zip && \
    chmod 755 /webapp/webapp.so

FROM totvsengpro/appserver-dev:24.3.1.1

ARG PROTHEUS_INI

COPY --from=builder /protheus /opt/totvs/protheus_bkp

RUN chmod -R 777 /opt/totvs/protheus_bkp

COPY --from=builder /webapp/webapp.so /opt/totvs/webapp_bkp/webapp.so

COPY ./appserver-init.sh /opt/totvs/appserver/appserver-init.sh
RUN chmod +x /opt/totvs/appserver/appserver-init.sh

WORKDIR /opt/totvs/appserver

ENTRYPOINT [ "/opt/totvs/appserver/appserver-init.sh" ]
