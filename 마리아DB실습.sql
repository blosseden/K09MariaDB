/*
블럭단위 주석
*/
#라인단위 주석1
-- 라인단위 주석2

SELECT * FROM ts_test;

#모델1방식(JSP) + MariaDB 를 이용한 게시판
#회원테이블(부모테이블)
CREATE TABLE member
(
	id VARCHAR(30) NOT NULL,     
	pass VARCHAR(30) NOT NULL,    
	name NVARCHAR(30) NOT NULL,  
	regidate datetime DEFAULT current_timestamp,  
						/* 현재 시간을 디폴트로 사용 
							datatime : 날짜와 시간을 동시에 표현 할 수 있는 자료형*/ 
	PRIMARY KEY (id)
);

#게시판 테이블(자식) 한글이 다 이딴 식으로 나오네
/*
	AUTO_INCREMENT : 와클의 시퀀스를 대체 할 수 있는 속성으로
		지정된 컬럼은 자동으로 값이 증가하게 된다. 단 자동증가로
		지정된 컬럼은 데이터를 임의로 삽입 할 수 없게 된다.
*/
CREATE TABLE board
(
	num int NOT NULL auto_increment,            
	title VARCHAR(100) NOT NULL,   
	content text NOT NULL, 
	postdate datetime DEFAULT current_timestamp, 
	id VARCHAR(30) NOT NULL,   
	visitcount MEDIUMINT NOT NULL DEFAULT 0,
	PRIMARY KEY (num)       
);


--외래키--

#회원테이블과 게시판 테이블의 참조 제약조건
ALTER TABLE board ADD constraint fk_board_member
	FOREIGN KEY (id) REFERENCES member (id);
	
#더미데이터 삽입
INSERT INTO member (id, pass, NAME) VALUES ('kosmo', '1234', '코스모61');
#member 테이블과 외래키 제약조건이 있으므로 board테이블에
#먼저 삽입 할 경우 에러가 발생된다.
INSERT INTO board (title, content, id)
	VALUES ('제목임다1', '내용임다1', 'kosmo');
INSERT INTO board (title, content, id)
	VALUES ('제목임다2', '내용임다2', 'kosmo');
INSERT INTO board (title, content, id)
	VALUES ('제목임다3', '내용임다3', 'kosmo');
INSERT INTO board (title, content, id)
	VALUES ('제목임다4', '내용임다4', 'kosmo');
INSERT INTO board (title, content, id)
	VALUES ('제목임다5', '내용임다5', 'kosmo');

#데이터타입의 종류
#숫자형
CREATE TABLE tb_int (
   idx INT PRIMARY KEY AUTO_INCREMENT,
   
   num1 TINYINT UNSIGNED NOT NULL,
   num2 SMALLINT NOT NULL,
   num3 MEDIUMINT DEFAULT '100',
   num4 BIGINT ,
   
   fnum1 FLOAT(10,5) NOT NULL,
   fnum2 DOUBLE(20,10)

);

INSERT INTO tb_int (num1, num2, num3, num4, fnum1, fnum2)
   VALUES (100, 12345, 1234567, 1234567890,
      12345.12345, 1234567890.1234567891);
SELECT * FROM tb_int;

/* 자동증가 컬럼에 임의의 값을 삽입 할 수 있으나 사용하지
않는 것이 좋다*/
 INSERT INTO tb_int (idx,num1, num2, num3, num4, fnum1, fnum2)
   VALUES (2, 100, 12345, 1234567, 1234567890,
      12345.12345, 1234567890.1234567891);

#빈값은 삽입 할 수 없다. 오류발생됨.
INSERT INTO tb_int (idx,num1, num2, num3, num4, fnum1, fnum2)
       '', 100, 12345, 1234567, 1234567890,
      12345.12345, 1234567890.1234567891);
      
#날짜형
CREATE TABLE tb_date (
   idx INT PRIMARY KEY AUTO_INCREMENT,
   
   DATE1 DATE NOT NULL,
   DATE2 DATETIME DEFAULT CURRENT_TIMESTAMP
);

/*
   날짜타입의 컬럼에 현재 날짜 를 입려할 때 오라클은 sysdate를
   사용하지만 MySQL은 now() 함수를 사용한다.
*/
INSERT INTO tb_date (DATE1, DATE2)
   VALUE('2020-05-27', NOW());
   
SELECT * FROM tb_date;
/*
   시간변환 함수 date_format(컬럼명, '서식')
*/
SELECT DATE_FORMAT(DATE2,'%Y-%m-%d') FROM tb_date; #년-월-일
SELECT DATE_FORMAT(DATE2,'%H:%i:%s') FROM tb_date; #시:분:초

#특수형
CREATE TABLE tb_spec (
idx INT AUTO_INCREMENT,

spec1 ENUM('M','W','T'),
spec2 SET('A','B','C','D'),

PRIMARY KEY (idx)
);
#설정된 값중 선택해서 입력
INSERT INTO tb_spec (spec1, spec2)
   VALUES ('W', 'A,B,D');
   
SELECT * FROM tb_spec;
#spec1는 디폴트가 설정 되었으므로 자동입력
INSERT INTO tb_spec (spec2)
   VALUES ('A,B,C');

#설정되지 않은 값으로 입력시 오류발생
INSERT INTO tb_spec (spec1, spec2)
   VALUES ('A', 'A,B,E');
   
/*
Model1 방식의 게시판을 MariaDB로 컨버팅
*/

-- 전체 레코드 수 조회
SELECT COUNT(*) FROM board;
SELECT COUNT(*) FROM board WHERE title LIKE '%임다1%';

-- 페이지 처리를 위하 쿼리문 (오라클과 다름)
SELECT * FROM board ORDER BY num DESC;
-- 한페이지에 2개의 게시물이 출력 된다고 가정했을 때

/*
   페이지처리를 위해 게시물의 범위를 정할 때 Oracle 은 rouwnum의
   속성을 사용하지만 MariaDB는 limit를 사용한다.
   방법 : limit 시작인덱스, 가져올 레코드 갯수
   
*/
-- 1 페이지 레코드 셋
SELECT * FROM board ORDER BY num DESC LIMIT 0, 2;

-- 2페이지 레코드 셋
SELECT * FROM board ORDER BY num desc LIMIT 2, 2;

-- 3페이지 레코드 셋
SELECT * FROM board ORDER BY num DESC LIMIT 4, 2;

-- 상세보기 처리 - 조회수 업데이트
UPDATE board SET visitcount=visitcount+1 WHERE num=2;

SELECT * FROM board WHERE num=2;

--회원테이블과 게시판 테이블 내부조인을 통한 조회
#표준방식
SELECT
   B.*, M.name
FROM member M INNER JOIN board B
   ON M.id=B.id
WHERE num=2;

#간단한 방식
SELECT
FROM member M, board B
WHERE
   M.id=B.id AND num=2;