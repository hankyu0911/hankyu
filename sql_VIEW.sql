/* view */
# book 태이블에서 '축구' 문구가 포함된 자료만 보여주는 뷰
SELECT *
FROM book
WHERE bookname LIKE '%축구%';

CREATE VIEW vw_book
AS SELECT *
FROM book
WHERE bookname LIKE '%축구%';

# 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회, 뷰의 이름은 vw_customer
CREATE VIEW vw_customer
AS SELECT *
FROM customer
WHERE address LIKE '%대한민국%';

SELECT *
FROM vw_customer;

# orders 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, '김연아' 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 표시하시오.
CREATE VIEW vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate
FROM orders od, customer cs, book bk
WHERE od.custid = cs.custid AND od.bookid = bk.bookid;

SELECT orderid, bookname, saleprice
FROM vw_orders
WHERE name = '김연아';

# vw_customer를 영국을 주소로 가진 고객으로 변경하시오. phone 속성은 필요 없으므로 제외
CREATE OR REPLACE VIEW vw_customer(custid, name, address)
AS SELECT custid, name, address
FROM customer
WHERE address LIKE '%영국%';

SELECT *
FROM vw_customer;

# 뷰 vw_customer를 삭제
DROP VIEW vw_customer;