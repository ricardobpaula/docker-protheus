# Use a imagem base do Oracle Linux 9
FROM oraclelinux:9 AS builder

WORKDIR /protheus

# Instale dependências necessárias (se houver)
RUN yum update -y && \
    yum install -y unzip libicu && \
    yum clean all

ADD protheus.zip /protheus/

RUN unzip /protheus/protheus.zip -d /protheus/ && \
    rm /protheus/protheus.zip && \
    chmod -R 777 /protheus

FROM totvsengpro/appserver-dev:24.3.0.5

ARG PROTHEUS_INI

COPY --from=builder /protheus /opt/totvs/protheus_bkp

RUN chmod -R 777 /opt/totvs/protheus_bkp

COPY $PROTHEUS_INI/appserver.ini /opt/totvs/appserver/appserver.ini
COPY ./appserver-init.sh /opt/totvs/appserver/appserver-init.sh

WORKDIR /opt/totvs/appserver

ENTRYPOINT [ "/opt/totvs/appserver/appserver-init.sh" ]
