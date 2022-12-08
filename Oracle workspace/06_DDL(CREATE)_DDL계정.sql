/*
    DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    
    오라클에서 제공하는 객체(OBJECT)를 새로이 만들고(CREATE)
    구조를 변경하고(ALTER),구조 자체를 삭제(DROP)하는 명령문
    구조 자체를 정의하는 언어로 DB관리자,설계자가 사용한다.
    
    오라클에서 객체(DB를 이루는 구조물들)
    테이블(TABLE), 사용자(USER),함수(FUNCTION),뷰(VIEW),시퀀스(SEQUENCE),...
*/


/*
    < CREATE TABLE > 
    테이블 : 행(ROW), 열(COLUMN) 로 구성되는 가장 기본적인 데이터베이스 객체 종류 중 하나.
            모든 데이터는 테이블을 통해서 저장된다.(데이터를 조작하고자 하려면 무조건 테이블을 만들어야 함)
            
    [표현법]
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        컬럼명 자료형.
        ...
    );
    
    <자료형>
    -문자 (CHAR(크기)/VARCHAR2(크기)) : 크기는 BYTE수 (숫자,영문자,특수문자-> 1글자당 1BYTE / 한글 -> 3BYTE)
    
    CHAR(바이트수) : 최대 2000BYTE까지 지정가능 고정길이(아무리 적은 값이 들어와도 공백으로 채워서 처음 할당한
                    크기를 유지하겠다.)
                    주로 들어올 값의 글자수가 정해져 있을 경우 사용한다.
                    EX) 성별 : 남/여 , M/F
                        주민번호 : 6-7 14글자 -14BYTE
    
    VARCHAR2(바이트수): 최대 4000BYTE까지 지정 가능하며 가변길이(적은 값이 들어온경우
                        그 값에 맞춰 크기가 줄어든다.)
                        주로 들어올 값의 글자수가 정해지지 않은 경우 사용
                        EX)이름,아이디,비밀번호 ...
    -숫자
    NUMBER : 정수/실수 상관없이 NUMBER
    
    -날짜
    DATE : 년/월/일/시/분/초 형식으로 시간 지정.
*/

--회원들의 데이터 (아이디,비밀번호,이름,생년월일)를 담을 수 있는 테이블 MEMBER를 생성해보자.
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20), --대소문자 구분이 되지 않기 때문에 낙타봉표기법을 해봐야 의미가 없다. _ 언더바로 구분
    MEMBER_PW VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_BDATE DATE
);
--동일한 테이블명은 사용할 수 없다.

SELECT *
FROM MEMBER;
--USER_TABLES : 현재 이 사용자 계정이 가지고 있는 테이블 구조를 확인할 수 있다
SELECT *
FROM USER_TABLES;

/*
    컬럼에 주석달기(컬럼 설명)
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PW IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_BDATE IS '생년월일';

SELECT *
FROM MEMBER;

--INSERT (데이터를 추가할 수 있는 구문) - DML문
--한 행으로 추가(행을 기준으로 추가),추가할 값을 기술(값의 순서를 지켜야한다)
--INSERT INTO 테이블명 VALUES(첫번째컬럼값,두번째컬럼값,....);
INSERT INTO MEMBER VALUES('user01','pass01','김유저','1999-01-05');
INSERT INTO MEMBER VALUES('user02','pass02','박보검','1994-05-05');
INSERT INTO MEMBER VALUES('user03','pass03','김유정',SYSDATE);

SELECT *
FROM MEMBER;  

INSERT INTO MEMBER VALUES(NULL,NULL,'김유저','1999-01-05');
INSERT INTO MEMBER VALUES('user03','pass05','김유저','1999-01-05');

--유효한 데이터를 유지하기 위해 제약조건을 걸어야 한다.

/*
    < 제약조건 CONSTRAINTS >
    -원하는 데이터값만 유지하기 위해 특정 컬럼마다 설정하는 제약
    -제약조건이 부여된 컬럼에 들어올 데이터에 문제가 있는지 없는지 자동으로 검사할 목적
    EX) NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY 
*/

/*
    NOT NULL 제약조건
    해당 컬럼에 반드시 값이 존재해야만 할 경우 사용
    ->즉 NULL값이 절대 들어와서는 안되는 컬럼에 부여하는 제약조건.
        삽입/수정시 NULL값을 허용하지 않도록 제약조건을 걸어준다.
*/

