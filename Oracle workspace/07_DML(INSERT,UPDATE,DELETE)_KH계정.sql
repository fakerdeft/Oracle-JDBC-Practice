/*
    DML(DATA MANIPULATION LANGUAGE)
    데이터 조작 언어
    
    테이블에 새로운 데이터를 삽입(INSERT)하거나
    기존에 데이터를 수정(UPDATE)하거나
    삭제(DELETE)하는 구문
*/

/*
    1.INSERT: 테이블에 새로운 "행"을 추가하는 구문
    
    [표현법]
    INSERT INTO 계열
    
    1)INSERT INTO 테이블명 VALUES (값1, 값2,...);
    -해당 테이블에 모든 컬럼에 대해 추가하고자 하는 값을
    내가 직접 제시해서 한행을 INSERT 하고자 할 때 쓰는 표현법
    주의사항: 컬럼의 순서, 자료형, 개수를 맞춰서 VALUES 괄호 안에 값을 나열해야 한다.
    -부족하게 값을 제시했을 경우: NOT ENOUGH VALUE 오류
    -값을 더 많이 제시했을 경우: TOO MANY VALUES 오류
*/
--EMPLOYEE 테이블에 사원 정보 추가
INSERT INTO EMPLOYEE VALUES(999,'김추석','990909-1122333','KIM@NAVER.COM'
    ,'01011112222','D1','J5','S6',2000000,0.2,100,SYSDATE,NULL,DEFAULT);
    
SELECT *
FROM EMPLOYEE
WHERE EMP_ID = 999;

/*
    2) INSERT INTO 테이블명(컬럼명1,컬럼명2,컬럼명3) VALUES(값1,값2,값3);
    -해당 테이블에 특정 칼럼만 선택해서 그 칼럼에 추가할 값만 제시하고자 할 때 사용
    
    -그래도 한 행 단위로 추가되기 때문에 선택이 안된 칼럼은 기본적으로 NULL값이 들어간다.
    -단 DEFAULT 설정이 되어있을 경우 기본값이 들어감
    
    주의) NOT NULL제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값을 제시해야함
         다만 DEFAULT 설정이 되어있다면 NOT NULL이라고 해도 선택 안해도 된다.
*/
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES(998,'김설날','050105-4321212','D1','J2','S1',SYSDATE);

SELECT *
FROM EMPLOYEE
WHERE EMP_ID=998;

/*
    3)INSERT INTO 테이블명(서브쿼리);
    -VALUES()로 값을 직접 기입하는 것이 아닌 서브쿼리로
    조회한 결과를 INSERT하는 구문
    여러 행을 한번에 INSERT할 수 있다.
*/
--새로운 테이블 만들기
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT *
FROM EMP_01;

--전체 사원들의 사번, 이름, 부서명을 조회한 결과를 EMP_01 테이블에 넣기
--1)조회
SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
--2)조회결과를 INSERT하기
INSERT INTO EMP_01 (
    SELECT EMP_ID,EMP_NAME,DEPT_TITLE
    FROM EMPLOYEE,DEPARTMENT
    WHERE DEPT_CODE = DEPT_ID(+)
);

SELECT *
FROM EMP_01;
COMMIT;

/*
    INSERT ALL 계열
    두개 이상의 테이블에 각각 INSERT 할 때 사용
    조건: 그때 사용되는 서브쿼리가 동일해야 한다.
    
    1)INSERT ALL
    INTO 테이블명1 VALUES(컬럼명,컬럼명,...)
    INTO 테이블명2 VALUES(컬럼명,컬럼명,...)
    서브쿼리;
*/

--새로운 테이블 만들기
--첫 번째 테이블: 급여가 300만원 이상인 사원들의 사번, 사원명, 직급명 보관할 테이블
--테이블명: EMP_JOB - EMP_ID,EMP_NAME,JOB_NAME
CREATE TABLE EMP_JOB (
    EMP_ID NUMBER NOT NULL UNIQUE,
    EMP_NAME VARCHAR2(30) NOT NULL,
    JOB_NAME VARCHAR2(20)
);

--두 번째 테이블: 급여가 300만원 이상인 사원들의 사번, 사원명, 부서명, 보관할 테이블
--테이블명: EMP_DEPT - EMP_ID,EMP_NAME,DEPT_TITLE
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(30)
);

