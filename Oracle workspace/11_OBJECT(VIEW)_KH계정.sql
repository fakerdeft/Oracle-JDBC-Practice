/*
    OBJECT 
    DB다루는 논리적 구조물
    
    OBJECT 종류
    -TABLE , USER , VIEW , SEQUENCE,....
    
    <VIEW>
    SELECT를 저장ㄱㄴ한 객체
    (자주 사용될 긴 SELECT문을 VIEW에 저장해두면 매번 긴 SELECT 문을 다시 기술할 필요가 없다)
    -조회용 임시테이블 같은 존재(실제 데이터가 담겨있는 것이 아닌 기반테이블 데이터를 조회해오는 형태)
    
*/

--실습문제
--'한국'에서 근무하는 사원들의 사번,이름,부서명,급여,국가명,직급명을 조회
--오라클
SELECT EMP_ID 사번
      ,EMP_NAME 이름
      ,DEPT_TITLE 부서명
      ,SALARY 급여
      ,NATIONAL_NAME 국가명
      ,JOB_NAME 직급명
FROM EMPLOYEE E, DEPARTMENT D,JOB J,NATIONAL N,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND L.NATIONAL_CODE=N.NATIONAL_CODE
AND N.NATIONAL_NAME='한국';

--안시
SELECT EMP_ID 사번
      ,EMP_NAME 이름
      ,DEPT_TITLE 부서명
      ,SALARY 급여
      ,NATIONAL_NAME 국가명
      ,JOB_NAME 직급명
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE=N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME='한국';

/*
    1.VIEW 생성
    [표현법]
    CREATE VIEW 뷰이름
    AS 서브쿼리;
    
    CREATE OR REPLACE VIEW 뷰이름
    AS 서브쿼리;
    -뷰 생성시 기존에 중복된 이름의 뷰가 없다면 생성
    있다면 갱신하는 구문.
*/
CREATE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID 사번
      ,EMP_NAME 이름
      ,DEPT_TITLE 부서명
      ,SALARY 급여
      ,NATIONAL_NAME 국가명
      ,JOB_NAME 직급명
    FROM EMPLOYEE E, DEPARTMENT D,JOB J,NATIONAL N,LOCATION L
    WHERE E.DEPT_CODE=D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND D.LOCATION_ID=L.LOCAL_CODE
    AND L.NATIONAL_CODE=N.NATIONAL_CODE);
--뷰 생성 권한을 주지 않아서 오류 발생
--이 부분만 관리자 계정으로 실행
GRANT CREATE VIEW TO KH;
--KH계정으로 돌아오기

--사원들의 사번,이름,부서명,급여,국가명,직급명을 조회
--오라클
SELECT EMP_ID 사번
      ,EMP_NAME 이름
      ,DEPT_TITLE 부서명
      ,SALARY 급여
      ,NATIONAL_NAME 국가명
      ,JOB_NAME 직급명
FROM EMPLOYEE E, DEPARTMENT D,JOB J,NATIONAL N,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND L.NATIONAL_CODE=N.NATIONAL_CODE
AND N.NATIONAL_NAME='한국';

--서브쿼리로 생성한 VIEW로 조회 가능하다.
SELECT *
FROM VW_EMPLOYEE;
--위와 같이 복잡한 서브쿼리를 이용하여 그때그때 필요한 데이터를 조회하는것보다
--한번 뷰를 생성한 이후에 뷰를 조회한다면 서브쿼리를 이용하는 것보다 간편하게 사용 가능

--한국에서 근무하는 사원 조회
SELECT *
FROM VW_EMPLOYEE
WHERE 국가명='한국';

--러시아에서 근무하는 사원들의 사번,이름,직급명,보너스 조회 (뷰 이용)
--CREATE OR REPLACE VIEW 사용
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID 사번
      ,EMP_NAME 이름
      ,DEPT_TITLE 부서명
      ,SALARY 급여
      ,NATIONAL_NAME 국가명
      ,JOB_NAME 직급명
      ,BONUS 보너스
    FROM EMPLOYEE E, DEPARTMENT D,JOB J,NATIONAL N,LOCATION L
    WHERE E.DEPT_CODE=D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND D.LOCATION_ID=L.LOCAL_CODE
    AND L.NATIONAL_CODE=N.NATIONAL_CODE);

SELECT 사번,이름,직급명,국가명,보너스
FROM VW_EMPLOYEE
WHERE 국가명='러시아';