--NOT NULL제약조건을 설정한 테이블 만들기
--컬럼레벨 방식 : 컬럼명 자료형 제약조건 ->제약조건을 부여하고자 하는 컬럼 뒤에 기술
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(50)
);

SELECT*
FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1,'user01','pass01','김날씨','남','010-2222-3333','서울 영등포구 당산동');

--NOT NULL제약조건이 걸린 컬럼에 NULL값을 넣어보자.
INSERT INTO MEM_NOTNULL VALUES(NULL,NULL,NULL,'김날씨','남','010-2222-3333','서울 영등포구 당산동');

INSERT INTO MEM_NOTNULL VALUES(2,'ASD','PWD','김알렉산더',NULL,NULL,NULL);
INSERT INTO MEM_NOTNULL VALUES(3,'AWQD','DDWD','김에스더','여',NULL,'분당');
--NOT NULL제약조건이 부여되지 않은 경우 NULL이여도 되고 NULL이 아니여도 된다.

/*
    2.UNIQUE 제약조건
      컬럼에 중복값을 제한하는 제약조건
      삽입 / 수정시 기존에 해당 컬럼값 중에 중복값이 있을 경우
      추가 또는 수정이 되지 않게 제약한다.
      
      컬럼 레벨 방식/테이블 레벨 방식 둘다 가능

*/
-- 한개의 컬럼에 여러개의 제약조건을 걸 수 있다.
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --컬럼 레벨 방식
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(50)
);

--DROP 구문으로 테이블 삭제
DROP TABLE MEM_UNIQUE;

--테이블 레벨 방식 : 컬럼들을 전부 나열한뒤 마지막에 제약조건을 나열
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(50),
    UNIQUE(MEM_ID) -- 테이블 레벨 방식
);

INSERT INTO MEM_UNIQUE VALUES(3,'AWQD','DDWD','김에스더','여',NULL,'분당');
INSERT INTO MEM_UNIQUE VALUES(3,'AWQD','DDWD','김에스더','여',NULL,'분당');

/*
    제약조건 부여시 제약조건명도 지정하기
    만약 지정해주지 않는다면 시스템에서 알아서 임의의 이름을 지어준다. EX)SYS_C007560
    
    -컬럼레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 제약조건1 제약조건2
        컬럼명 자료형 CONSTRAINT 제약조건명 제약조건,
        컬럼명 자료형,
        ....
    );
    
    -테이블레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        컬럼명 자료형,
        ...
        컬럼명 자료형,
        CONSTRAINT 제약조건명 제약조건(컬럼명)
    );
    
    -두 방식 모두 CONSTRAINT 제약조건명 생략가능 
*/

CREATE TABLE MEM_CON_NM(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL, --컬럼레벨방식
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(50),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID) -- 테이블 레벨 방식
);

INSERT INTO MEM_CON_NM VALUES(1,'ASD','QWSDE','김차장',NULL,NULL,NULL);


INSERT INTO MEM_CON_NM VALUES(2,'USER11','QWSDE','김테스트','호',NULL,NULL);

SELECT *
FROM MEM_CON_NM;

/*
    3.CHECK 제약조건
    컬럼에 기록될수 있는 값에 대한 조건을 설정할 수 있다.
    예)성별 '남' 또는 '여'만 들어올 수 있게 설정
    [표현법]
    CHECK(조건식)
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(50),
    MEM_DATE DATE NOT NULL --회원가입일 
);
--회원가입일 -> 회원테이블에 데이터가 INSERT되는 순간. SYSDATE
INSERT INTO MEM_CHECK VALUES(1,'USER1','PW222','박점심','호','010-3333-7777','서울특별시 강남구 역삼동',SYSDATE);
--check constraint (DDL.SYS_C007571) violated : CHECK 제약조건을 위배했다.
INSERT INTO MEM_CHECK VALUES(1,'USER1','PW222','박점심','남','010-3333-7777','서울특별시 강남구 역삼동',SYSDATE);
--CHECK 제약조건은 NULL값을 허용한다. 만약 NULL값을 허용하고 싶지 않다면 NOT NULL제약조건을 걸면 된다.
INSERT INTO MEM_CHECK VALUES(1,'USER2','PW222','박점심',NULL,'010-3333-7777','서울특별시 강남구 역삼동',SYSDATE);

SELECT *
FROM MEM_CHECK;

/*
    DEFAULT 설정
    특정 컬럼에 들어올 값에 대한 기본값 성정 가능
    제약조건은 아니다.
    
    EX)회원가입일 컬럼에 회원정보가 삽입된 순간의 시간을 기록하고 싶다
        -DEFAULT 설정으로 SYSDATE를 부여해주면 된다.
*/

