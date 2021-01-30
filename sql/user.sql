# 사용자 확인
USE mysql;

SELECT host, user
FROM user;

# 사용자 생성, 권한 부여 
CREATE USER director@localhost IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON *.* TO director@localhost;


CREATE USER ceo@localhost ;
GRANT SELECT ON *.* TO ceo@localhost;

CREATE USER worker@localhost IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON shopdb.* TO worker@localhost;
GRANT SELECT ON employees.* TO worker@localhost;

FLUSH PRIVILEGES;