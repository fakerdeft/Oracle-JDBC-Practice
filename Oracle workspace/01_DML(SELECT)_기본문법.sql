/*
DML: 데이터 조작, SELECT(DQL), INSERT, UPDATE, DELETE
DDL: 데이터 정의, CREATE, ALTER, DROP
TCL: 트랜잭션 제어, COMMIT,ROLLBACK
DCL: 권한 부여, GRANT,REVOKE

<SELECT>
데이터를 조회하거나 검색할 때 사용하는 명령어
-RESULT SET: SELECT 구문을 통해 조회된 데이터의 결과물을 의미 즉, 조회된 행들의 집합

[표현법]
SELECT 조회하고자 하는 컬럼명, 컬럼명2,...
FROM 테이블
*/

--EMPLOYEE 테이블의 전체 사원들의 사번,이름,급여 컬럼을 조회해보자
SELECT EMP_ID,EMP_NAME,SALARY
FROM EMPLOYEE;

--EMPLOYEE 테이블의 전체 칼럼을 조회하고 싶을때? ( " * " == ALL 전체를 의미한다)
SELECT *
FROM EMPLOYEE;

--EMPLOYEE 테이블의 전체 사원들의 이름,이멜,휴대번호를 조회해보자
SELECT EMP_NAME,EMAIL,PHONE
FROM EMPLOYEE;

