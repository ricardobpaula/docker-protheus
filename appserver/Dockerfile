FROM totvsengpro/appserver-dev:20.3.2.8

ARG PROTHEUS_INI

#COPY ./data/apo/ /opt/totvs/protheus/apo/
#COPY ./data/systemload/ /opt/totvs/protheus/protheus_data/systemload/
COPY $PROTHEUS_INI/appserver.ini /opt/totvs/appserver/appserver.ini
COPY ./appserver-init.sh /opt/totvs/appserver/appserver-init.sh

WORKDIR /opt/totvs/appserver

ENTRYPOINT [ "/opt/totvs/appserver/appserver-init.sh" ]
