/* ***********************************************************************************
테이블 생성
- 구문
create table 테이블 이름(
  컬럼 설정
)
컬럼 설정
- 컬럼명   데이터타입  [default 값]  [제약조건] 
- 데이터타입
- default : 기본값. 값을 입력하지 않을 때 넣어줄 기본값.

제약조건 설정 
- primary key (PK): 행식별 컬럼. NOT NULL, 유일값(Unique)
- unique Key (uk) : 유일값을 가지는 컬럼. null을 가질 수있다.
- not null (nn)   : 값이 없어서는 안되는 컬럼.
- check key (ck)  : 컬럼에 들어갈 수 있는 값의 조건을 직접 설정.
- foreign key (fk): 다른 테이블의 primary key 컬럼의 값만 가질 수 있는 컬럼. 
                    다른 테이블을 참조할 때 사용하는 컬럼.

- 컬럼 레벨 설정
    - 컬럼 설정에 같이 설정
- 테이블 레벨 설정
    - 컬럼 설정 뒤에 따로 설정

- 기본 문법 : constraint 제약조건이름 제약조건타입(지정할컬럼명)  (PK, UK는 이름 없이 바로 설정 가능-컬럼레벨에서)
- 테이블 제약 조건 조회
    - select * from information_schema.table_constraints;

    
테이블 삭제
- 구분
DROP TABLE 테이블이름;

- 제약조건 해제
   SET FOREIGN_KEY_CHECKS = 0;
- 제약조건 설정
   SET FOREIGN_KEY_CHECKS = 1;   
*********************************************************************************** */





-- TODO
-- 출판사(publisher) 테이블
-- 컬럼명                 | 데이터타입        | 제약조건        
-- publisher_no 		| int  			| primary key, 자동증가
-- publisher_name 		| varchar(50)   | not null 
-- publisher_address 	| varchar(100)  |
-- publisher_tel 		| varchar(20)   | not null


-- 책(book) 테이블
-- 컬럼명 		   | 데이터타입            | 제약 조건         |기타 
-- isbn 		   | varchar(13),       | primary key
-- title 		   | varchar(50) 		| not null 
-- author 		   | varchar(50) 		| not null 
-- page 		   | int 		 		| not null, check key-0이상값
-- price 		   | int 		 		| not null, check key-0이상값 
-- publish_date   | timestamp 			| not null, default-current_timestamp(등록시점 일시)
-- publisher_no   | int 		        | not null, Foreign key-publisher




/* ************************************************************************************
ALTER : 테이블 수정

컬럼 관련 수정

- 컬럼 추가
  ALTER TABLE 테이블이름 ADD COLUMN 추가할 컬럼설정 [,ADD COLUMN 추가할 컬럼설정]
  
- 컬럼 수정
  ALTER TABLE 테이블이름 MODIFY COLUMN 수정할컬럼명 변경설정 [, MODIFY COLUMN 수정할컬럼명  변경설정]
	- 숫자/문자열 컬럼은 크기를 늘릴 수 있다.
		- 크기를 줄일 수 있는 경우 : 열에 값이 없거나 모든 값이 줄이려는 크기보다 작은 경우
	- 데이터가 모두 NULL이면 데이터타입을 변경할 수 있다. (단 CHAR<->VARCHAR2 는 가능.)

- 컬럼 삭제	
  ALTER TABLE 테이블이름 DROP COLUMN 컬럼이름 [CASCADE CONSTRAINTS]
    - CASCADE CONSTRAINTS : 삭제하는 컬럼이 Primary Key인 경우 그 컬럼을 참조하는 다른 테이블의 Foreign key 설정을 모두 삭제한다.
	- 한번에 하나의 컬럼만 삭제 가능.
	
  ALTER TABLE 테이블이름 SET UNUSED (컬럼명 [, ..])
  ALTER TABLE 테이블이름 DROP UNUSED COLUMNS
	- SET UNUSED 설정시 컬럼을 바로 삭제하지 않고 삭제 표시를 한다. 
	- 설정된 컬럼은 사용할 수 없으나 실제 디스크에는 저장되 있다. 그래서 속도가 빠르다.
	- DROP UNUSED COLUMNS 로 SET UNUSED된 컬럼을 디스크에서 삭제한다. 

- 컬럼 이름 바꾸기
  ALTER TABLE 테이블이름 RENAME COLUMN 원래이름 TO 바꿀이름;

**************************************************************************************  
제약 조건 관련 수정
-제약조건 추가
  ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건 설정

- 제약조건 삭제
  ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건이름
  PRIMARY KEY 제거: ALTER TABLE 테이블명 DROP PRIMARY KEY 
	- CASECADE : 제거하는 Primary Key를 Foreign key 가진 다른 테이블의 Foreign key 설정을 모두 삭제한다.

- NOT NULL <-> NULL 변환은 컬럼 수정을 통해 한다.
   - ALTER TABLE 테이블명 MODIFY COLUMN 컬럼명 타입 NOT NULL  
   - ALTER TABLE 테이블명 MODIFY COLUMN 컬럼명 NULL
************************************************************************************ */
-- customers/orders 테이블의 구조만 복사한 테이블 생성(not null을 제외한 제약 조건은 copy가 안됨)



-- 제약조건 추가



-- 컬럼 추가




-- 컬럼 수정



-- 컬럼 이름 변경


-- 컬럼 삭제



-- TODO: emp 테이블의 구조만 복사해서 emp2를 생성 (이후 TODO 문제들은 emp2 테이블을 가지고 한다.)


-- TODO: gender 컬럼을 추가: type char(1)


-- TODO: email, jumin_num 컬럼 추가 
--   email varchar(100),  not null  
--   jumin_num char(14),  null 허용 unique



-- TODO: emp_id 를 primary key 로 변경

  
-- TODO: gender 컬럼의 M, F 저장하도록  제약조건 추가

 
-- TODO: salary 컬럼에 0이상의 값들만 들어가도록 제약조건 추가


-- TODO: email 컬럼에 unique 제약조건 추가.


-- TODO: emp_name 의 데이터 타입을 varchar(100) 으로 변환


-- TODO: job_id를 not null 컬럼으로 변경


-- TODO: job_id  를 null 허용 컬럼으로 변경


-- TODO: 위에서 지정한 emp_email_uk 제약 조건을 제거


-- TODO: 위에서 지정한 emp_salary_ck 제약 조건을 제거


-- TODO: gender 컬럼제거


-- TODO: email 컬럼 제거




