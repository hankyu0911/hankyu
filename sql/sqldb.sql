# 데이터베이스 조회
show databases;

# 데이터베이스 지정
use employees;

# 현재 데이터베이스 내의 테이블 조회
show tables;

# 테이블 정보까지 함께 조회
show table status;

# 특정 테이블의 열 조회
show columns from employees;


select first_name, gender from employees;

# 데이터베이스 생성 (sqldb)
drop database if exists sqldb;

create database sqldb;

# sqldb 내에 테이블 생성(usertbl)
use sqldb;

CREATE TABLE usertbl (
    userid CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthyear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height SMALLINT,
    mdate DATE
);

create table buytbl(
num int auto_increment not null primary key,
userid char(8) not null,
prodname char(6) not null,
groupname char(4),
price int not null,
amount smallint not null,
foreign key (userid) references usertbl(userid)
);



insert into usertbl values('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8' );
insert into usertbl values('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
insert into usertbl values('KHH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');
insert into usertbl values('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
insert into usertbl values('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12');
insert into usertbl values('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
insert into usertbl values('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-5-5');
insert into usertbl values('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
insert into usertbl values('JKW', '조관우', 1965, '경기', '010', '99999999', 172, '2010-10-10');
insert into usertbl values('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');
 
select * from usertbl;

insert into buytbl values(NULL, 'KBS', '운동화', NULL, 30, 2);
insert into buytbl values(NULL, 'KBS', '노트북', '전자', 1000, 1);
insert into buytbl values(NULL, 'JYP', '모니터', '전자', 200, 1);
insert into buytbl values(NULL, 'BBK', '모니터', '전자', 200, 5);
insert into buytbl values(NULL, 'KBS', '청바지', '의류', 50, 3);
insert into buytbl values(NULL, 'BBK', '메모리', '전자', 80, 10);
insert into buytbl values(NULL, 'SSK', '책', '서적', 15, 5);
insert into buytbl values(NULL, 'EJW', '책', '서적', 15, 2);
insert into buytbl values(NULL, 'EJW', '청바지', '의류', 50, 1);
insert into buytbl values(NULL, 'BBK', '운동화', NULL, 30, 2);
insert into buytbl values(NULL, 'EJW', '책', '서적', 15, 1);
insert into buytbl values(NULL, 'BBK', '운동화', NULL, 30, 2);

select * from buytbl;