--회원가입일을 항상 SYSDATE로 받고싶은 경우
DROP TABLE MEM_CHECK;

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN('남','여')) NOT NULL,
    PHONE VARCHAR2(20),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL --DEFUALT 설정을 먼저하고 제약조건을 걸어줘야한다.
);

INSERT INTO MEM_CHECK VALUES(1,'ASD','QWE','김테스','여','011-222-3555',DEFAULT);
INSERT INTO MEM_CHECK VALUES(1,'ASDFF','QWE','김테니스','남','011-222-3555','20-10-10');
SELECT *
FROM MEM_CHECK;

/*
    INSERT INTO MEM_CHECK(컬럼명들 나열) VALUES(값들 넣기)
*/
INSERT INTO MEM_CHECK(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GENDER,PHONE,MEM_DATE) 
                VALUES(4,'QWX','EQEW2','김연습','남','010-2233-1112',DEFAULT);
                
INSERT INTO MEM_CHECK(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GENDER) 
                VALUES(5,'USER32','ASDD','김나나','여');
--형식을 지정하지 않은 컬럼에는 NULL값이 들어가게 되고 만약 DEFAULT설정이 되어있으면 DEFAULT값이 들어간다.

SELECT *
FROM MEM_CHECK;

/*
    4.PRIMARY KEY(기본키) 제약조건
    테이블에서 각 행들의 정보를 유일하게 식별할 수 있는 컬럼에 부여하는 제약조건.
    -각 행들을 구별할 수 있는 식별자의 역할을 한다.
    EX)사번,부서아이디,직급코드,회원번호,학번....
    -식별자의 조건 : 중복값 허용하지 않음, NULL값이 들어오면 안됨  (UNIQUE + NOT NULL)
    주의) 한 테이블당 한개의 컬럼값만 지정 가능하다.
*/

CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
);

INSERT INTO MEM_PRIMARYKEY1(MEM_NO,MEM_ID,MEM_PW,MEM_NAME) 
VALUES (2,'USER11','PW123','홍길동');

INSERT INTO MEM_PRIMARYKEY1(MEM_NO,MEM_ID,MEM_PW,MEM_NAME) 
VALUES (3,'USER11','PW12331','박길동');

INSERT INTO MEM_PRIMARYKEY1(MEM_NO,MEM_ID,MEM_PW,MEM_NAME) 
VALUES (2,'USER','ASD','김길동');

INSERT INTO MEM_PRIMARYKEY1(MEM_NO,MEM_ID,MEM_PW,MEM_NAME) 
VALUES (NULL,'USE21','PW123','홍길동');

SELECT *
FROM MEM_PRIMARYKEY1;

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) CONSTRAINT MEM_PK3 PRIMARY KEY, --컬럼 레벨 방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --    CONSTRAINT MEM_PK2 PRIMARY KEY(MEM_NO) --테이블 레벨 방식
);
--다른테이블이여도 제약조건의 이름은 중복될 수 없다 (고유값) 
-- name already used by an existing constraint
--한테이블에 PRIMARY KEY를 두개이상 설정할 수 없다.
-- table can have only one primary key
--두 컬럼을 묶어서 한번에 PRIMARY KEY로 설정 가능 - 테이블 레벨 방식으로만 설정 가능하다.

CREATE TABLE MEM_PRIMARYKEY3(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT MEM_PK2 PRIMARY KEY(MEM_NO,MEM_ID) --테이블 레벨 방식
)
--두 컬럼을 묶어서 PRIMARY KEY하나로 설정 -> 복합키

INSERT INTO MEM_PRIMARYKEY3(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME)
VALUES (1,'USER','QWE','홍길동');

INSERT INTO MEM_PRIMARYKEY3(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME)
VALUES (1,'USER123','QWE','김길동');

INSERT INTO MEM_PRIMARYKEY3(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME)
VALUES (2,'USER','QWE','홍길동');

