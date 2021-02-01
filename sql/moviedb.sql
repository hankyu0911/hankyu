/* 영화사이트(대용량 데이터) 데이터베이스 실습 */

# 데이터베이스 생성 : moviedb
DROP DATABASE IF EXISTS moviedb;
CREATE DATABASE moviedb;
USE moviedb;

# 테이블 생성 : movietbl
DROP TABLE IF EXISTS movietbl;
CREATE TABLE movietbl(
movie_id INTEGER AUTO_INCREMENT PRIMARY KEY,
movie_name VARCHAR(30),
movie_director VARCHAR(20),
movie_actore VARCHAR(20),
movie_script LONGTEXT,
movie_film LONGBLOB);

# 데이터 추가 
INSERT INTO movietbl VALUES(NULL, '쉰들러리스트', '스필버그', '리암 니슨',
    LOAD_FILE('c:/sql/movies/Schindler.txt'),
    LOAD_FILE('c:/sql/movies/Schindler.mp4'));

-- 오류발생 : 업로드 파일 허용 용량 및 폴더 보안 설정 필요 --
SELECT * FROM movietbl;

SHOW VARIABLES LIKE 'max_allowed_packet';
SHOW VARIABLES LIKE 'secure_file_priv';

/* Windows PowerShell 관리자 권한으로 열기(시작-> 마우스 오른쪽 버튼)
    -> cmd 입력 
    -> cd c:\programdata\mysql\mysql server 8.0 (디렉토리 변경)
    -> NOTEPAD my.ini
    -> 'max_allowed_packet' 변수 용량 변경 및 현재 데이터 저장 위치를 보안 폴더 주소에 추가
    -> 컴퓨터 재부팅 or MySQL 데이터베이스 서버 재부팅
*/

# 재설정 후 데이터 입력
INSERT INTO movietbl VALUES(NULL, '쉰들러리스트', '스필버그', '리암 니슨',
    LOAD_FILE('c:/sql/movies/Schindler.txt'),
    LOAD_FILE('c:/sql/movies/Schindler.mp4'));
INSERT INTO movietbl VALUES(NULL, '쇼생크탈출', '프랭크다라본트', '팀 로빈스',
    LOAD_FILE('c:/sql/movies/Shawshank.txt'),
    LOAD_FILE('c:/sql/movies/Shawshank.mp4'));
INSERT INTO movietbl VALUES(NULL, '라스트모히칸', '마이클 안', '다니엘 데이 루이스',
    LOAD_FILE('c:/sql/movies/Mohican.txt'),
    LOAD_FILE('c:/sql/movies/Mohican.mp4'));

SELECT * FROM movietbl;

# 자료 다운로드
SELECT movie_script FROM movietbl WHERE movie_id = 1
    INTO OUTFILE 'c:/sql/movies/Shindler_out.txt'
    LINES TERMINATED BY '\\n';
    
SELECT movie_film FROM movietbl WHERE movie_id = 1
    INTO OUTFILE 'c:/sql/movies/Shindler_out.mp4';
