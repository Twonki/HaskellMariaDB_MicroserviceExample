# Example - MariaDB

This Repo contains the sources to build the MariaDB required for the minimal example.

## How To

To build (in this repository):
`docker build . -t minimal/database`

To run:
`docker run -p 3306:3306 -e MYSQL_RANDOM_ROOT_PASSWORD=yes -e MYSQL_INITDB_SKIP_TZINFO=true minimal/database`

Optional:
`docker run -p 3306:3306 -e MYSQL_ROOT_PASSWORD={SecretPW} -e MYSQL_INITDB_SKIP_TZINFO=true minimal/database`

## Change

If you want any changes done to the Image, add .sql files to the folder. They are run in alphabetical order.

You can also add .sh files to this folder.

**Do not alter or add any entrypoint scripts in docker, as the mariadb scripts will be overwritten and the container rendered useless!**

## Validate

To validate the database, do

```Shell
root@host>docker exec -it {YourMariaContainer} /bin/bash
root@container> su mysql
$> mysql -u admin -p
$> enter password: 
admin[(none)] > USE minimal;
admin[(minimal)] > show tables;
```

You can now select and join and do everything you want with your database.

## Sources

- [MariaDB Image](https://hub.docker.com/r/mariadb/server/)
- [MariaDB KnowledgeBase](https://mariadb.com/kb/en/)

## Troubleshooting

- First try the validate step
- Run the container without the -d flag, or see `docker logs {your failed container}`
