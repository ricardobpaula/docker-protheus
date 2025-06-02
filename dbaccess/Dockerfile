FROM totvsengpro/dbaccess-postgres-dev:23.1.1.4

RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo \
    && yum -y update \
    && yum -y install \
    postgresql \
    postgresql-odbc \
    wget \
    && ACCEPT_EULA=Y yum install -y msodbcsql17 \
    && rm -rf /var/cache/yum/* \
    && yum clean all

COPY ./odbc.ini /etc/odbc.ini
COPY ./dbaccess-init.sh /usr/local/bin/dbaccess-init.sh

ENTRYPOINT [ "/usr/local/bin/dbaccess-init.sh" ]