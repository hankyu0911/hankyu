/* 테이블 */

DROP DATABASE IF EXISTS shopdb;
DROP DATABASE IF EXISTS modeldb;
DROP DATABASE IF EXISTS sqldb;
DROP DATABASE IF EXISTS tabledb;


# 테이블 압축
CREATE DATABASE IF NOT EXISTS compressdb;
USE compressdb;

CREATE TABLE normaltbl(
emp_no INT,
first_name VARCHAR(14)
);

CREATE TABLE compresstbl(
emp_no INT,
first_name VARCHAR(14)
)
ROW_FORMAT = COMPRESSED;

INSERT INTO normaltbl
    SELECT emp_no,first_name FROM employees.employees;
    
INSERT INTO compresstbl
    SELECT emp_no, first_name FROM employees.employees;
    
SHOW TABLE STATUS FROM compressdb;

# 임시 테이블 : 현재 세션에서만 사용 가능, 이미 존재하는 테이블과 이름 같은경우 임시테이블이 우선함

USE employees;

CREATE TEMPORARY TABLE employees(
emp_no INT,
first_name VARCHAR(14)
);

SELECT * FROM employees;

DROP TABLE employees;

SELECT * FROM employees;


-- 실습 데이터 생성 (uesrtbl, buytbl)

USE tabledb;

DROP TABLE IF EXISTS usertbl, buytbl;

CREATE TABLE usertbl(
userid CHAR(8),
name VARCHAR(10),
birthywer INT,
addr CHAR(2),
mobile1 CHAR(3),
mobile2 CHAR(8),
height SMALLINT,
mdate DATE
);

CREATE TABLE buytbl(
num INT AUTO_INCREMENT PRIMARY KEY,
userid CHAR(8),
prodname CHAR(6),
groupname CHAR(4),
price INT,
amount SMALLINT
);


INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', NULL, '경남', '011', '22222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1871, '전남', '019', '33333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200, 5);

# 기본키(Primary Key) 지정
ALTER TABLE usertbl
    ADD CONSTRAINT pk_usertbl_userid
    PRIMARY KEY(userid);
    
DESC usertbl;

# 외래키(Foreign Key) 지정

-- 오류발생 : buytbl의 userid 중 'BBK'가 usertbl의 userid에 존재하지 않음
ALTER TABLE buytbl
    ADD CONSTRAINT fk_buytbl_userid
    FOREIGN KEY (userid) REFERENCES usertbl(userid);
    
-- 삭제 후 재실행
DELETE FROM buytbl 
    WHERE userid = 'BBK';
    
ALTER TABLE buytbl
    ADD CONSTRAINT fk_buytbl_userid
    FOREIGN KEY (userid) REFERENCES usertbl(userid);
    
    
-- 다시 'BBK' 행 입력해도 오류 발생
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200, 5);
    
-- 참조하는 테이블의 기본키 열에 해당 값을 추가 or foreign_key_checks 설정 변경 후 데이터 입력
SET foreign_key_checks  = 0;
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200, 5);
SET foreign_key_checks = 1;

SELECT * FROM buytbl;

# 체크(check) 조건 설정

-- 오류발생
ALTER TABLE usertbl 
ADD CONSTRAINT ck_birthyear
CHECK ((birthyear >= 1900) AND (birthyear <=2023));

-- 김범수 행의 birthyear 값 null, 김경호 행의 birthyear = 1871
SELECT userid, name, birthyear 
FROM usertbl;

-- 해당 값 수정 후 재실행
UPDATE usertbl SET birthyear = 1979 WHERE userid = 'KBS';
UPDATE usertbl SET birthyear = 1971 WHERE userid = 'KKH';

ALTER TABLE usertbl 
ADD CONSTRAINT ck_birthyear
CHECK ((birthyear >= 1900) AND (birthyear <=2023));

# 참조되는 기본키 값 변경 : usertbl의 userid 'KBS' -> 'KVS'

-- 오류발생 
UPDATE usertbl SET userid = 'KBS' WHERE userid ='KVS';

-- foreign_key_checks값 설정 후 재실행
SET foreign_key_checks = 0;
UPDATE usertbl SET userid = 'KBS' WHERE userid ='KVS';
SET foreign_key_checks=1;

-- buytbl의 해당 userid도 변경 후 조인
UPDATE buytbl SET userid = 'KBS' WHERE userid = 'KVS';

SELECT u.userid, u.name, b.prodname
FROM usertbl u
    INNER JOIN buytbl b
    ON u.userid = b.userid;
    
# on update cascade : 참조하는 테이블의 값이 변경되면 참조하는 테이블에 자동으로 반영
ALTER TABLE buytbl
DROP FOREIGN KEY fk_buytbl_userid;

ALTER TABLE buytbl
    ADD CONSTRAINT fk_buytbl_userid
    FOREIGN KEY (userid) REFERENCES usertbl(userid)
    ON UPDATE CASCADE;
    
UPDATE usertbl SET userid = 'KBS' WHERE userid = 'KVS';

SELECT u.userid, u.name, b.prodname
FROM usertbl u
    INNER JOIN buytbl b
    ON u.userid = b.userid;

# on delete cascade
ALTER TABLE buytbl
    DROP FOREIGN KEY fk_buytbl_userid;
    
ALTER TABLE buytbl
    ADD CONSTRAINT fk_buytbl_userid
    FOREIGN KEY (userid) REFERENCES usertbl(userid)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
    
DELETE FROM usertbl WHERE userid = 'KBS';

SELECT u.userid, u.name, b.prodname
FROM usertbl u
    INNER JOIN buytbl b
    ON u.userid = b.userid;