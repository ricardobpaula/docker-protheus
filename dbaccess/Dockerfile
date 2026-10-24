FROM oraclelinux:9 AS builder

RUN yum update -y && \
    yum install -y tar gzip && \
    yum clean all

COPY dbaccess.tar.gz /tmp/dbaccess.tar.gz

RUN mkdir -p /opt/totvs/dbaccess && \
    tar -xzf /tmp/dbaccess.tar.gz -C /opt/totvs/dbaccess && \
    rm /tmp/dbaccess.tar.gz && \
    chmod -R 755 /opt/totvs/dbaccess

#FROM oraclelinux:9

RUN curl https://packages.microsoft.com/config/rhel/9/prod.repo > /etc/yum.repos.d/mssql-release.repo \
    && yum -y update \
    && yum -y install \
    wget \
    nmap-ncat \
    unixODBC \
    && ACCEPT_EULA=Y yum install -y msodbcsql18 \
    && rm -rf /var/cache/yum/* \
    && yum clean all

# O DBAccess carrega /usr/lib64/libodbc.so, que so existe no unixODBC-devel
RUN ln -sf /usr/lib64/libodbc.so.2 /usr/lib64/libodbc.so

#COPY --from=builder /opt/totvs/dbaccess /opt/totvs/dbaccess

COPY ./odbc.ini /etc/odbc.ini
COPY ./dbaccess-init.sh /usr/local/bin/dbaccess-init.sh

RUN chmod +x /usr/local/bin/dbaccess-init.sh

WORKDIR /opt/totvs/dbaccess/multi

ENTRYPOINT [ "/usr/local/bin/dbaccess-init.sh" ]