--급여가 300만원 이상인 사원들의 사번,이름,직급명,부서명을 먼저 조회
SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE SALARY>=3000000;

--EMP_JOB 테이블에는 급여 300만원 이상인 사원들의 EMP_ID,EMP_NAME,JOB_NAME 데이터를 삽입
--EMP_DEPT 테이블에는 급여 300만원 이상인 사원들의 EMP_ID,EMP_NAME,DEPT_TITLE 데이터를 삽입

INSERT ALL
INTO EMP_JOB VALUES(EMP_ID,EMP_NAME,JOB_NAME)
INTO EMP_DEPT VALUES(EMP_ID,EMP_NAME,DEPT_TITLE)
    SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
    WHERE SALARY >= 3000000;
    
SELECT *
FROM EMP_JOB;

SELECT *
FROM EMP_DEPT;

/*
    2)INSERT ALL
    WHEN 조건1 THEN
        INTO 테이블명1 VALUES(컬럼명,컬럼명,...)
    WHEN 조건2 THEN
        INTO 테이블명2 VALUES(컬럼명,컬럼명,...)
    서브쿼리
    
    -조건에 맞는 값들만 넣어주겠다.
*/

--새로운 테이블 생성
--2010년도 기준으로 이전에 입사한 사원들의 데이터를 넣을 테이블 2개 생성하기
--EMP_OLD / 사번,사원명,입사일,급여를 담는 테이블 CREATE 서브쿼리 구문을 이용하여 데이터 없이 형식만 생성해보기
--EMP_NEW / 위와 동일

CREATE TABLE EMP_OLD
    AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 1=0;
    
SELECT *
FROM EMP_OLD;

--EMP_NEW 2010년도 이후/ 위와 동일
CREATE TABLE EMP_NEW
    AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 1=0;
    
SELECT*
FROM EMP_NEW;

--1)서브쿼리 부분
--2010년 이전,이후
SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY 
FROM EMPLOYEE
--WHERE HIRE_DATE < '2010/01/01';   --9명
WHERE HIRE_DATE >= '2010/01/01';  --16명

INSERT ALL
    WHEN HIRE_DATE < '2010/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
    WHEN HIRE_DATE >= '2010/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE;

SELECT*
FROM EMP_OLD;
SELECT*
FROM EMP_NEW;

--EMP_OLD2, EMP_NEW2 서브쿼리로 데이터없이 생성 후 INSEET ALL 구문 사용해서 데이터 넣기
--INSERT ALL 구문에 서브쿼리 부분엔 * 로 전체 컬럼 조회해서 진행
DROP TABLE EMP_OLD2;
DROP TABLE EMP_NEW2;
CREATE TABLE EMP_OLD2
    AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 1=0;

CREATE TABLE EMP_NEW2
    AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 1=0;
    
INSERT ALL
    WHEN HIRE_DATE<'2010/01/01' THEN
    INTO EMP_OLD2 VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
    WHEN HIRE_DATE>='2010/01/01' THEN
    INTO EMP_NEW2 VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
        SELECT *
        FROM EMPLOYEE;

SELECT*
FROM EMP_OLD2;

SELECT*
FROM EMP_NEW2;

/*
    2.UPDATE
    
    테이블에 기록된 기존의 데이터를 '수정'하는 구문
    
    [표현법]
    UPDATE 테이블명
    SET 컬럼명 = 바꿀값
        ,컬럼명 = 바꿀값
        ,컬럼명 = 바꿀값
        ,... (여러개의 컬럼 동시에 변경 가능(,로 나열해야 한다.))
    WHERE 조건; - WHERE절은 생략가능, 생략했을시엔 전체 데이터 전부 변경
*/

--복사본 테이블 생성
CREATE TABLE DEPT_COPY
AS SELECT *
    FROM DEPARTMENT;
    
SELECT* 
FROM DEPT_COPY;

--DEPT_COPY 테이블에서 D9 부서의 부서명을 전략기획팀으로 변경
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID='D9';

SELECT *
FROM DEPT_COPY;

--WHERE절의 조건에 따라 1개의 행 OR 여러 행이 변경가능