INSERT INTO MEM_PRIMARYKEY3(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME)
VALUES (1,'USER','QWE','홍길동');

INSERT INTO MEM_PRIMARYKEY3(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME)
VALUES (NULL,'USER12345','QWE','홍길동');


SELECT *
FROM MEM_PRIMARYKEY3;


/*
    5.FOREIGN KY (외래키)
    해당 컬럼에 다른 테이블에 존재하는 값만 들어와야 하는 컬럼에 부여하는 제약조건
    -> 다른테이블을 참조한다 라고 표현.
        즉, 참조된 다른 테이블이 제공하고 있는 값만 들어올 수 있다.
        EX) KH계정에서
            EMPLOYEE테이블 (자식테이블) <---------- DEPARTMENT 테이블(부모테이블)
                DEPT_CODE                           DEPT_ID
            -DEPT_CODE에는 DEPT_ID에 존재하는 값들만 들어 올 수 있음.
            
        --FOREIGN KEY 제약조건 (연결고리) 으로 다른 테이블과 관계를 형성할 수 있다.(JOIN)
        [표현법]
        >컬럼레벨 방식
        컬럼명 자료형 CONSTRAINT 제약조건명 REFERENCES 참조할 테이블명(참조할 컬럼명)
        
        >테이블 레벨방식
        CONSTRAINT 제약조건명 FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명(참조할 컬럼명)
        
        참조할 테이블 ==부모 테이블
        생략 가능한 것: CONSTRAINT 제약조건명,참조할 컬럼명(두 방식 모두 해당됨)
        -자동적으로 참조할 테이블의 PRIMARY KEY에 해당되는 컬럼이 참조할 컬럼명으로 잡힌다.
        
        주의사항 : 참조할 컬럼 타입과 외래키로 지정할 컬럼타입이 같아야 한다.
*/

--부모테이블 만들기
--회원 등급에 대한 데이터 (등급코드,등급명) 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY, --등급 코드 / 문자열 'G1','G2',...
    GRADE_NAME VARCHAR2(20) NOT NULL --등급명 /문자열 '일반회원','우수회원'
);

INSERT INTO MEM_GRADE VALUES('G1','일반회원');
INSERT INTO MEM_GRADE VALUES('G2','우수회원');
INSERT INTO MEM_GRADE VALUES('G3','특별회원');

SELECT *
FROM MEM_GRADE;

--자식 테이블
--회원정보를 담는 테이블
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE), --컬럼레벨방식
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --테이블 레벨 방식
);

INSERT INTO MEM(MEM_NO,MEM_ID,MEM_NAME,GRADE_ID)
VALUES(1,'USER','김유저','G1');

INSERT INTO MEM(MEM_NO,MEM_ID,MEM_NAME,GRADE_ID)
VALUES(2,'USER2','박명수','G2');

INSERT INTO MEM(MEM_NO,MEM_ID,MEM_NAME,GRADE_ID)
VALUES(3,'USER3','유재석','G3');

SELECT *
FROM MEM;

--외래키 제약조건에 NULL값이 들어갈수 있는지
INSERT INTO MEM(MEM_NO,MEM_ID,MEM_NAME,GRADE_ID)
VALUES(4,'USER4','유재석',NULL);
--부모테이블에 참조컬럼에 존재하지 않는 값을 넣을수있는지
INSERT INTO MEM(MEM_NO,MEM_ID,MEM_NAME,GRADE_ID)
VALUES(5,'USER5','유재식','G5'); --parent key not found

--부모테이블(MEM_GRADE)에서 데이터값이 삭제된다면?
--MEM_GRADE테이블에서 G1 데이터 삭제해보기
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
--child record found : 자식테이블에서 데이터를 참조하고 있어서 삭제 불가
--FOREIGN KEY에 기본적으로 삭제 제한 옵션이 걸려있다.

DROP TABLE MEM;

/*
    자식 테이블 생성시(==외래키 제약조건을 부여할 때)
    부모테이블의 데이터가 삭제되었을 때 자식테이블에는 어떻게 처리할지 옵션으로 정해둘 수 있다.
    
    FOREIGN KEY 삭제 옵션
    -ON DELETE SET NULL : 부모데이터를 삭제할때 해당 데이터를 사용하는 자식 데이터는 NULL로 바꾸겠다.
    -ON DELETE CASCADE : 부모데이터를 삭제할때 해당 데이터를 사용하는 자식데이터를 같이 삭제하겠다.
    -ON DELETE RESTRICTED : 삭제 제한 (기본옵션)
*/

