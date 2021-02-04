/* SQL Programming */

drop procedure if exists testProc;

delimiter $$
create procedure testProc()
begin 
declare var int;
set var = 100;
if var = 100 then
    select '100입니다.' as '출력';
else 
    select '100이 아닙니다.' as '출력';
end if;
end $$
delimiter ;

call testProc();


# employees 테이블에서 사원번호가 '10001'인 사원의 입사일이 5년이 넘었는지 확인
use employees;

show columns from employees;

drop procedure if exists testProc2;

delimiter $$
create procedure testProc2()
begin
declare hiredate date;
declare curdate date;
declare days int;

select hire_date into hiredate from employees where emp_no = 10001;
set curdate = current_date();
set days = datediff(curdate,hiredate);

if (days/365) >=5 then 
    select 
        concat ('근무하신지',days,'일이 지났습니다. 축하합니다!') as '출력';
else 
    select 
        concat('아직 근무하신지',days,'일 밖에 지나지 않았습니다.') as '출력';
end if;
end $$
delimiter ;

call testProc2();


# usertbl에서 1500원 이상 구매 고객은 '최우수고객', 1000원 이상 구매 고객은 '우수고객', 1원 이상 구매 고객은 '일반고객', 구매이력이 없는 고객은 '유령고객' 분류
use sqldb;

select u.userid, u.name, sum(b.amount* b.price) as 'total', 
    case 
        when sum(b.amount*b.price)>=1500 then '최우수고객'
        when sum(b.amount*b.price)>=1000 then '우수고객'
        when sum(b.amount*b.price)>=1 then '기본고객'
        else '유령고객' 
        end as '고객등급'
from usertbl u
    left outer join buytbl b 
        on u.userid = b.userid
group by u.userid
order by total desc;

# 1에서 100까지의 합계
drop procedure if exists testProc3;

delimiter $$
create procedure testProc3()
begin
    declare i int ;
    declare result int ;
    set i = 1;
    set result = 0;

    while (i<=100) do
        set result = result +i;
        set i = i+1;
    
    end while;

    select result as '출력';
    
end $$
delimiter ;
    
call testProc3();

# 7의 배수는 제외, 계산값이 1000 이상이면 출력

drop procedure if exists testProc4;

delimiter $$
create procedure testProc4()
begin
    declare i int;
    declare result int;
    set i = 1;
    set result = 0;
    
    mywhile : while (i<=100) do
        if (i%7)=0 then
            set i = i+1;
            iterate mywhile;
        end if;
        
        set result = result + i;
        if result >=1000 then
            leave mywhile;
        end if;
        set i = i+1;
    end while;
    
    select result as '출력';

end $$
delimiter ;

call testProc4();
        

# 오류처리

drop procedure if exists testproc5;

delimiter $$
create procedure testProc5()
begin
    declare continue handler for 1146 select '테이블이 없습니다.' as '메시지';
    insert into aa values(null);
end $$
delimiter ;

call testProc5();


drop procedure if exists testProc6;

delimiter $$
create procedure testProc6()
begin
    declare continue handler for sqlexception 
    begin
        show errors;
        select '오류가 발생하였습니다. 작업을 취소합니다.' as '오류발생';
        rollback;
    end;
        insert into usertbl values('LSG','이상구',1988,'서울',null,null,179, current_date());
    
end $$

delimiter ;

call testProc6();

# 동적 SQL

DROP TABLE IF EXISTS cur_date;

CREATE TABLE cur_date(
id INT AUTO_INCREMENT PRIMARY KEY,
m_date DATETIME
);

PREPARE insert_curdate FROM 'insert into cur_date values(null,?)';

SET @curDATE = CURRENT_TIMESTAMP();

EXECUTE insert_curdate USING @curDATE;

SELECT * FROM cur_date;