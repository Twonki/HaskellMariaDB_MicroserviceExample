FROM haskell:8.8.3-buster

RUN apt-get update

# Drivers for general ODBC, wget for mariaodbc download
RUN apt-get install wget unixodbc unixodbc-dev unixodbc-bin -y

# Installing Specific MariaDB ODBC
# Taken from https://mariadb.com/kb/en/about-mariadb-connector-odbc/
WORKDIR  /odbc_package
RUN wget https://downloads.mariadb.com/Connectors/odbc/connector-odbc-2.0.19/mariadb-connector-odbc-2.0.19-ga-debian-x86_64.tar.gz
RUN tar -xvzf mariadb-connector-odbc-2.0.19-ga-debian-x86_64.tar.gz
RUN install /odbc_package/lib/libmaodbc.so /lib/

RUN cabal update

WORKDIR /App

ENV MariaDB_Adress 127.0.0.1
ENV MariaDB_Port 3306
ENV MariaDB_DatabaseName minimal
ENV MariaDB_User checker
# The password should be handled via docker secret
ENV MariaDB_PW check4me

COPY . .
RUN odbcinst -i -d -f Resources/MariaDB_odbc_driver_template.ini
RUN cabal new-install 

ENTRYPOINT [ "/bin/bash", "-c","./Resources/wait-for-it.sh -t 0 -s --host=$MariaDB_Adress --port=$MariaDB_Port -- Checker -h ${MariaDB_Adress} -u ${MariaDB_User} --password ${MariaDB_PW} -p ${MariaDB_Port} -d ${MariaDB_DatabaseName}"]