--1) ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2),
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL,
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO MEM(MEM_NO,MEM_ID,MEM_NAME,GRADE_ID)
VALUES(1,'USER','유재석','G2');

INSERT INTO MEM(MEM_NO,MEM_ID,MEM_NAME,GRADE_ID)
VALUES(2,'USER2','유재석','G2');

INSERT INTO MEM(MEM_NO,MEM_ID,MEM_NAME,GRADE_ID)
VALUES(3,'USER5','유석','G3');

SELECT *
FROM MEM;

--부모테이블의 GRADE_CODE가 'G1'인 데이터 삭제
DELETE FROM MEM_GRADE WHERE GRADE_CODE ='G1';

SELECT *
FROM MEM_GRADE;

SELECT*
FROM MEM;

DROP TABLE MEM;

--2) ON DELETE CASCADE
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2),
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
--    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE --테이블 레벨 방식
);

SELECT *
FROM MEM;

SELECT*
FROM MEM_GRADE;

--부모테이블에 G2데이터 삭제해보기
DELETE FROM MEM_GRADE
WHERE GRADE_CODE='G2';

--JOIN
SELECT MEM_NO,MEM_NAME,GRADE_NAME
FROM MEM,MEM_GRADE
WHERE GRADE_ID=GRADE_CODE;

/*
    굳이 외래키 제약조건이 걸려있지 않아도 
    해당 컬럼들에 동일한 데이터가 담겨있다면 JOIN을 사용할 수 있다.
*/

-----------------------------------------------------------------------------------
-----------------------여기서부터는 KH계정에 접속하여 진행하기 -------------
/*
        SUBQUERY를 이용한 테이블 생성(테이블복사) 
        메인 SQL문 (SELECT,CREATE,INSERT,UPDATE)를 보조하는 역할의 쿼리문을 이용하기(SUBQUERY)
        
        [표현법]
        CREATE TABLE 테이블명
        AS 서브쿼리;
*/

--EMPLOYEE 테이블 조회
SELECT *
FROM EMPLOYEE;

--EMPLOYEE테이블을 복제한 테이블 생성해보기 (EMP_COPY)
CREATE TABLE EMP_COPY
AS SELECT *
   FROM EMPLOYEE;

SELECT *
FROM EMP_COPY;
--컬럼들,조회결과의 데이터값들이 복사된다.
--NOT NULL제약조건 복사됨
--PRIMARY KEY제약조건은 복사되지 않는다.
-->SUBQUERY를 통한 테이블 생성시에는 NOT NULL제약조건만 복사된다.

--테이블에 컬럼 형식만 복사하고자 할때 - 조건을 부여한다.

SELECT*
FROM EMPLOYEE
WHERE 1=0; -- FALSE를 의미하기때문에 조건에 부합하는게 아무것도 없다

SELECT*
FROM EMPLOYEE
WHERE 1=1; --TRUE를 의미하기때문에 전부 부합한다

--위 구문을 참고하여 테이블 형식만 가져오기
CREATE TABLE EMP_COPY2
AS SELECT *
    FROM EMPLOYEE
    WHERE 1=0;
    
SELECT*
FROM EMP_COPY2;

--전체 사원들 중 급여가 300만원 이상인 사원들의 사번,이름,부서코드,급여 컬럼복제(데이터 포함)
--1)조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;
--2)조회결과로 테이블 생성
CREATE TABLE EMP_COPY3
AS  SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;

SELECT *
FROM EMP_COPY3;
--전체사원의 사번,사원명,급여,연봉 조회결과 복제한 테이블 생성(데이터 포함)
--조회)
SELECT EMP_ID,EMP_NAME,SALARY,SALARY*12 연봉
FROM EMPLOYEE;

--조회결과로 테이블 생성
CREATE TABLE EMP_COPY4
AS SELECT EMP_ID,EMP_NAME,SALARY,SALARY*12 연봉
FROM EMPLOYEE;
--서브쿼리로 SELECT절에 함수식 또는 산술연산이 들어간 경우 반드시 별칭을 부여해줘야한다.
SELECT *
FROM EMP_COPY4;



