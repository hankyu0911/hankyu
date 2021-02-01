# 피벗(Pivot)
USE sqldb;
DROP TABLE IF EXISTS pivot;

CREATE TABLE pivot(
name CHAR(3),
season CHAR(2),
amount INT
);

INSERT INTO pivot VALUES('김범수','겨울',10);
INSERT INTO pivot VALUES('윤종신','여름',15);
INSERT INTO pivot VALUES('김범수','가을',25);
INSERT INTO pivot VALUES('김범수','봄',3);
INSERT INTO pivot VALUES('김범수','봄',37);
INSERT INTO pivot VALUES('윤종신','겨울',40);
INSERT INTO pivot VALUES('김범수','여름',14);
INSERT INTO pivot VALUES('김범수','겨울',22);
INSERT INTO pivot VALUES('윤종신','여름',64);

SELECT name, 
    SUM(IF(season = '봄',amount,0)) AS '봄',
    SUM(IF(season = '여름',amount,0)) AS '여름',
    SUM(IF(season = '가을',amount,0)) AS '가을',
    SUM(IF(season = '겨울',amount,0)) AS '겨울',
    SUM(amount) AS '합계'
    FROM pivot
    GROUP BY name;
    
# JSON : 웹과 모바일 응용프로그램 등과 데이터를 교환하기 위한 개방형 표준 포맷

SELECT JSON_OBJECT('name',name,'height',height)
FROM usertbl
WHERE height>=180;

SET @json = '{ "usertbl" : 
    [
    {"name" : "임재범", "height" : 182},
    {"name" : "이승기", "height" : 182},
    {"name" : "성시경", "height" : 186}
    ]
    }';
# JSON 데이터형 확인 
SELECT JSON_VALID(@json);

# 데이터 위치 검색
SELECT JSON_SEARCH(@json,'one','성시경');

# 데이터 검색
SELECT JSON_EXTRACT(@json,'$.usertbl[0].name');

# 데이터 추가
SELECT JSON_INSERT(@json,'$.usertbl[0].mdate','2020-01-01');

# 데이터 수정
SELECT JSON_REPLACE(@json,'$.usertbl[2].name','홍길동');

# 데이터 삭제
SELECT JSON_REMOVE(@json,'$.usertbl[2]');
