## Minimal - Checker

This part of the example repository holds a microservice to check the database status.

## Build and Install

Install ODBC first with

```shell
sudo apt-get install unixodbc unixodbc-dev unixodbc-bin
```

In addition, you need to [install mariadb-odbc](https://mariadb.com/kb/en/about-mariadb-connector-odbc/),
with (on Ubuntu/Debian):

```shell
mkdir odbc_package
cd odbc_package
wget https://downloads.mariadb.com/Connectors/odbc/connector-odbc-3.1.7/mariadb-connector-odbc-3.1.7-ga-debian-x86_64.tar.gz
tar -xvzf mariadb-connector-odbc-3.1.7-ga-debian-x86_64.tar.gz
sudo install lib/libmaodbc.so /usr/lib/
```

Then you have to set the odbc driver with (In this directory):

`sudo odbcinst -i -d -f Resources/MariaDB_odbc_driver_template.ini`

and verify that it shows up with `odbcinst -q -d`

To manually build on your machine, run in this repository:

```shell
cabal new-install
```

To build the docker run:

```shell
docker build . -t minimal/checker
```

To have an total overview of whats going on, use the compose file in resources:
(But make sure to build both docker images first)

```shell
sudo docker-compose -f Resources/micro-compose.yml up
```

## Requirements

To build the docker image, only docker is required.

To run manually, one needs

- GHC >8.10
- Cabal > 3
- LinuxODBC (see above)

## Troubleshooting

To run the image and check things in it, without it shutting down, run:

`sudo docker run -it --entrypoint /bin/bash checker`

**Issues with libmaodbc.so:**

I faced some issues using the mariadb connector inside the docker image.
Reason for this is likely a version missmatch of debian, libssl, odbc and mariadbodbc (I have not exactly figured out which one is the bad guy).
I solved it using the 2.0.19 version of mariadbodbc as seen in the [Dockerfile](Dockerfile).

Running the container periodically, like seen in [the micro-compose](Resources/micro-compose.yml), requires to do a docker stack deploy not a compose.
To set this up, do:

`docker stack init --advertise-adr 127.0.0.1`

then you can do

`docker stack deploy -c Resources/micro-compose.yml teststack`

clean up with

`docker stack rm teststack`