--VIEW 딕셔너리 조회 구문 USER_VIEWS
SELECT * FROM USER_VIEWS;

/*
    뷰 컬럼에 별칭 부여
    서브쿼리부분에 SELECT절에 함수나 산술연산식이 기술되어 있는 경우 반드시 별칭 지정
*/

--사원의 사번,이름,직급명,성별,근무년수를 조회할 수 있는 SELECT문으로 VIEW생성
--성별은 남 또는 여로 조회 근무년수는 현재년-입사년으로 계산
CREATE OR REPLACE VIEW VW_EMPLOYEE2(사번,이름,직급명,성별,근무년수)
AS (SELECT EMP_ID 
      ,EMP_NAME 
      ,JOB_NAME 
      ,DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여')
      ,EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE E ,JOB J
    WHERE E.JOB_CODE = J.JOB_CODE);

SELECT *
FROM VW_EMPLOYEE2;

SELECT 이름
FROM VW_EMPLOYEE2
WHERE 성별='여';
--뷰에서 생성될때 붙여진 별칭과 리터럴은 SELECT구문에서 사용가능

--근무년수가 20년 이상인 사원들의 사번,이름,근무년수를 구해보시오.
SELECT 사번,이름,근무년수
FROM VW_EMPLOYEE2
WHERE 근무년수>=20;

--DROP 
--뷰를 삭제하고자 한다면
DROP VIEW VW_EMPLOYEE2;

--INSERT/UPDATE/DELETE
--주의사항: 뷰를 통해 조작하게 된다면 실제 데이터가 담겨있는 실질적인 테이블에도 변경사항이 적용된다.

CREATE OR REPLACE VIEW VW_JOB
AS SELECT * FROM JOB;

--생성된 VW_JOB 뷰에 데이터 추가해보기

INSERT INTO VW_JOB VALUES('J9','인턴');

SELECT * FROM JOB; --기반테이블에도 인턴 데이터 추가

--VM_JOB이란 뷰에 JOB_CODE가 J9인 JOB_NAME을 '알바'로 수정
UPDATE VW_JOB
SET JOB_NAME ='알바'
WHERE JOB_CODE='J9';

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

--기반테이블에도 수정이 이루어짐

--VW_JOB이란 뷰에 JOB_CODE가 J9인 데이터 삭제
DELETE FROM VW_JOB
WHERE JOB_CODE='J9';

SELECT * FROM VW_JOB;
SELECT * FROM JOB;
--기반테이블에 있는 데이터도 삭제

/*
    DML 구문이 가능한 경우: 서브쿼리를 이용해서 기존의 테이블을 별도의 처리 없이 복제하고자 할 경우
    
    *불가능한 경우 - 한번의 처리가 들어간 경우들
    1)뷰에 정의가 되어있지 않은 컬럼을 조작하는 경우
    2)뷰에 정의되어있지 않은 컬럼 중에 기반테이블 상에 NOT NULL 제약조건이 지정된 경우
    3)산술연산식 또는 함수를 통해서 정의되어 있는 경우
    4)그룹함수나 GROUP BY절이 포함된 경우
    5)DISTINCT 구문이 포함된 경우
    6)JOIN을 이용해서 여러 테이블을 매칭시켜놓는 경우
*/

--2) 뷰에 정의되어 있지 않은 컬럼 중에 기반테이블 상에 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE FROM JOB;

SELECT * FROM VW_JOB;

--INSERT
INSERT INTO VW_JOB VALUES('J9');
--JOB테이블에 JOB_NAME만 넣으려고 하면
--다른 값이 널이라서

--VIEW 옵션
--FORCE: 쿼리문의 테이블, 컬럼, 함수 등이 일부 존재하지 않아도 생성 된다.

CREATE FORCE VIEW VW_TEST
AS SELECT * FROM TB_TEST;
--기반테이블 없어도 생성됨
SELECT * FROM VW_TEST;
--기반테이블이 없어서 조회는 되지 않음

--FORCE 속성이 없으면 기반테이블 없이 VIEW를 생성할 수 없다.
CREATE VIEW VW_TEST2
AS SELECT * FROM TB_TEST2;

--FORCE로 미리 만들어둔 VIEW에 대한 기반테이블 생성
CREATE TABLE TB_TEST(
    TB_ID NUMBER
    ,TB_NAME VARCHAR2(40)
);

SELECT * FROM VW_TEST; --기반테이블 생성 후엔 조회가 잘 된다.












