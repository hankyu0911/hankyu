#인덱스(Index)
CREATE TABLE indexTBL(
first_name CHAR(20),
last_name CHAR(20),
hire_date DATE
);

INSERT INTO indexTBL 
    SELECT first_name, last_name, hire_date 
    FROM employees.employees
    LIMIT 500;
    
SELECT * FROM indexTBL WHERE first_name ='Mary';

CREATE INDEX index_first_name ON indexTBL(first_name);

SELECT * FROM indexTBL WHERE first_name = 'Mary';

# 뷰(View)
SELECT memberID, memberAddress
FROM memberTBL;

CREATE VIEW vw_memberTBL
AS
    SELECT memberID, memberAddress
    FROM memberTBL;
    
SELECT *
FROM vw_memberTBL;

# 스토어드 프로시저(Stored Procedure)
SELECT * FROM memberTBL WHERE memberName = '당탕이';
SELECT * FROM productTBL WHERE productName = '냉장고';

delimiter //
CREATE PROCEDURE my_Proc()
BEGIN
    SELECT * FROM memberTBL WHERE memberName = '당탕이';
    SELECT * FROM productTBL WHERE productName = '냉장고';
END //
delimiter ;

CALL my_Proc();

# 트리거(Trigger)
CREATE TABLE deleted_member(
memberID CHAR(10) NOT NULL,
memberName CHAR(4) NOT NULL,
memberAddress CHAR(20),
delete_date DATE,
PRIMARY KEY(memberID)
);

delimiter //
CREATE TRIGGER trigger_deleted_member
    AFTER DELETE
    ON memberTBL
    FOR EACH ROW
BEGIN
    INSERT INTO deleted_member VALUES(old.memberID, old.memberName, old.memberAddress, CURDATE());
END //
delimiter ;

SELECT * FROM deleted_member;

INSERT INTO memberTBL VALUES('figure','연아','경기 성남시 분당구');

DELETE FROM memberTBL WHERE memberName = '연아';

SELECT * FROM deleted_member;