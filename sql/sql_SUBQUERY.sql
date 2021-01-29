/* 스칼라 부속질의(scalar subquery) */

# 고객별 판매액 검색(고객이름, 고객별 판매액 명시)
SELECT custid, SUM(saleprice)
FROM orders
GROUP BY custid;

SELECT (SELECT name FROM customer cs WHERE cs.custid = od.custid) 'name', SUM(saleprice) 'total'
FROM orders od
GROUP BY od.custid;

# orders 테이블에 각 주문에 맞는 도서이름을 입력하시오.
ALTER TABLE orders ADD bookname VARCHAR(20);
UPDATE orders
SET bookname = (SELECT bookname FROM book WHERE orders.bookid = book.bookid);

SELECT * 
FROM orders;

/* 인라인 뷰(INLINE VIEW) */

# 고객번호가 2 이하인 고객의 판매액 검색(고객 이름과 판매액 명시)
SELECT custid, SUM(saleprice)
FROM orders
WHERE custid<=2
GROUP BY custid;

SELECT cs.name, SUM(saleprice)
FROM (SELECT name, custid FROM customer WHERE custid<=2) cs, orders od
WHERE cs.custid = od.custid
GROUP BY cs.name;

/* 중첩질의(Nested subquery) */

# 평균 주문금액 이하의 주문에 대하여 주문번호와 금액 검색 
SELECT orderid, saleprice
FROM orders 
WHERE saleprice <=(SELECT AVG(saleprice) FROM orders );

# 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대하여 주문번호, 고객번호, 금액 검색 
SELECT orderid, custid, saleprice
FROM orders od
WHERE saleprice > (SELECT AVG(saleprice) FROM orders od2 WHERE od.custid = od2.custid);

#대한민국에 거주하는 고객에게 판매한 도서의 총판매액 검색
SELECT SUM(saleprice)
FROM orders od
WHERE od.custid IN (SELECT custid FROM customer cs WHERE cs.address LIKE '%대한민국%');

# 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문번호와 금액 검색 
SELECT orderid, saleprice
FROM orders od
WHERE od.saleprice > (SELECT MAX(saleprice) FROM orders od2 WHERE od2.custid = 3);

SELECT orderid, saleprice
FROM orders od
WHERE saleprice > ALL (SELECT saleprice FROM orders od2 WHERE od2.custid = 3);

# EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액 검색 
SELECT SUM(saleprice)
FROM orders od
WHERE EXISTS(SELECT * FROM customer cs WHERE cs.address LIKE '%대한민국%' AND cs.custid = od.custid);