--복사본 테이블
--테이블명 EMP_SALARY / 컬럼: EMPLOYEE테이블로 부터 EMP_ID,EMP_NAME,DEPT_CODE,SALARY,BONUS
--섭쿼리 이용
CREATE TABLE EMP_SALARY
    AS SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY,BONUS
    FROM EMPLOYEE;

SELECT*
FROM EMP_SALARY;
--EMP_SALARY 테이블에서 노옹철 사원의 급여를 1000만원으로 변경
UPDATE EMP_SALARY 
    SET SALARY=10000000
    WHERE EMP_NAME='노옹철';

SELECT*
FROM EMP_SALARY;
--EMP_SALARY 테이블에서 선동일 사원의 급여를 700만원 보너스를 0.2로 변경
UPDATE EMP_SALARY
    SET SALARY = 7000000,
        BONUS = 0.2
    WHERE EMP_NAME = '선동일';

SELECT*
FROM EMP_SALARY;
--전체사원의 급여를 기존급여의 20%인상한 금액으로 변경
UPDATE EMP_SALARY
    SET SALARY = SALARY*1.2;

SELECT*
FROM EMP_SALARY;

--임시환의 DEPT_CODE를 김해술의 DEPT_CODE로 변경
UPDATE EMP_SALARY
    SET DEPT_CODE = (SELECT DEPT_CODE
                     FROM EMP_SALARY
                     WHERE EMP_NAME ='김해술')
    WHERE EMP_NAME='임시환';

SELECT *
FROM EMP_SALARY;

--방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스 값으로 변경
SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME ='방명수'; 

SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME= '유재식';

--단일행, 다중열 서브쿼리 이용
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY, BONUS
                      FROM EMP_SALARY
                      WHERE EMP_NAME = '유재식')
WHERE EMP_NAME= '방명수';

SELECT*
FROM EMP_SALARY;

--송종기 사원의 DEPT_CODE와 SALARY와 BONUS를 심봉선 사원의 부코,급여,보넛으로 변경
UPDATE EMP_SALARY
    SET (DEPT_CODE,SALARY,BONUS) = (SELECT DEPT_CODE,SALARY,BONUS
                                    FROM EMP_SALARY
                                    WHERE EMP_NAME='심봉선')
    WHERE EMP_NAME = '송종기' ;

SELECT*
FROM EMP_SALARY;

--EMPLOYEE에서 송종기 사원의 사번을 200번으로 변경
UPDATE EMPLOYEE
SET EMP_ID =200
WHERE EMP_NAME = '송종기';
--PRIMARY KEY 위배

--EMP_ID가 200인 사원의 사번을 NULL로 변경
UPDATE EMPLOYEE
SET EMP_ID = NULL
WHERE EMP_ID =200;
--NOT NULL 위배

--UPDATE 구문으로 변경할 때 제약조건 위배 불가능

/*
    4.DELETE
    테이블에 기록된 데이터를 '행'단위로 삭제하는 구문
    [표현법]
    DELETE FROM 테이블명
    WHERE 조건; --WHERE절은 생략이 가능하지만 생략시에 모든 행이 삭제된다.
*/

DELETE FROM EMP_SALARY;
SELECT *
FROM EMP_SALARY;

SELECT *
FROM EMP_COPY;
COMMIT;
--EMP_COPY에서 DEPT_CODE가 D9인 사원들 삭제
--EMP_COPY에서 이름이 노옹철인 사원 삭제
DELETE FROM EMP_COPY
        WHERE DEPT_CODE='D9'
        AND EMP_NAME='노옹철';
SELECT *
FROM EMP_COPY;

/*  
   -TRUNCATE
    
    테이블의 전체행을 모두 삭제할때 사용하는 구문
    DELETE 구문보다 속도가 빠름
    별도의 조건을 제시할 수 없다.
    ROLLBACK이 되지 않기 때문에 주의해서 지워야한다.
    데이터를 저장했던 메모리까지 같이 지워준다 (초기상태)
    [표현법]
    TRUNCATE TABLE 테이블명;
*/

SELECT * FROM EMP_COPY;
DELETE FROM EMP_COPY; --롤백 ㄱㄴ
ROLLBACK;
TRUNCATE TABLE EMP_COPY;



