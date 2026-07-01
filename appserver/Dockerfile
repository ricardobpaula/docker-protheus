FROM oraclelinux:9 AS appserver-builder

RUN yum update -y && \
    yum install -y unzip && \
    yum clean all

ADD appserver.zip /tmp/appserver.zip

RUN mkdir -p /opt/totvs/appserver && \
    unzip /tmp/appserver.zip -d /opt/totvs/appserver && \
    rm /tmp/appserver.zip && \
    chmod -R 755 /opt/totvs/appserver

FROM oraclelinux:9 AS protheus-builder

RUN yum update -y && \
    yum install -y unzip && \
    yum clean all

ADD protheus.zip /tmp/protheus.zip

RUN mkdir -p /opt/totvs/protheus_bkp && \
    unzip /tmp/protheus.zip -d /opt/totvs/protheus_bkp && \
    rm /tmp/protheus.zip && \
    chmod -R 777 /opt/totvs/protheus_bkp

FROM oraclelinux:9

RUN yum update -y && \
    yum install -y libicu libstdc++ glibc && \
    yum clean all

COPY --from=appserver-builder /opt/totvs/appserver /opt/totvs/appserver
COPY --from=protheus-builder /opt/totvs/protheus_bkp /opt/totvs/protheus_bkp

COPY ./appserver-init.sh /opt/totvs/appserver/appserver-init.sh

RUN chmod +x /opt/totvs/appserver/appserver-init.sh

WORKDIR /opt/totvs/appserver

ENTRYPOINT [ "/opt/totvs/appserver/appserver-init.sh" ]