-----실습문제-----
--1. JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;
--2. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME
FROM JOB;
--3. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;
--4. EMPLOYEE 테이블의 직원명,이멜,전번,입사일 컬럼 조회
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE
FROM EMPLOYEE;
--5. EMPLOYEE 테이블의 입사일,직원명,급여 컬럼 조회
SELECT HIRE_DATE,EMP_NAME,SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    조회하고자 하는 컬럼들을 나열하는 SELECT절에 산술연산(+-/*)을 기술하여 결과를 조회할 수 있다.
    
*/
--EMPLOYEE 테이블로부터 직원명,월급,연봉(월급*12)
SELECT EMP_NAME,SALARY,SALARY*12
FROM EMPLOYEE;

--EMPLOYEE 테이블로부터 직원명,월급,보너스,보너스가 포함된 연봉((월급+보너스*월급)*12)
SELECT EMP_NAME,SALARY,BONUS,((SALARY+BONUS*SALARY)*12)
FROM EMPLOYEE;
--산술연산시에 NULL값이 존재한다면 결과값도 NULL값이 된다

--EMPLOYEE 테이블로부터 직원명,입사일,근무일수(오늘날짜-입사일) 조회
--DATE 타입끼리 연산도 가능하다(DATE - 년, 월,일,시,분,초)
--오늘날짜(현재): SYSDATE
SELECT EMP_NAME,HIRE_DATE,SYSDATE-HIRE_DATE
FROM EMPLOYEE;
--값이 지저분하게 나오는 이유: DATE 타입 안에 포함된 시,분,초에 대한 연산까지 수행하기 때문.

/*
    <컬럼명에 별칭 부여하기>
    [표현법]
    컬럼명 AS 별칭, 컬럼명 AS "별칭", 컬럼명 별칭, 컬럼명 "별칭"
    
    AS를 붙이던 안 붙이던 별칭에 특수문자나 띄어쓰기가 포함될 경우엔 "" 안에 작성해야한다.
    
*/

--EMPLOYEE 테이블로부터 직원명,월급,연봉(월급*12)
SELECT EMP_NAME AS 사원명, SALARY AS 월급, SALARY*12 AS "연봉(보너스 미포함)"
FROM EMPLOYEE;

--EMPLOYEE 테이블로부터 직원명,월급,보너스,보너스가 포함된 연봉(==(월급+보너스*월급)*12)
SELECT EMP_NAME 직원명, SALARY 월급, BONUS 보너스, (SALARY+BONUS*SALARY)*12 AS "보너스가 포함된 연봉"
FROM EMPLOYEE;

--EMPLOYEE 테이블로부터 직원명,입사일,근무일수(오늘날짜 - 입사일) 조회
SELECT EMP_NAME AS 직원명, HIRE_DATE AS 입사일, (SYSDATE-HIRE_DATE) AS 근무일수
FROM EMPLOYEE;

/*
    <리터럴>
    임의로 지정한 문자열을 SELECT 절에 기술하면 
    실제 그 테이블에 존재하는 데이터처럼 조회 가능하다.
*/

--EMPLOYEE 테이블로부터 사번, 사원명, 급여, 단위(원)을 조회하기
SELECT EMP_ID, EMP_NAME, SALARY,'원'단위
FROM EMPLOYEE;

--SELECT절에 제시된 리터럴 값이 조회결과인 RESULT SET의 모든 행에 반복적으로 출력된다.

/*
    <DISTINCT>
    조회하고자 하는 컬럼에 중복된 값을 한번만 조회하고자 할때 사용한다.
    해당 컬럼명 앞에 기술 (단, SELECT절에 DISTINCT구문은 한개만 작성 가능하다
    [표현법]
    DISTINCT 컬럼명
    
*/

--EMPLOYEE 테이블에서 부서코드들만 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

--EMPLOYEE 테이블에서 직급코드들만 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

--DEPT_CODE와 JOB_CODE를 같이 묶어서 중복 판별
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

----------------------------------

/*
    <WHERE절>
    조회하고자 하는 테이블에 특정 조건을 제시해서
    그 조건에 만족하는 데이터만을 조회하고자 할 때 기술
    
    [표현법]
    SELECT 조회하고자 하는 컬럼명,...
    FROM 테이블명
    WHERE 조건;
    
    실행순서
    FROM --> WHERE --> SELECT 
    
    -조건식에 사용하는 연산자
    <비교연산>
    >,<,>=,<=
    = (일치하는가? 자바에서는 ==)
    !=,^=,<> (일치하지 않는가?)
    
*/
--EMPLOYEE 테이블로부터 급여가 400만원 이상힌 사원들만 조회(모든 컬럼)
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;

--EMPLOYEE 테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드, 급여조회
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D9';

--EMPLOYEE 테이블로부터 부서코드가 D9가 아닌 사원들의 사원명, 부서코드 ,급여조회
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE!='D9'
--WHERE DEPT_CODE^='D9'
WHERE DEPT_CODE<>'D9';

-----실습문제-----
--1. EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME 이름 ,SALARY 급여, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE SALARY > 3000000;
--2. EMPLOYEE 테이블에서 직급코드가 J2인 사원들의 이름, 급여, 보너스 조회
SELECT EMP_NAME 이름, SALARY 급여, BONUS 보너스
FROM EMPLOYEE
WHERE DEPT_CODE = 'J2';
--3. EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번, 이름, 입사일, 퇴사일 조회
SELECT EMP_NO 사번,EMP_NAME 이름, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE ENT_YN='N';
--4. EMPLOYEE 테이블에서 연봉 (급여*12) 이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회
SELECT EMP_NAME 이름,SALARY 급여, SALARY*12 연봉, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000; 
--SELECT절에서 부여한 별칭은 WHERE절에 사용할 수 없다.


    /*
        -논리 연산자
        여러개의 조건을 엮을 때 사용
        
        AND,OR
        AND: 그리고
        OR: 또는
        
    */
    
--EMPLOYEE 테이블에서 부서코드가 D9이면서 급여가300만원 이상인 사원들의 이름,부서코드,급여 조회
SELECT EMP_NAME 이름,DEPT_CODE 부서코드,SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' 
AND SALARY >=3000000;

--부서코드가 D6이거나 급여가300만원 이상인 사원들의 이름,부서코드, 급여 조회
SELECT EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

--급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번,급여,직급코드 조회
SELECT EMP_NAME 이름, EMP_NO 사번 , SALARY 급여, JOB_CODE 직급코드
FROM EMPLOYEE
WHERE SALARY<=6000000 AND SALARY >= 3500000;

/*

	-BETWEEN AND
	몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용

	[표현법]
	비교대상컬럼명 BETWEEN 하한값 AND 상한값

*/

--급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME 이름, EMP_NO 사번 , SALARY 급여, JOB_CODE 직급코드
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--급여가 350만 미만,600만 초과 사원들의 이름,사번,급여,직급코드 조회
SELECT EMP_NAME 이름, EMP_NO 사번 , SALARY 급여, JOB_CODE 직급코드
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
--오라클에서 NOT은 자바에서 ! 처럼 논리부정 연산이다.

--BETWEEN ADN 연산은 DATE 형식간의 범위에도 사용이 가능하다.
--입사일이 '90/01/01'~'03/01/01' 인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

--입사일이 '90/01/01'~'03/01/01' 에 포함되지 않는 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

/*

	<LIKE '특정패턴'>
	비교하고자 하는 컬럼값이 내가 지정한 특정 패턴에 만족될 경우 조회

	[표현법]
	비교대상컬럼명 LIKE '특정패턴'

	-옵션: 특정패턴 부분에 와일드카드인 '%','_' 를 가지고 제시할 수 있다.

	'%': 0글자 이상
	     -비교대상컬럼명 LIKE '문자%' => 컬럼값중에 '문자'로 시작하는 것을 조회한다.
	     -비교대상컬럼명 LIKE '%문자' => 컬럼값중에 '문자'로 끝나는것을 조회한다.
	     -비교대상컬럼명 LIKE '%문자%' => 컬럼값중에 '문자'가 포함되는것을 조회한다.

	'_': 1글자
	     -비교대상컬럼명 LIKE '_문자' => 해당 컬럼값중에 '문자'앞에 무조건 1글자가 존재하는 경우 조회한다.
	     -비교대상컬럼명 LIKE '__문자' => 해당 컬럼값중에 '문자'앞에 무조건 2글자가 존재하는 경우 조회한다.
*/

--성이 전씨인 사원들의 이름,급여,입사일을 조회
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

--이름에 '하'가 포함된 사원들의 이름,주민번호,부서코드 조회
SELECT EMP_NAME,EMP_NO,DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

--전화번호 4번째 자리가 9로 시작하는 사원들의 사번,사원명,전화번호,이멜 조회
SELECT EMP_ID,EMP_NAME,PHONE,EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

--이름 가운데 글자가 '지'인 사원들의 모든 칼럼
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_지_';

--그 외의 사원
SELECT *
FROM EMPLOYEE
--WHERE EMP_NAME NOT LIKE '지';
WHERE NOT EMP_NAME LIKE '_지_';

--1.이름이 '연' 으로 끝나는 사원들의 이름,입사일 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

--2.전화번호 처음 3글자가 010이 아닌 사원들의 이름,전화번호 조회
SELECT *
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

--3.DEPARTMENT 테이블에서 해외영업과 관련된 부서들의 모든 칼럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%해외영업%';

/*
    IS NULL
    해당 값이 NULL인지 비교해준다.
    [표현법]
    비교대상칼럼 IS NULL: 칼럼값이 NULL일 경우
    비교대상칼럼 IS NOT NULL: 칼럼값이 NULL이 아닌 경우
*/

SELECT*
FROM EMPLOYEE;

--보너스를 받지 않는 사원들 (==BONUS 칼럼값이 NULL인) 사번,이름,급여,보너스
SELECT EMP_ID,EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

--사수가 없는 사원들의 사원명,사수사번,부서코드 조회
SELECT EMP_NAME 이름,MANAGER_ID 사수사번,DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--사수도 없고 부서배치도 아직 받지 않은 사원들의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--부서배치는 받지 않았지만 보너스는 받는 사원의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*
    <IN>
    비교 대상 칼럼값에 내가 제시한 목록들 중에 일치하는 값이 있는지 판단
    [표현법]
    비교대상칼럼 in(값,값,값...)
*/

--부서코드가 D6 이거나 또는 D8이거나 D5인 사원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8','D5');

--직급코드가 J1이거나 또는 J3이거나 또는 J4인 사원들의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1','J3','J4');

--그 외 사원들 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE NOT IN ('J1','J3','J4');

/*
    <연결 연산자 || >
    여러 칼럼값들을 마치 하나의 칼럼인것처럼 연결시켜주는 연산자
    컬럼과 리터럴(임의의 문자열)을 연결할 수 있음
*/

SELECT EMP_ID || EMP_NAME || SALARY AS 연결됨
FROM EMPLOYEE;

--XX번 XXX의 월급은 XXXX원 입니다.
SELECT EMP_ID || '번' || EMP_NAME ||'의 월급은'||SALARY||'원입니다.' AS 급여정보
FROM EMPLOYEE;

/*
    <연산자 우선순위>
    0.()
    1.산술연산자
    2.연결연산자
    3.비교연산자
    4.IS NULL, IS NOT NULL, LIKE, IN
    5.BETWEEN AND
    6.NOT
    7.AND
    8.OR
*/

-------------------------------------
/*
    <ORDER BY>
    SELECT문 가장 마지막에 기입하는 구문뿐만 아니라 가장 마지막에 실행되는 구문
    최종 조회된 결과물들에 대해서 정렬기준을 세워주는 구문
    
    [표현법]
    SELECT 조회할컬럼1, 조회할컬럼2,...
    FROM 조회할테이블명
    WHERE 조건식(생략가능)
    ORDER BY[정렬기준 컬럼명/별칭/순번] [ASC/DESC](생략가능) [NULLS FIRST/NULLS LAST](생략가능)
    
    오름차순/내림차순
    -ASC: 오름차순(생략시 기본값)
    -DESC: 내림차순
    
    정렬하고자 하는 컬럼값에 NULL이 있을 경우
    -NULLS FIRST: 해당 NULL값들을 앞으로 배치하겠다. (내림차순 정렬일 경우 기본값)
    -NULLS LAST: 해당 NULL값들을 뒤로 배치하겠다. (오름차순일 정렬일 경우 기본값)
    
*/

--월급이 높은 사람들부터 나열하고 싶음(내림차순)
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT *
FROM EMPLOYEE
ORDER BY SALARY; -- 기본값 ASC (오름차순 정렬)

--보너스 기준 정렬
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; --ASC(오름차순) & NULLS LAST 기본값
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- NULLS FIRST 기본값
ORDER BY BONUS DESC, SALARY ASC; --첫 번째로 제시한 정렬기준이 일치할 경우 두 번째 정렬기준을 가지고 정렬

--연봉 기준 정렬
SELECT EMP_NAME 이름 ,SALARY 급여 ,(SALARY*12) 연봉, HIRE_DATE 입사일
FROM EMPLOYEE
--ORDER BY (SALARY*12)  DESC;
--ORDER BY 연봉 DESC; --별칭 사용 가능
--ORDER BY 3 ASC; --컬럼 순번 사용 가능
ORDER BY HIRE_DATE ASC; --ORDER BY는 문자열과 날짜기준도 정렬 가능









