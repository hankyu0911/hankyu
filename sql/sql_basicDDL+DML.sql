/* bookid 기본키 지정 */
CREATE TABLE NewBook(
bookid INTEGER,
bookname VARCHAR(20),
publisher VARCHAR(20),
price INTEGER,
PRIMARY KEY(bookid));

CREATE TABLE NewBook(
bookid INTEGER PRIMARY KEY,
bookname VARCHAR(20),
publisher VARCHAR(20),
price INTEGER);

/* bookname, pubisher 복합키 지정 */
CREATE TABLE NewBook(
bookid INTEGER,
bookname VARCHAR(20),
publisher VARCHAR(20),
price INTEGER,
PRIMARY KEY(bookname, publisher));

/*bookname은 NULL 값을 가질 수 없고, publisher는 같은 값이 있으면 안 된다. price에 값이 입력되지 않을 경우 기본 값 10000을 저장한다. 또 가격은 최소 1,000원 이상으로 한다. */
CREATE TABLE NewBook(
bookid INTEGER,
bookname VARCHAR(20) NOT NULL,
publisher VARCHAR(20) UNIQUE,
price INTEGER DEFAULT 10000 CHECK (price>1000),
PRIMARY KEY(bookname, publisher));

/* NewCustomer 
 custid(고객번호) - INTEGER, 기본키
 name(이름) – VARCHAR(40)
 address(주소) – VARCHAR(40)
 phone(전화번호) – VARCHAR(30)
*/
CREATE TABLE NewCustomer(
custid INTEGER PRIMARY KEY,
name VARCHAR(40),
address VARCHAR(40),
phone VARCHAR(30));

/* NewOrders 
 orderid(주문번호) - INTEGER, 기본키
 custid(고객번호) - INTEGER, NOT NULL 제약조건, 외래키(NewCustomer.custid, 연쇄삭제)
 bookid(도서번호) - INTEGER, NOT NULL 제약조건
 saleprice(판매가격) - INTEGER 
 orderdate(판매일자) – DATE
*/
CREATE TABLE NewOrders(
orderid INTEGER PRIMARY KEY,
custid INTEGER NOT NULL,
bookid INTEGER NOT NULL,
saleprice INTEGER,
orderdata DATE,
FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE);

/* NewBook 테이블에 VARCHAR(13)의 자료형을 가진 isbn 속성을 추가하시오. */
ALTER TABLE NewBook ADD isbn VARCHAR(13);

/* NewBook 테이블의 isbn 속성의 데이터 타입을 INTEGER형으로 변경하시오. */
ALTER TABLE NewBook MODIFY isbn INTEGER;

/* NewBook 테이블의 isbn 속성을 삭제하시오. */
ALTER TABLE NewBook DROP COLUMN isbn;

/* NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오. */
ALTER TABLE NewBook MODIFY bookid INTEGER NOT NULL;

/* NewBook 테이블의 bookid 속성을 기본키로 변경하시오. */
ALTER TABLE NewBook ADD PRIMARY KEY(bookid);

/* NewBook 테이블을 삭제하시오. */
DROP TABLE NewBook;

/* NewCustomer 테이블을 삭제하시오. 만약 삭제가 거절된다면 원인을 파악하고 관련된 테이블을 같이 삭제하시오 */
DROP TABLE NewCustomer;

DROP TABLE NewOrders;
DROP TABLE NewCustomer;

/* Book 테이블에 새로운 도서 ‘스포츠 의학’을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 90,000원이다. */
INSERT INTO Book(bookid, bookname, publisher, price)
VALUES(11,'스포츠 의학','한솔의학서적',90000);

/* Book 테이블에 새로운 도서 ‘스포츠 의학’을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 미정이다. */
INSERT INTO Book(bookid, bookname, publisher)
VALUES(14,'스포츠 의학','한솔의학서적');

/* 수입도서 목록(Imported_book)을 Book 테이블에 모두 삽입하시오. */
INSERT INTO Book(bookid, bookname, publisher, price)
SELECT bookid, bookname, publisher, price
FROM Imported_book;

/* Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오. */
UPDATE Customer
SET address = '대한민국 부산'
WHERE custid = 5;

/* Book 테이블에서 14번 ‘스포츠 의학’의 출판사를 imported_book 테이블의 21번 책의 출판사와 동일하게 변경하시오. */
UPDATE Book
SET publisher = (SELECT publisher FROM Imported_book WHERE bookid = 21)
WHERE bookid = 14;

/* Book 테이블에서 도서번호가 11인 도서를 삭제하시오. */
DELETE FROM Book
WHERE bookid =11;

/* 모든 고객을 삭제하시오. */
DELETE FROM Customer;

