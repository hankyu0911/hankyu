/* 내장함수 */

# -78과 78의 절댓값
SELECT ABS(-78);
SELECT ABS(78);

# 4.875를 소수 첫째 자리까지 반올림 
SELECT ROUND(4.875,1);

#고객별 평균 주문 금액을 백 원 단위로 반올림한 값 검색
SELECT custid,ROUND(AVG(saleprice),-2)
FROM orders
GROUP BY custid;

#도서제목에 야구가 포함된 도서를 농구로 변경 후 도서목록 표시
SELECT bookid, REPLACE(bookname,'야구','농구') bookname, publisher, price
FROM book;

#굿스포츠에서 출판한 도서의 제목과 제목의 글자 수 확인
SELECT bookname,CHAR_LENGTH(bookname) '글자수', LENGTH(bookname) '바이트'
FROM book
WHERE publisher LIKE '굿스포츠';

# 고객 중 성(姓)별 인원수 
SELECT SUBSTR(name,1,1),COUNT(*)
FROM customer
GROUP BY SUBSTR(name,1,1);

# 각 주문 확정일자(=주문일로부터 10일 후)
SELECT orderid '주문번호', orderdate '주문날짜', ADDDATE(orderdate, INTERVAL 10 DAY) '확정일자'
FROM orders;

# 2014-7-7일 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호 
SELECT orderid, orderdate, custid, bookid
FROM orders
WHERE orderdate = DATE_FORMAT('20140707','%Y%m%d');

#DBMS 서버에 설정된 현재 날짜와 시간, 월 이름을 확인
SELECT SYSDATE(), DATE_FORMAT(SYSDATE(),'%Y%m%d %M %H:%m:%s');

# MyBook
CREATE TABLE MyBook(
bookid INTEGER PRIMARY KEY,
price INTEGER);

INSERT INTO MyBook(bookid,price)
VALUES(1,10000),(2,20000),(3,NULL);

SELECT *
FROM MyBook;

#Null값은 연산 불가
SELECT price+100
FROM MyBook
WHERE bookid = 3;

#집계 함수 계산 시 NULL 포함 행 제외
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
FROM MyBook;

#해당 행 존재하지 않을 경우 NULL 반환
SELECT SUM(price), AVG(price)
FROM MyBook
WHERE bookid >=4;

#IS NULL
SELECT *
FROM MyBook
WHERE price IS NULL;

#NULL != ' '
SELECT *
FROM MyBook
WHERE price = ' ';

#IS NOT NULL
SELECT *
FROM MyBook
WHERE price IS NOT NULL;

#이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시
SELECT custid, name, address, IFNULL(phone,'연락처없음') phone
FROM customer;

#고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 검색
SET @seq:=0;
SELECT (@seq:=@seq+1) '순번', custid, name, phone
FROM customer
WHERE @seq<2;
