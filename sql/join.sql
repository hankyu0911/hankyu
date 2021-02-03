/* JOIN */

# INNER JOIN
select *
from buytbl
    inner join
    usertbl
    on usertbl.userid = buytbl.userid
where buytbl.userid = 'JYP';

-- 오류발생 : 'userid' 필드 중복 --
select userid, name, productname, addr, concat(mobile1,'-',mobile2) as 'phone'
from buytbl
    inner join
    usertbl
    on buytbl.userid = usertbl.userid;

select b.userid, u.name, b.prodname, u.addr, concat(u.mobile1,u.mobile2) as 'phone'
from buytbl b
    inner join usertbl u
    on b.userid = u.userid;
    
# 주문 내역이 있는 고객의 이름, 전화번호
select distinct u.name, concat(u.mobile1,u.mobile2)
from usertbl u
    inner join buytbl b
    on u.userid = b.userid;
    
select u.name, concat(u.mobile1, u.mobile2)
from usertbl u
where exists (select * from buytbl b where b.userid = u.userid);

drop table if exists stdtbl;
create table stdtbl(
name char(3) primary key,
addr char(2)
);

drop table if exists clubtbl;
create table clubtbl(
club char(3) primary key,
room char(4)
);

drop table if exists stdclubtbl;
create table stdclubtbl(
num integer auto_increment not null primary key,
name char(3),
club char(3),
foreign key (name) references  stdtbl(name),
foreign key (club) references  clubtbl(club)
);

insert into stdtbl values ('김범수','경남');
insert into stdtbl values ('성시경','서울');
insert into stdtbl values ('조용필','경기');
insert into stdtbl values ('은지원','경북');
insert into stdtbl values ('바비킴','서울');


insert into clubtbl values ('수영','101호');
insert into clubtbl values ('바둑','102호');
insert into clubtbl values ('축구','103호');
insert into clubtbl values ('봉사','104호');

insert into stdclubtbl values (null, '김범수', '바둑');
insert into stdclubtbl values (null, '김범수', '축구');
insert into stdclubtbl values (null, '조용필', '축구');
insert into stdclubtbl values (null, '은지원', '축구');
insert into stdclubtbl values (null, '은지원', '봉사');
insert into stdclubtbl values (null, '바비킴', '봉사');

# 학생, 지역, 동아리, 호수 
select s.name, s.addr, c.club, c.room
from stdtbl s
    inner join stdclubtbl sc on s.name = sc.name
    inner join clubtbl c on c.club = sc.club
order by sc.name;

# 동아리, 학생, 지역
select c.club, c.room, s.name, s.addr
from stdtbl s
    inner join stdclubtbl sc on s.name = sc.name
    inner join clubtbl c on c.club = sc.club
order by c.club;

# 외부조인 (Outer Join)
use sqldb;

-- 구매 이력이 없는 고객들을 포함한 고객정보, 구매상품 조회
select u.userid, u.name, b.prodname, concat(u.mobile1,u.mobile2), u.addr
from usertbl u 
    left outer join buytbl b
        on u.userid = b.userid;
    
-- 구매 이력이 없는 고객들의 정보 조회
select u.userid, u.name, u.addr, concat(u.mobile1,u.mobile2)
from usertbl u
    left outer join buytbl b
        on u.userid = b.userid
where b.prodname is null;

-- 가입한 동아리가 없는 학생을 포함한 학생과 동아리 정보 조회
select s.name, c.club, c.room
from stdtbl s
    left outer join stdclubtbl sc
        on s.name = sc.name
    left outer join clubtbl c
        on c.club = sc.club;
        
-- 가입한 학생이 없는 동아리를 포함하여 동아리 정보와 해당 학생 조회
select c.club, c.room, s.name
from clubtbl c 
    left outer join stdclubtbl sc
        on c.club = sc.club
    left outer join stdtbl s
        on s.name = sc.name;
        
-- 동아리 미가입 학생 포함 학생 정보와 학생 미등록 동아리 포함 동아리 정보 모두 조회
select s.name, c.club, c.room
from stdtbl s
    left outer join stdclubtbl sc
        on s.name = sc.name
    left outer join clubtbl c
        on c.club = sc.club

union

select c.club, c.room, s.name
from clubtbl c
    left outer join stdclubtbl sc
        on c.club = sc.club
    left outer join stdtbl s
        on s.name = sc.name;
        
# 크로스 조인 (Cross Join) : 주로 대용량 테스트 데이터 셋을 만드는 용도로 사용 
use employees;

select count(*)
from employees;

select count(*)
from titles;

select count(*)
from employees 
    cross join titles;

# 셀프 조인 (Self Join) 
drop table if exists emptbl;

create table emptbl(
emp char(3) not null primary key,
manager char(3),
emptel varchar(10)
);

insert into emptbl values('나사장', null, '0000');
insert into emptbl values('김재무', '나사장', '2222');
insert into emptbl values('김부장', '김재무', '2222-1');
insert into emptbl values('이부장', '김재무', '2222-2');
insert into emptbl values('우대리', '이부장', '2222-2-1');
insert into emptbl values('지사원', '이부장', '2222-2-2');
insert into emptbl values('이영업', '나사장', '1111');
insert into emptbl values('한과장', '이영업', '1111-1');
insert into emptbl values('최정보', '나사장', '3333');
insert into emptbl values('윤차장', '최정보', '3333-1');
insert into emptbl values('이주임', '윤차장', '3333-1-1');

-- 우대리 상관의 전화번호
select a.emp, b.emp, b.emptel
from emptbl a 
    inner join emptbl b
        on a.manager = b.emp
where a.emp = '우대리';