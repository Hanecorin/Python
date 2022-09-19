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
-- 설정된 테이블의 제약조건들 조회.
select * from information_schema.table_constraints
where  table_schema='testdb';

create database testdb;
use testdb;
-- parent_tb (부모) ----- child_tb(자식)
-- 제약조건: 컬럼레벨 설정.
create table parent_tb(
	no int primary key,        -- PK 제약조건 컬럼레벨, 테이블레벨 지정
    name varchar(50) not null, -- not null 제약조건은 컬럼레벨로 지정.
    join_date timestamp  default  current_timestamp, -- 날짜/시간 타입의 컬럼에 insert 시점의 일시를 기본값으로 넣을 경우 -> type: timestamp, default 값: current_timestamp
    email varchar(100) unique,  -- UK 제약조건. 컬럼레벨, 테이블레벨 지정
    gender char(1)  not null  check(gender in ('M', 'F')), -- ck. 컬럼레벨, 테이블레벨 지정. check(컬럼명 조건)
    age  int check(age between 10 and 30)  -- age 컬럼은 10 ~ 30 사이의 정수만 가능.
);
insert into parent_tb values (100, '홍길동', '2020-10-10 11:23:22', 'a@a.com', 'M', 20);
insert into parent_tb (no, name, gender, age) values (101, '유관순', 'F', 19);
insert into parent_tb (no, name, gender, age) values (102, '강감찬', 'M', 29);

insert into parent_tb (no, name, email, gender, age) values (103, '이순신', 'a@a.com', 'M', 29);
-- Duplicate entry 'a@a.com' for key 'parent_tb.email'	0.031 sec
insert into parent_tb (no, name, email, gender, age) values (103, '이순신', 'b@a.com', '남', 29);
-- Check constraint 'parent_tb_chk_1' is violated.	0.015 sec
insert into parent_tb (no, name, email, gender, age) values (103, '이순신', 'b@a.com', 'M', 40);
-- Check constraint 'parent_tb_chk_2' is violated.	0.000 sec
select * from parent_tb;

-- 제약조건: 테이블레벨 지정.  
-- 제약조건이름: 테이블명_컬럼명_제약조건타입,  제약조건타입_테이블명_컬럼명
create table child_tb(
	no  int  auto_increment,  -- auto_increment는 자동증가 컬럼. inseert 시 1씩 증가하는 정수를 가진다. PK
    jumin_num  char(14), -- UK
    age int not null, -- CK
	p_no int not null, -- FK (parent_tb.no 참조)
    constraint child_tb_no_pk primary key(no),
    constraint child_tb_jumin_num_uk unique(jumin_num),
    constraint child_tb_age_ck check(age > 0 and age <= 100),
    constraint child_tb_p_no_parent_tb_no_fk  foreign key(p_no) references parent_tb(no) on delete cascade  -- 참조하는 행이 삭제되면 데이터를 같이 삭제.
);
insert into child_tb (jumin_num, age, p_no) values ('111111-2222222', 20, 101);
insert into child_tb (jumin_num, age, p_no) values ('222222-2222222', 25, 102);
insert into child_tb (jumin_num, age, p_no) values ('333333-2222222', 26, 101);
insert into child_tb (jumin_num, age, p_no) values ('333333-3333333', 28, 201);
-- Duplicate entry '333333-2222222' for key 'child_tb.child_tb_jumin_num_uk'	0.031 sec
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`testdb`.`child_tb`, CONSTRAINT `child_tb_p_no_parent_tb_no_fk` FOREIGN KEY (`p_no`) REFERENCES `parent_tb` (`no`) ON DELETE CASCADE)	0.016 sec
select * from child_tb;
select * from parent_tb;
delete from parent_tb where no = 101;
commit;

select * from information_schema.table_constraints
where  table_schema='testdb';

-- TODO
-- 출판사(publisher) 테이블 (부모)
-- 컬럼명                 | 데이터타입      | 제약조건        
-- publisher_no 		| int  			| primary key, 자동증가
-- publisher_name 		| varchar(50)   | not null 
-- publisher_address 	| varchar(100)  |
-- publisher_tel 		| varchar(20)   | not null

create table publisher(
	publisher_no  int  primary key  auto_increment,
    publisher_name  varchar(50)  not null,
    publisher_address varchar(100),
    publisher_tel  varchar(20) not null
);



show tables;
desc publisher; -- 컬럼들 조회

-- 책(book) 테이블 (자식)
-- 컬럼명 		   | 데이터타입            | 제약 조건         |기타 
-- isbn 		   | varchar(13),       | primary key
-- title 		   | varchar(50) 		| not null 
-- author 		   | varchar(50) 		| not null 
-- page 		   | int 		 		| not null, check key-0이상값
-- price 		   | int 		 		| not null, check key-0이상값 
-- publish_date   | timestamp 			| not null, default-current_timestamp(등록시점 일시)
-- publisher_no   | int 		        | not null, Foreign key-publisher

create table book(
	isbn varchar(13) primary key,
    title varchar(50) not null,
    author varchar(50) not null,
    page   int not null check(page > 0),
    price  int not null check(price > 0),
    publish_date timestamp default current_timestamp not null,
    publisher_no  int  not null,
    constraint book_publisher_publisher_no_fk foreign key(publisher_no) references publisher(publisher_no)
);


