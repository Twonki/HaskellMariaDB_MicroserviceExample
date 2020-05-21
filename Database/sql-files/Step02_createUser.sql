USE 'minimal';

CREATE USER IF NOT EXISTS 'checker'@'%' IDENTIFIED BY 'check4me';

CREATE USER IF NOT EXISTS 'docker_health'@'localhost' IDENTIFIED BY 'showmelove';

FLUSH PRIVILEGES;