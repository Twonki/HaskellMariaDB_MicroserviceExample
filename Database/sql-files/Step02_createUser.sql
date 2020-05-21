USE 'minimal';

CREATE USER IF NOT EXISTS 'checker'@'172.%.%.%' IDENTIFIED BY 'check4me';

CREATE USER IF NOT EXISTS 'docker_health'@'localhost' IDENTIFIED BY 'showmelove';

FLUSH PRIVILEGES;