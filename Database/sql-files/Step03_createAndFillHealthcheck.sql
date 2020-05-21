USE `minimal`;

CREATE TABLE IF NOT EXISTS health (
    status VARCHAR(40) NOT NULL
) engine=InnoDB default charset utf8;

INSERT INTO health (status) VALUES ("alive");

GRANT SELECT ON minimal.health TO 'checker'@'172.%.%.%';

GRANT SELECT ON minimal.health TO 'docker_health'@'localhost';