FROM oraclelinux:9 AS builder

RUN yum update -y && \
    yum install -y unzip && \
    yum clean all

ADD dbaccess.zip /tmp/dbaccess.zip

RUN mkdir -p /opt/totvs/dbaccess && \
    unzip /tmp/dbaccess.zip -d /opt/totvs/dbaccess && \
    rm /tmp/dbaccess.zip && \
    chmod -R 755 /opt/totvs/dbaccess

#FROM oraclelinux:9

RUN curl https://packages.microsoft.com/config/rhel/9/prod.repo > /etc/yum.repos.d/mssql-release.repo \
    && yum -y update \
    && yum -y install \
    wget \
    unixODBC \
    && ACCEPT_EULA=Y yum install -y msodbcsql18 \
    && rm -rf /var/cache/yum/* \
    && yum clean all

#COPY --from=builder /opt/totvs/dbaccess /opt/totvs/dbaccess

COPY ./odbc.ini /etc/odbc.ini
COPY ./dbaccess-init.sh /usr/local/bin/dbaccess-init.sh

RUN chmod +x /usr/local/bin/dbaccess-init.sh

WORKDIR /opt/totvs/dbaccess/multi

ENTRYPOINT [ "/usr/local/bin/dbaccess-init.sh" ]