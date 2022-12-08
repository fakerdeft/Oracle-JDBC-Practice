/*
    < JOIN >
    
    두개 이상의 테이블에서 데이터를 같이 조회하고자 할 때 사용하는 구문 -> SELECT 문 이용
    조회 결과는 하나의 결과물 (RESULT SET)으로 나온다.
    
    JOIN을 사용하는 이유
    관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있다.
    사원정보는 사원테이블, 직급정보는 직급테이블 ,,..등등 -> 중복을 최소화하기 위해
    -즉 JOIN구문을 이용해서 여러개 테이블간의 관계를 맺음으로써 같이 조회를 한다.
    -단 테이블 간에 동일컬럼(연결고리)를 이용해서 해당 컬럼을 매칭시켜 조회를 해야한다.
    
    문법상 분류 : JOIN은 크게 오라클 전용구문과 ANSI(미국 국립표준 협회) 구문으로 나뉜다.
    
    개념상 분류 
    
    오라클 전용 구문                       |               ANSI구문 (오라클 +다른 DBMS)
    ================================================================================
    등가조인(EQUAL JOIN)                  |             내부조인(INNER JOIN) -> JOIN USING/ON
    ----------------------------------------------------------------------------------
    포괄 조인                             |         외부조인(OUTER JOIN) -> JOIN USING
    LEFT OUTER JOIN                      |         왼쪽 외부조인(LEFT OUTER JOIN)
    RIGHT OUTER JOIN                     |         오른쪽 외부조인(RIGHT OUTER JOIN)
                                         |         전체 외부조인 (FULL OUTER JOIN) : 오라클에서는 불가능
----------------------------------------------------------------------------------------------
    카테시안 곱(CARTESIAN PRODUCT)        |          교차조인 (CROSS JOIN)
----------------------------------------------------------------------------------------------
    자체조인(SELF JOIN)
    비등가 조인(NON EQUAL JOIN)
    -----------------------------------------------------------------------------------------
    다중조인 (테이블 3개이상 조인)
    
*/
​
--JOIN을 사용하지 않는 예
--전체 사원들의 사번,사원명,부서코드,부서명까지 알아내보자
SELECT EMP_ID,EMP_NAME,DEPT_CODE
FROM EMPLOYEE;
​
SELECT DEPT_ID,DEPT_TITLE
FROM DEPARTMENT;
​
--조인을 통해서 연결고리에 해당하는 컬럼만 제대로 매칭시킨다면 하나의 결과물로 조회할 수 있다.
​
/*
    등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
    연결시키고자 하는 컬럼의 값이 "일치하는 행들만" 조인되어 조회
    (일치하지 않는 값들은 결과에서 제외된다)
    -동등비교연산자를 사용한다 =
    
    [표현법]
    등가조인(오라클 구문)
    SELECT 조회하고자 하는 컬럼명들 나열
    FROM 조인하고자하는 테이블명들 나열
    WHERE 연결할 컬럼에 대한 조건을 제시 (=)
    
    내부조인(ANSI 구문)
    SELECT 조회하고자 하는 컬럼명들 나열
    FROM 기준으로 삼을 테이블명 1개 제시
    JOIN 조인할 테이블명 1개만 제시 ON(연결할 컬럼에 대한 조건제시 (=)) 
    
    내부조인(ANSI 구문) : USING
    SELECT 조회하고자 하는 컬럼명들 나열
    FROM 기준으로 삼을 테이블명 1개 제시
    JOIN 조인할 테이블명 1개 제시 USING(연결할 컬럼명1개)   - *연결할 컬럼명이 동일할 경우에 사용한다!
    
    ***만약 연결할 컬럼명이 동일하다면 USING구문을 제외하고 
        명시적으로 어떤 테이블로부터 온 컬럼명인지 제시해야한다 (테이블명 또는 별칭을 이용한다.)
*/
​
--오라클 전용 구문
--FROM 절에 조회하고자 하는 테이블들 나열
--WHERE절에 매칭시킬 컬럼명(연결고리)에 대한 조건 제시 
​
--전체 사원들의 사번,사원명,부서코드,부서명 까지 알아내고자 한다면?
--1) 연결할 두 컬럼명이 다른경우 ( EMPLOYEE - DEPT_CODE / DEPARTMENT - DEPT_ID ) 
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID; -- DEPT_CODE랑 DEPT_ID랑 일치하다면 조회해줘
--일치하지 않는 값들은 조회되지 않음 
--일치하지 않는 NULL,D3,D4,D7 부서 데이터는 조회되지 않는다.
​
--전체 사원들의 사번,사원명,직급코드,직급명까지 조회해보자.
/*
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE,JOB
WHERE JOB_CODE=JOB_CODE;
--column ambiguously defined : 컬럼이 모호하기때문에 어떤 테이블에 컬럼인지를 명시해주어야한다.
*/
​
--방법1) 테이블명을 이용하는 방법 - 테이블명.컬럼명
SELECT EMP_ID,EMP_NAME,EMPLOYEE.JOB_CODE,JOB_NAME
FROM EMPLOYEE,JOB
WHERE EMPLOYEE.JOB_CODE=JOB.JOB_CODE;
​
--방법2) 테이블에 별칭을 지정하고 별칭을 이용하는 방법 - 별칭.컬럼명
SELECT EMP_ID,EMP_NAME,E.JOB_CODE,JOB_NAME
FROM EMPLOYEE E,JOB J 
WHERE E.JOB_CODE=J.JOB_CODE;
​
-- ANSI 구문으로 조인해보기
--FROM 절에 기준 테이블을 하나만 기술한뒤
--그 뒤에 JOIN절에서 같이 조회하고자 하는 테이블을 기술하고 매칭시킬 컬럼에 대한 조건도 기술한다.
--USING구문(동일컬럼명)과 ON(아닐시)구문이 있다.
​
--전체 사원들의 사번,사원명,부서코드,부서명 조회하기 - ANSI로
--1)연결할 두 컬럼명이 다른경우 (DEPT_CODE/DEPT_ID) - ON구문만 사용 가능
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
​
--전체 사원들의 사번,사원명,직급코드,직급명 조회하기 -ANSI
--2)연결할 두 컬럼명이 같을 경우 USING/ON 둘다 사용가능
--USING구문은 동일한 컬럼명을 사용하면 알아서 매칭시켜주기 때문에 AMBIGUOUSLY가 발생하지 않는다
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE); --USING 구문 
--JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE); --ON구문
​
--직급이 대리인 사원들의 정보를 조회(사번,사원명,월급,직급(직급코드가 아닌 직급명))
​
-->오라클전용
SELECT EMP_ID,EMP_NAME,SALARY,JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND JOB_NAME='대리';
-->ANSI
SELECT EMP_ID,EMP_NAME,SALARY,JOB_NAME
FROM EMPLOYEE E
--JOIN JOB J USING(JOB_CODE)
/*INNER 생략가능*/ JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE)
WHERE JOB_NAME='대리';
​
--오라클 구문과 ANSI구문으로 다 해보기 
​
-- 1. 부서가 '인사관리부' 인 사원들의 사번, 사원명, 보너스를 조회
--오라클 구문
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
AND DEPT_TITLE='인사관리부';
--ANSI 구문
SELECT EMP_ID,EMP_NAME,BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE='인사관리부';
-- 2. 부서가 '총무부' 가 아닌 사원들의 사원명, 급여, 입사일을 조회
--오라클
SELECT EMP_NAME,SALARY,HIRE_DATE,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
AND DEPT_TITLE !='총무부';
--ANSI
SELECT EMP_NAME,SALARY,HIRE_DATE,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE !='총무부';
-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
--오라클
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
AND BONUS IS NOT NULL;
--ANSI
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE BONUS IS NOT NULL;
-- 4. 아래의 두 테이블을 참고해서 부서코드, 부서명, 지역코드, 지역명(LOCAL_NAME) 조회
SELECT * FROM DEPARTMENT; -- LOCATION_ID
SELECT * FROM LOCATION; -- LOCAL_CODE
​
--ORACLE
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT,LOCATION
WHERE LOCATION_ID=LOCAL_CODE;
--ANSI
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE);
​
--등가조인/내부조인(INNER) : 일치하지 않는 행들은 조회되지 않음
​
--전체 사원들의 사원명,급여,부서명
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
ORDER BY 1;
​
SELECT * FROM EMPLOYEE;
​
------------------------------------------JOIN 실습문제---------------------------------------------
--3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
--오라클
SELECT EMP_ID,EMP_NAME,JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND EMP_NAME LIKE '%형%';
--ANSI
SELECT EMP_ID,EMP_NAME,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%형%';
--4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
--오라클
SELECT EMP_NAME,JOB_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE E,JOB J,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE=J.JOB_CODE
AND DEPT_CODE IN ('D5','D6');
--ANSI
SELECT EMP_NAME,JOB_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE E
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_CODE IN ('D5','D6');
--5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
--오라클
SELECT EMP_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE,DEPARTMENT,LOCATION
WHERE DEPT_CODE=DEPT_ID
AND LOCATION_ID=LOCAL_CODE
AND BONUS IS NOT NULL;
--ANSI
SELECT EMP_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
WHERE BONUS IS NOT NULL;
--6. 사원 명, 직급 명, 부서 명, 지역 명 조회
--오라클
SELECT EMP_NAME,JOB_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E,JOB J,DEPARTMENT D,LOCATION L
WHERE E.JOB_CODE=J.JOB_CODE
AND E.DEPT_CODE=D.DEPT_ID
AND D.LOCATION_ID=L.LOCAL_CODE;
--ANSI
SELECT EMP_NAME,JOB_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE);
--7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
--오라클
SELECT EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE,DEPARTMENT,LOCATION L,NATIONAL N
WHERE DEPT_CODE=DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE=N.NATIONAL_CODE
AND NATIONAL_NAME IN ('한국','일본');
--ANSI
SELECT EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국','일본');
--8. 어떤 한 사원과 같은 부서에서 일하는 사원의 이름 조회 (SELF JOIN)
--오라클
SELECT E.EMP_NAME "E테이블 이름",E.DEPT_CODE,D.EMP_NAME "D테이블 이름"
FROM EMPLOYEE E,EMPLOYEE D
WHERE E.DEPT_CODE=D.DEPT_CODE
AND E.EMP_NAME != D.EMP_NAME
ORDER BY 1;
--ANSI
SELECT E.EMP_NAME "E테이블 이름",E.DEPT_CODE,D.EMP_NAME "D테이블 이름"
FROM EMPLOYEE E
JOIN EMPLOYEE D ON E.DEPT_CODE=D.DEPT_CODE
WHERE E.EMP_NAME!=D.EMP_NAME
ORDER BY 1;
--9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
--오라클
SELECT EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND BONUS IS NULL
AND E.JOB_CODE IN ('J4','J7')
ORDER BY 3;
--ANSI
SELECT EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_CODE IN ('J4','J7')
ORDER BY 3;
​
------------------------------------------------------------------------------------------
​
/*
    2. 포괄조인 / 외부조인 (OUTER JOIN)
    
    테이블간의 JOIN 시에 '일치하지 않는 행'도 포함시켜 조회할 수 있다.
    단, 반드시 LEFT / RIGHT 를 지정하여 기준이 되는 테이블을 지정해야한다.
    
    일치하는 행+기준이 되는 테이블 기준으로 일치하지 않는 행도 포함시켜서 조회한다.
*/
​
--전체 사원들의 사원명,급여,부서명
--ANSI 구문
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--EMPLOYEE테이블이 기준이되었기 때문에 EMPLOYEE테이블에 존재하는 데이터는 전부 조회되었다.
​
--ORACLE 구문
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+);
--내가 기준으로 삼을 테이블의 컬럼이 아닌 반대 테이블의 컬럼에 (+) 를 붙여줘야한다.
​
--2)RIGHT OUTER JOIN : 두테이블 중 오른편에 기술된 테이블을 기준으로 JOIN 
--                        오른편에 기술된 테이블의 데이터는 전부 조회한다.
--ANSI 
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--ORACLE 
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE(+)=DEPT_ID;
​
--3)FULL OUTER JOIN : 두 테이블이 가진 모든 행을 조회
--일치하는행 + LEFT에서 추가된 행 + OUTER에서 추가된 행
​
--ANSI
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--ORACLE --only one outer-joined table 오라클 전용구문으로는 FULL OUTER JOIN은 할 수 없다.
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE(+)=DEPT_ID(+);
​
/*
    3.카테시안 곱(CARTESIAN PRODUCT) / 교차조인(CROSS JOIN)
    모든 테이블의 각 행들이 서로 매핑된 데이터가 조회된다
    두 테이블의 행들이 모두 곱해진 행들의 조합이 출력됨
    -각각 N개 M개의 행을 가진 테이블들이 있을때 N*M의 행이 출력된다.
    -모든 경우의 수를 다 처리하고자 할때.
    -방대한 데이터를 출력하고자 하기 때문에 과부하의 위험이 있다.
*/
--사원명,부서명
--ORACLE
SELECT EMP_NAME,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT; --207행
--ANSI
SELECT EMP_NAME,DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;
--WHERE절에 기술해야할 조건이 잘못되었거나 아예 없는 경우 발생
​
/*
    4.비등가 조인(NON EQUAL JOIN)
    
    = 등호를 사용하지 않는 조인문 -> 다른 비교 연산자를 써서 조인하겠다.(>,<,>=,<=,BETWEEN A AND B)
    -지정한 컬럼 값들이 일치하는 경우가 아니라 '범위'에 포함되는 경우 매칭해서 조회하겠다.
    
    CF) 등가조인 -> '='으로 일치하는 경우만 조회
        비등가조인 -> '='가 아닌 다른 비교연산자들로 '범위'에 포함되는 경우를 조회
*/
​
--사원명,급여
SELECT EMP_NAME,SALARY
FROM EMPLOYEE;
​
--SAL_GRADE 테이블 조회
SELECT *
FROM SAL_GRADE;
​
--사원명,급여,급여등급
--ORACLE
SELECT EMP_NAME,SALARY,SG.SAL_LEVEL
FROM EMPLOYEE,SAL_GRADE SG
WHERE SALARY BETWEEN SG.MIN_SAL AND SG.MAX_SAL;
--ANSI
SELECT EMP_NAME,SALARY,SG.SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE SG ON (SALARY>=MIN_SAL AND SALARY <= MAX_SAL);
--USING구문 사용 불가 
​
/*
    5.자체조인 (SELF JOIN)
    같은 테이블끼리 조인하는 경우
    자기 자신과 조인하겠다.
    -자체 조인의 경우 테이블에 반드시 별칭을 부여하여야 한다.(다른 테이블로 인식하게끔)
*/
​
--사원의 사번과 사원명 사수의 사번과 사원명을 뽑아보자
--ORACLE
SELECT E.EMP_ID 사번,E.EMP_NAME 사원명,M.EMP_ID 사수사번,M.EMP_NAME 사수명
FROM EMPLOYEE E,EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);
​
--ANSI
SELECT E.EMP_ID 사번,E.EMP_NAME 사원명,M.EMP_ID 사수사번,M.EMP_NAME 사수명
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
​
/*
   < 다중 JOIN >
    
    3개이상의 테이블을 조인하겠다
    -조인 순서 중요
*/
​
--ORACLE 
SELECT EMP_ID "사번",EMP_NAME "사원명",DEPT_TITLE "부서명",JOB_NAME "직급명"
FROM EMPLOYEE E,DEPARTMENT D,JOB J
WHERE DEPT_CODE=DEPT_ID
AND E.JOB_CODE=J.JOB_CODE;
​
--ANSI
SELECT EMP_ID "사번",EMP_NAME "사원명",DEPT_TITLE "부서명",JOB_NAME "직급명"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN JOB USING(JOB_CODE);