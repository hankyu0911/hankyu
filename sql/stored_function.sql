/* 데이터 자료형 
    # 숫자형 
        INTEGER : 약 -21억 ~ 21억, 4바이트
        SMALLINT : 약 -32000 ~ 32000, 2바이트
        LONGINT : 약 -900경 ~ 900경, 8바이트
    
    # 문자형
        CHAR : 1~255바이트, 고정형
        VARCHAR : 1~65535바이트, 가변형
        LONGTEXT : 대용량 텍스트 저장, 4GB
        LONGBLOB : 대용량 이미지, 동영상 저장, 4GB
    
    # 날짜형
        DATE : 'yyyy-mm-dd' 형식 
        TIME : 'hh:mm:ss' 형식
        DATETIME : 'yyyy-mm-dd hh:mm:ss' 형식
        YEAR : 'yyyy' 형식
        
        # 기타 데이터 형식
            GEOMETRY(공간데이터), JSON(JavaScript Object Notation)
        
        */

# 변수
USE sqldb;

SET @var1 = 1;
SET @var2 = 2;
SET @var3 = '이름 : ';

SELECT @var1;
SELECT @var1 + @var2;
SELECT @var3, name, height FROM usertbl WHERE height >180;

# PREPARE, EXECUTE
set @var3 = 3;

-- 오류발생 --
select name, height 
from usertbl
limit @var3;

prepare mysql
from 'select name, height from usertbl limit ?';
execute mysql using @var3;

# 자료형 변환 
SELECT CAST('2020-1-1 13:23:11.123' AS DATE) AS date;
SELECT CAST('2020-1-1 13:23:11.123' AS TIME) AS time;
SELECT CAST('2020-1-1 13:23:11.123' AS DATETIME) AS datetime;

select convert(avg(amount), signed integer) 
from buytbl;

select '100' + '200';
select concat('100','200');
select concat(100,'200');
select 1>'2MEGA';
select 3>'2MEGA';
select 2='MEGA0'; 

# 내장함수
SELECT IF(3>2,'참','거짓');
SELECT IFNULL(NULL,'NULL 입니다');
SELECT IFNULL(100,'NULL 입니다');

-- 문자열 함수 --
SELECT ASCII('A');
SELECT CHAR(65);

SELECT BIT_LENGTH('abc');
SELECT CHAR_LENGTH('abc');
SELECT LENGTH('abc');

SELECT BIT_LENGTH('가나다');
SELECT CHAR_LENGTH('가나다');
SELECT LENGTH('가나다');

SELECT CONCAT('2015','/','01','/','01');
SELECT CONCAT_WS('/','2015','01','01');

SELECT ELT(2,'하나','둘','셋');
SELECT FIELD('둘','하나','둘','셋');
SELECT FIND_IN_SET('둘','하나,둘,셋');
SELECT INSTR('하나둘셋','둘');
SELECT LOCATE('둘','하나둘셋');

-- 날짜 관련 함수 --
SELECT ADDDATE('2020-01-01', INTERVAL 31 day);
SELECT ADDDATE('2020-01-01',INTERVAL 1 month);
SELECT SUBDATE('2020-02-01',INTERVAL 31 day);
SELECT SUBDATE('2020-02-01',INTERVAL 1 month);

SELECT CURDATE();
SELECT CURTIME();
SELECT NOW();
SELECT SYSDATE();

SELECT DATE(NOW());
SELECT TIME(NOW());

SELECT DATEDIFF('2021-09-11',CURDATE());
SELECT TIMEDIFF('13:22:00',CURTIME());

SELECT LAST_DAY('2021-02-01');

-- 시스템 정보 함수 --
SELECT USER();
SELECT DATABASE();
SELECT FOUND_ROWS();

use sqldb;
create table test 
select * from buytbl;
update test 
set price = 100;
select row_count();