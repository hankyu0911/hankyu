USE sqldb;

SELECT name, height
FROM usertbl
WHERE height >=180 AND height <=183;

SELECT name, height
FROM usertbl
WHERE height BETWEEN 180 AND 183;

SELECT  *
FROM usertbl
WHERE addr = '전남' OR addr = '경북';

SELECT *
FROM usertbl
WHERE name LIKE '김%';

SELECT *
FROM usertbl
WHERE name LIKE '_종신';

# 김경호의 키 보다 큰 사용자의 정보 조회
SELECT name, height 
FROM usertbl
WHERE name = '김경호';

SELECT * 
FROM usertbl
WHERE height > 177;

SELECT *
FROM usertbl
WHERE height > (SELECT height FROM usertbl WHERE name = '김경호');

# 경남 지역에 거주하는 사용자보다 키가 큰 사용자의 정보 조회

/* 오류발생 : 2개 이상의 값 리턴 */
SELECT *
FROM usertbl
WHERE height > (SELECT height FROM usertbl WHERE addr ='경남');

SELECT name, addr, height FROM usertbl WHERE addr = '경남';

/* any : 여러 값 중 하나 이상의 조건을 만족 
        -> 키가 170보다 큰 사용자의 정보 출력 */
SELECT *
FROM usertbl
WHERE height > ANY(SELECT height FROM usertbl WHERE addr = '경남');

/* all : 모든 조건을 만족시키는 값 리턴 
        -> 키가 173보다 큰 사용자의 자료 출력 */
SELECT *
FROM usertbl
WHERE height > ALL(SELECT height FROM usertbl WHERE addr = '경남');

# 가입일 순으로 자료 정렬 (오름차순 기본)
SELECT *
FROM usertbl
ORDER BY mdate;

# 키가 큰 순으로 정렬, 키가 같다면 이름순으로 정렬
SELECT name, height 
FROM usertbl
ORDER BY height DESC, name;

# 사용자들의 거주지 목록 검색

/* 중복 발생 */
SELECT addr 
FROM usertbl;

/* DISTINCT : 중복 제거 */
SELECT DISTINCT addr
FROM usertbl;

# employees 테이블의 데이터 500개까지 출력 
select *
from employees.employees
limit 500;

/* 100번째 자료부터 500개 출력 */
select *
from employees.employees
limit 100,500;

# 테이블 복사
create table buytbl2 (select * from buytbl);

select * from buytbl;
select * from buytbl2;

/* 특정 열만 복사 */
create table usertbl2 (select userid, name, mdate from usertbl);

select * from usertbl2;

# 각 사용자별 총 구매수량 검색 (품목 상관 x)
select userid, sum(amount)
from buytbl
group by userid;

# 각 사용자별 구매액 총합 조회
select userid '사용자 아이디',price * sum(amount) '총구매액'
from buytbl
group by userid;

# 총사용자의 평균 구매개수
select avg(amount)
from buytbl;

# 각 사용자별 평균 구매개수
select userid, avg(amount)
from buytbl
group by userid;

# 키가 가장 큰 사용자와 가장 작은 사용자의 정보 조회
select name, height
from usertbl
where height = (select max(height) from usertbl) 
    or height = (select min(height) from usertbl);

# 핸드폰이 있는 사용자 수 조회
select count(mobile1)
from usertbl;

select count(*)
from usertbl
where mobile1 is not null;

# 총 구매액이 1,000 이상인 사용자 조회
select userid, sum(price * amount)
from buytbl
group by userid
having sum(price * amount) >= 1000
order by sum(price * amount);

# Auto inrement

drop table if exists test;

create table test(
id int auto_increment primary key,
name varchar(10)
);

insert into test values
(null, 'aaa'),
(null, 'bbb');

select * from test;

/* 지정번호 변경 */
alter table test auto_increment = 100;

insert into test values(null, 'ccc');

select * from test;

/* 증가단위 변경 */
set @@auto_increment_increment = 3;

insert into test values
(null, 'ddd'),
(null, 'eee');

select * from test;

# 테이블 정보 수정 
update test
set name = '없음'
where name = 'aaa';

select * from test;

# 모든 제품의 단가가 1.5배 상승
update buytbl
set price  = price*1.5;

select * from buytbl;

# DELETE vs DROP vs TRUNCATE
create table test1 select * from employees.employees;
create table test2 select * from employees.employees;
create table test3 select * from employees.employees;

/* DELETE : 자료 삭제, 데이블 구조 남아있음, 한 행씩 삭제(처리속도 느림) */
delete from test1;

/* DROP : 테이블 전체 삭제 */
drop table test2;

/* TRUNCATE : 테이블 내 자료 전체 삭제 */
truncate table test3;

# INSERT 오류 처리
create table test4
select userid, name from usertbl limit 3;

/* 기본키 지정 : uesrid */
alter table test4
add constraint pk_test4 primary key(userid);

/* 오류 : userid 내의 값 중복('BBK') */
insert into test4 values ('BBK','박보검');
insert into test4 values ('YJS', '유재석');
insert into test4 values ('PMS', '박명수');

select * from test4;

/* 오류발생 행 제외한 나머지 입력 */
insert ignore into test4 values ('BBK','박보검');
insert ignore into test4 values ('YJS', '유재석');
insert ignore into test4 values ('PMS', '박명수');

select * from test4;

/* 중복값을 새로운 데이터로 수정 */
insert into test4 values ('BBK','박보검')
on duplicate key update userid = 'BBK', name = '박보검';
insert into test4 values ('YJS', '유재석')
on duplicate key update userid = 'YJS', name = '유재석';
insert into test4 values ('PMS', '박명수')
on duplicate key update userid = 'PMS', name = '박명수';

select * from test4;

# CTE
with abc(name, height)
as
(select name, height
    from usertbl)
select * from abc;

