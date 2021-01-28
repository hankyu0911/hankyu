/* 모든 도서 이름과 가격 */
SELECT	bookname, price
FROM 	book;

/* 모든 도서 가격과 이름 */
SELECT	price, bookname
FROM	book;

/*모든 도서 도서번호, 도서이름, 출판사, 가격 */
SELECT	bookid, bookname, publisher, price
FROM	book;

SELECT	*
FROM	book;

/* 도서 테이블에 있는 모든 출판사 */
SELECT DISTINCT	publisher 
FROM	book;

/* 가격이 20,000원 미만인 도서 검색 */
SELECT	* 
FROM	book
WHERE	price<20000;

/* 가격이 10,000원 이상 20,000원 이하인 도서 검색 */
SELECT	*
FROM	book
WHERE	price BETWEEN 10000 and 20000;

SELECT	*
FROM	book
WHERE	price>10000 and price<=20000;

/* 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서 검색 */
SELECT	*
FROM	book
WHERE	publisher IN ('굿스포츠','대한미디어');

/* 출판사가 '굿스포츠', '대한미디어'가 아닌 도서 검색 */
SELECT	*
FROM	book
WHERE	publisher NOT IN ('굿스포츠','대한미디어');

/* '축구의 역사'를 출판한 출판사 검색 */
SELECT	publisher
FROM	book
WHERE	bookname LIKE '축구의 역사';

/* 도서이름에 '축구'가 포함된 출판사를 검색 */
SELECT	publisher
FROM	book
WHERE 	bookname LIKE '%축구%';

/* 도서이름 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서 검색 */
SELECT 	*
FROM 	book
WHERE 	bookname LIKE '_구%';

/* 축구에 관한 도서 중 가격이 20,000원 이상인 도서 검색 */
SELECT 	*
FROM	 book
WHERE 	bookname LIKE '%축구%' and price>=20000;

/* 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서 검색 */
SELECT	 *
FROM 	book
WHERE 	publisher in ('굿스포츠', '대한미디어');

SELECT 	*
FROM	 book
WHERE 	publisher = '굿스포츠' or publisher = '대한미디어';

/* 도서를 이름순으로 검색 */
SELECT 		*
FROM 		book
ORDER BY 	bookname;

/* 도서를 가격순으로 검색, 가격이 같으면 이름순으로 검색 */
SELECT 	*
FROM 	book
ORDER BY	price, bookname;

/* 도서를 가격의 내림차순으로 검색, 가격이 같으면 출판사의 오름차순으로 검색 */
SELECT 	*
FROM 	book
ORDER BY	price DESC, price ASC;

/* 고객이 주문한 도서의 총 판매액 */
SELECT SUM(saleprice) as 총매출
FROM orders;

/* 2번 김연아 고객이 주문한 도서의 총 판매액 */
SELECT SUM(saleprice) as 총매출
FROM orders
WHERE custid =2;

/* 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가 검색 */
SELECT SUM(saleprice), AVG(saleprice), MIN(saleprice), MAX(saleprice)
FROM orders;

/* 도서 판매 건수 검색 */
SELECT COUNT(*)
FROM orders;

/* 고객별로 주문한 도서의 총 수량과 총 판매액 검색 */
SELECT custid, COUNT(*) as 총수량, SUM(saleprice) as 총매출
FROM orders
GROUP BY custid;

/* 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량 검색 (단 두 권 이상 구매한 고객만) */
SELECT custid as 고객번호, COUNT(*) as 총수량
FROM orders
WHERE saleprice >=8000
GROUP BY custid
HAVING COUNT(*)>=2;

/* 고객과 고객 주문에 관한 데이터 검색 */
SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid;

/* 고객과 고객 주문 데이터를 고객번호 순으로 정렬 */
SELECT *
FROM customer, orders
WHERE customer.custid =orders.custid
ORDER BY customer.custid;

/* 고객의 이름과 고객이 주문한 도서의 판매가격 검색 */
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

/* 고객별로 주문한 모든 도서의 총 판매액을 고객별로 정렬하여 검색 */
SELECT name, SUM(saleprice)
FROM customer,orders
WHERE customer.custid=orders.custid
GROUP BY customer.name
ORDER by customer.name;

/* 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름 검색 */
SELECT name, bookname
FROM customer, book, orders
WHERE customer.custid = orders.custid and book.bookid = orders.bookid and book.price = 20000;

/* 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 검색 */
SELECT name, saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid = orders.custid;

/* 가장 비싼 도서의 이름 */
SELECT bookname 
FROM book
WHERE price = (SELECT max(price) FROM book );

/* 도서를 구매한 적이 있는 고객의 이름 검색 */
SELECT DISTINCT name
FROM customer, orders
WHERE customer.custid = orders.custid;

SELECT name
FROM customer
WHERE custid in (SELECT custid FROM orders);

/* 대한미디어에서 출판한 도서를 구매한 고객의 이름 검색 */
SELECT name
FROM customer
where customer.custid in (SELECT custid from orders where bookid in (SELECT bookid FROM book WHERE publisher LIKE '대한미디어'));

SELECT name
FROM customer, book, orders
WHERE book.publisher LIKE '대한미디어' and book.bookid = orders.bookid and customer.custid = orders.custid;

/* 출판사별로 출판사의 평균 도서 가격보다 비싼 도서 검색 */
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(price) FROM book b2 WHERE b2.publisher = b1.publisher);

/* 대한민국에 거주하는 고객의 이름과 도서를 주문한 고객의 이름 검색 */
SELECT name 
FROM customer
WHERE address LIKE '%대한민국%';

SELECT name
FROM customer
WHERE custid in (SELECT custid FROM orders);

SELECT name
FROM customer
WHERE address LIKE '%대한민국%'
UNION
SELECT name
FROM customer
WHERE custid in (SELECT custid FROM orders);

/* 주문이 있는 고객의 이름과 주소 검색 */
SELECT name, address
FROM customer
WHERE custid in (SELECT custid FROM orders);

SELECT name, address
FROM customer cs
WHERE EXISTS (SELECT * FROM orders od where od.custid = cs.custid);