/* ************************************************************************************
ALTER : 테이블 수정

컬럼 관련 수정

- 컬럼 추가
  ALTER TABLE 테이블이름 ADD COLUMN 추가할 컬럼설정 [,ADD COLUMN 추가할 컬럼설정]
  
- 컬럼 수정
  ALTER TABLE 테이블이름 MODIFY COLUMN 수정할컬럼명 변경설정 [, MODIFY COLUMN 수정할컬럼명  변경설정]
	- 숫자/문자열 컬럼은 크기를 늘릴 수 있다.
		- 크기를 줄일 수 있는 경우 : 열에 값이 없거나 모든 값이 줄이려는 크기보다 작은 경우
	- 데이터가 모두 NULL이면 데이터타입을 변경할 수 있다. (단 CHAR<->VARCHAR 는 가능.)

- 컬럼 삭제	
  ALTER TABLE 테이블이름 DROP COLUMN 컬럼이름 [CASCADE CONSTRAINTS]
    - CASCADE CONSTRAINTS : 삭제하는 컬럼이 Primary Key인 경우 그 컬럼을 참조하는 다른 테이블의 Foreign key 설정을 모두 삭제한다.
	- 한번에 하나의 컬럼만 삭제 가능.
	
  
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
   - ALTER TABLE 테이블명 MODIFY COLUMN 컬럼명 NOT NULL  
   - ALTER TABLE 테이블명 MODIFY COLUMN 컬럼명 NULL
************************************************************************************ */
use shopping;
/*
기존 테이블을 복사한 테이블 생성 - 제약조건은 복사가 안된다. (not null 조건만 복제됨)
create table 이름 
as 
select 문  -- subquery
*/
-- customers/orders 테이블의 구조만 복사한 테이블 생성(not null을 제외한 제약 조건은 copy가 안됨)
create table cust2
as
select * from customers;

select * from cust2;
select * from information_schema.table_constraints where table_name = 'customers';
desc cust2;

create table cust
as 
select * from customers where 1 = 0; -- 테이블의 구조만 복사 (데이터는 복사하지 않는다.)
desc cust;

create table ord
as 
select * from orders where 1 = 0;
desc ord;

-- 제약조건 추가
-- CUST 에 PK 를 추가
alter table cust add constraint cust_pk primary key(cust_id);

-- order - cust fk 설정
alter table ord add constraint ord_cust_fk foreign key(cust_id) references cust(cust_id);

-- 제약조건삭제
alter table ord drop constraint ord_cust_fk;


desc ord;
desc cust;
select * from information_schema.table_constraints where table_name = 'ord';

-- 컬럼 추가
alter table cust add column age int default 0 not null;
alter table cust add column age2 int not null check(age2 > 10);

-- 컬럼 수정 - datatype, null 허용 여부
alter table cust modify column age tinyint not null; -- not null 을 지정하으면 null 허용안함으로 변경.

alter table cust modify column age2 int;   -- 컬럼명  타입; => nullable   컬럼명 타입 not nulll => not null
alter table cust modify column age2 int not null;

alter table cust modify column address varchar(2) not null;

alter table cust2 modify column address varchar(2) not null;
select * from cust2;
-- Data truncated for column 'address' at row 1	0.078 sec
-- 컬럼 이름 변경
alter table cust rename column age to cust_age;  -- age => cust_age

;
-- 컬럼 삭제
alter table cust drop column cust_age;

desc cust;
select * from information_schema.table_constraints where table_name = 'cust';

use hr_join;

-- TODO: emp 테이블의 구조만 복사해서 emp2를 생성 (이후 TODO 문제들은 emp2 테이블을 가지고 한다.)
create table emp2 
as
select * from emp where 1!=1;
select * from emp2;


-- TODO: gender 컬럼을 추가: type char(1)
alter table emp2 add column gender char(1);
desc emp2;

-- TODO: email, jumin_num 컬럼 추가 
--   email varchar(100),  not null  
--   jumin_num char(14),  null 허용 unique
alter table emp2 add column email varchar(100) not null;
alter table emp2 add column jumin_num char(14) unique;

alter table emp2 add column email varchar(100) not null,
				 add column jumin_num char(14) unique;

desc emp2;

-- TODO: emp_id 를 primary key 로 변경
alter table emp2 add constraint emp2_pk primary key(emp_id);
-- alter table emp2 add primary key(emp_id);

desc emp2;
-- TODO: gender 컬럼의 M, F 저장하도록  제약조건 추가
alter table emp2 add constraint emp2_gender_ck check(gender in ('M', 'F'));
 

-- TODO: salary 컬럼에 0이상의 값들만 들어가도록 제약조건 추가
alter table emp2 add constraint emp2_salary_ch check(salary > 0);



-- TODO: email 컬럼에 unique 제약조건 추가.
alter table emp2 add constraint emp2_email_uk unique(email);



-- TODO: emp_name 의 데이터 타입을 varchar(100) 으로 변환
alter table emp2 modify column emp_name varchar(100) not null;

-- TODO: job_id를 not null 컬럼으로 변경
alter table emp2 modify column job_id varchar(30) not null;

-- TODO: job_id  를 null 허용 컬럼으로 변경
alter table emp2 modify column job_id varchar(30);

-- TODO: 위에서 지정한 emp2_email_uk 제약 조건을 제거
alter table emp2 drop constraint emp2_email_uk;

select * from information_schema.table_constraints where table_name = 'emp2';
desc emp2;

-- TODO: 위에서 지정한 emp_salary_ck 제약 조건을 제거
alter table emp2 drop constraint emp2_salary_ch;

-- TODO: gender 컬럼제거
alter table emp2 drop column gender;
desc emp2;



-- TODO: email 컬럼 제거
alter table emp2 drop column email;



create table emp4
as
select * from emp;

select * from emp4;




