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

