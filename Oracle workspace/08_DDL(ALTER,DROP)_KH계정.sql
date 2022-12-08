/*
    *DDL(DATA DEFINITION LANGUAGE)
    데이터 정의 언어
    객체들을 새롭게 생성(CREATE)하고, 수정(ALTER),삭제(DROP)하는 구문
    
    1.ALTER
    객체 구조를 수정하는 구문
    <테이블 수정>
    [표현법]
    ALTER TABLE 테이블명 수정할내용;
    
    -수정내용
    1)컬럼추가/수정/삭제
    2)제약조건 추가/삭제 -> 수정 불가
    3)테이블명/컬럼명/제약조건명 수정
*/

--1)컬럼 추가 수정 삭제
--1_1) 컬럼 추가(ADD): ADD 추가할 컬럼명 자료형 DEFAULT 기본값 (DEFAULT 생략가능)
SELECT * FROM DEPT_COPY;

--CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--새로운 컬럼이 추가되고 기본값으로 널이 들어감

--LNAME 컬럼을 DEFAULT 설정 후 추가
ALTER TABLE DEPT_COPY AND LNAME VARCHAR2(20) DEFAULT '기본값';
             
--1_2) 컬럼 수정(MODIFY)
-- 컬럼의 자료형 수정: MODIFY 수정할 컬럼명 바꾸고자하는 자료형
-- 컬럼의 DEFAULT값 수정: MODIFY 수정할 컬럼명 DEFAUL 로 바꾸고자 하는 기본값

--DEPT_COPY 테이블의 DEPT_ID 컬럼의 자료형을 CHAR(3)으로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
 
SELECT DEPT_ID
FROM LEFT_COPY;
--기존에 담겨있던 데이터 타입과 전혀다른 데이터 타입으로는 변경X
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--현재 변경하고자 하는 컬럼에 이미 담겨있는 값보다 더 작은 크기로 변경X

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1); 
--문자->숫자 변경 불가/ 문자열 사이즈 축소 불가 // 문자열 사이즈는 확대 가능

--한번에 여러개의 컬럼 변경해보기
--DEPT_TITLE 컬럼의 데이터 타입을 VARCHAR2(40)으로
--LOCATION_ID 컬럼의 데이터타입을 VARCHAR2(2)로
--LNAME 컬럼의 기본값을 '미국'으로 변경

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE AND VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '미국'

SELECT*
FROM DEPT_COPY;

--1_3)컬럼삭제(DROP COLUMN): DROP COLUMN 삭제하고자 하는 컬럼명
--복사테이블 생성
CREATE TABLE DEPT_COPY2
AS SELECT*
FROM DEPT_COPY;

SELECT *
FROM(DEPT_COPY2)
--DEPT_COPY2에서 DEPT_ID컬럼 삭제

ALTER TABLE DEPT_CODE2 DROP COLUMN DEPT_ID;                                                                                                                                                                                                                   

--DDL구문을 실행하면 복구 불가능
ROLLBACK;

--모든 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP DEPT_TITLE;

--CANNOT DROP ALL COLUMNS IN A TABLE
--마지막 컬럼 삭제하려고 하면 오류:: 테이블에 최소 한개의 컬럼은 남아 있어야 하기 땜ㄴ

--2)제약조건 추가/삭제
/*
    2_2)제약조건 추가
    
    -PRIMARY KEY: ADD PRIMARY KEY(컬럼명);
    -FOREIGN KEY: ADD FOREIGN KEY(컬럼명 REFERENCES 참조할 테이블명(참조컬럼명) - 참조할 컬럼명 생략 ㄱㄴ);
    -UNIQUE: ADD UNIQUE(컬럼명);
    -CHECK: ADD CHECK(컬럼에 대한 조건);
    -NOT NULL: MODIFY 컬럼명 NOT NULL;
    
    나만의 제약조건 부여
    CONSTRAINT 제약조건명 (제약조건 앞에 작성)
    -제약조건명 생략 가능
    -주의) 현재 계정내에서 고유한 이름으로 작성해야함
*/

--DEPT_COPY테이블로부터
--DEPT_ID컬럼에 PRIMARY KEY 추가
--DEPT_TITLE에 UK추가
--LNAME 컬럼에 NOTNULL추가
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_PK 
ADD CONSTRAINT D



/*
    2_2) 제약조건 삭제
    
    PK, FK,UK,CK: DROP CONSTRAINT 제약조건명;
    NOT NULL: NODIFY 컬럼명 NULL;
*/

--DEPT_COPY 테이블
--DCOPY_PK 제약조건 지우기
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

--DCOPY_UQ 지우기
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ
--LNAME NOT NULL 변경해보기
MODIFY LNAME NULL;

  --3)컬럼명/제약조건명/테이블명 변경(RENAME)
  
  --3-1)컬럼명 변경: RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
  --DEPT_COPY 테이블에 DEPT_TITLE 컬럼을 DEPT_NAME으로 변경해보기
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT * FROM DEPT_COPY;
--3-2)제약조건명 변경: RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
--DEPT_COPY SYS_C007308을 LOCATION_ID_NN으로 변경
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007308 TO LOCATION_ID_NN;

--3-3)테이블명 변경: RENAME TO 바꿀테이블명
--DEPT_COPY 테이블을 DEPT_TEST로 변경
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

SELECT * FROM DEPT_COPY;
SELECT * FROM DEPT_TEST;

--DEPT_TEST 테이블에서 DEPT_ID를 DEPT_NO로 DEPT_ID에 걸린 NOT NULL제약조건명을 DEPT_ID_NN으로
ALTER TABLE DEPT_TEST RENAME COLUMN DEPT_ID TO DEPT_NO;
ALTER TABLE DEPT_TEST RENAME CONSTRAINT SYS_C007307 TO DEPT_ID_NN;
--테이블 명을 DEPT_COPY로 변경하기
ALTER TABLE DEPT_TEST RENAME TO DEPT_COPY;

/*
    2.DROP
    객체를 삭제하는 구문
    
    [표현법]
    DROP TABLE 삭제하고자 하는 테이블 이름;
    
*/
--EMP_NEW2 라는 테이블 삭제
DROP TABLE EMP_NEW2;

--부모테이블을 삭제할 경우는?
--DEPT_COPY 테이블에 DEPT_NO컬럼을 PRIMARY KEY 제약조건 추가
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_NO);

--EEMP_COPY3 외래키(DEPT_CODE)를 추가 (외래키 이름 ECOPY_FK)
--부모테이블은 DEPT_COPY 컬럼은 DEPT_NO
ALTER TABLE EMP_COPY3 
ADD CONSTRAINT ECOPY_FK FOREIGN KEY (DEPT_CODE) REPERENCES DEPT_COPY(DEPT_NO);

--부모테이블 삭제
DROP TABLE DEPT_COPY;
--UK,PK IN TABLE REFERENCED BY FOREIGH KEYS
--어딘가에 참조되고있는 부모테이블은 삭제X
--그럼에도 삭제하고 싶다면
--방법1) 자식테이블 삭제 후 부모테이블 삭제
DROP TABLE 자식테이블;
DROP TALBE 부모테이블;

--방법2) 부모테이블만 삭제하되 맞물려있는 외래키 제약조건도 함께 삭제
--DROP TABLE 부모테이블 CASCADE CONSTRAINT;
DROP TABLE DEPT_COPY CASCADE CONSTRAINT;





