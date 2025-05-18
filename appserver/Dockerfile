FROM totvsengpro/appserver-dev:24.3.0.5

ARG PROTHEUS_INI

COPY $PROTHEUS_INI/appserver.ini /opt/totvs/appserver/appserver.ini
COPY ./appserver-init.sh /opt/totvs/appserver/appserver-init.sh

WORKDIR /opt/totvs/appserver

ENTRYPOINT [ "/opt/totvs/appserver/appserver-init.sh" ]
