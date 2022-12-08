/*

    <SUBQUERY (서브쿼리)>
    하나의 주된 SQL(SELECT,CREAT,INSERT,UPDATE,...)안에 포함된 또하나의 SELECT문
    
    메인 SQL문을 위해서 보조 역할을 하는 SELECT문
    -주로 조건절에서 사용
*/

--간단 서브쿼리 예시 1
--노옹철 사원과 같은 부서인 사원들
--1)먼저 노옹철 사원의 부서코드를 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='노옹철'; --D9

--2)D9 부서에 해당하는 사원들을 조회
SELECT EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D9';

--위에 두 단계를 합치기 - 서브쿼리
SELECT EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE=(SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME='노옹철');

--간단 서브쿼리 예시2
--전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번,이름,직급코드 조회
--1)전체 사원들의 평균 급여
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;
--2)평균급여(3047663)보다 많이 받는 사원
SELECT EMP_ID,EMP_NAME,JOB_CODE
FROM EMPLOYEE
WHERE SALARY > 3047663;

--3)하나로 합치기 - 서브쿼리
SELECT EMP_ID,EMP_NAME,JOB_CODE
FROM EMPLOYEE
WHERE SALARY > (SELECT ROUND(AVG(SALARY))
                FROM EMPLOYEE);

/*
    서브쿼리 구분
    서브쿼리를 수행한 결과값이 몇행 몇열이냐에 따라 분류
    
    -단일행(단일열) 서브쿼리 : 서브쿼리를 수행한 결과값이 오로지 1개일때 (한칸의 컬럼값으로 나올때)
    -다중행(단일열) 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 행일때
    -(단일행) 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 열일때
    -다중행 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러행 여러열 일때

    -서브쿼리를 수행한 결과가 몇행 몇열이냐에 따라 사용가능한 연산자가 달라진다.
*/

/*
    단일행 (단일열) 서브쿼리 
    서브쿼리의 조회 결과값이 오로지 1개일때
    일반 연산자 사용 가능(=, !=, >=, <=, <, >)
*/

--전 직원의 평균급여보다 더 적게받는 사원들의 사원명,직급코드,급여 조회
SELECT EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT ROUND(AVG(SALARY))
                FROM EMPLOYEE);

--최저급여를 받는 사원의 사번,사원명,직급코드,급여,입사일 조회
SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);
--노옹철 사원의 급여보다 더 많이 받는 사원들의 사번,이름,부서코드,급여 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME='노옹철');
--노옹철 사원의 급여보다 더 많이 받는 사원들의 사번,이름,부서명,급여 조회 - (서브쿼리+조인)
--ORACLE
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,SALARY
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+)
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME='노옹철');
--ANSI
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME='노옹철');


--부서별 급여 합이 가장 큰 부서 하나만을 조회, 부서코드,부서명,급여의 합 
--1)각 부서별 급여 합 + 가장 큰 합
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--2)1단계를 토대로 서브쿼리 만들어보기
--ANSI
SELECT DEPT_CODE,DEPT_TITLE,SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
GROUP BY DEPT_CODE,DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);

/*
    2. 다중행 서브쿼리 
       서브쿼리의 조회 결과가 여러 행일 경우
           IN (10,20,30) 서브쿼리 : 여러개의 결과값 중에서 하나라도 일치하는 것이 있다면 / NOT IN : 없다면
        > ANY (10,20,30) 서브쿼리 : 여러개의 결과값 중에서 하나라도 클 경우, 즉 여러개의 결과값중에서
                                   조건에 가장 작은값보다 클경우
        < ANY (10,20,30) 서브쿼리 : 여러개의 결과값 중에서 하나라도 작을 경우, 즉 여러개의 결과값 중에서 
                                   조건에 가장 큰값보다 작을 경우
    
       > ALL : 여러개의 결과값 중의 모든 값보다 클경우
       < ALL : 여러개의 결과값 중에 모든 값보다 작을경우 
*/

--각 부서 별 최고 급여를 받는 사원의 이름,직급코드,급여 조회
--1) 각 부서별 최고급여 조회(여러행,단일열)
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; --(2890000,3660000,8000000,3760000,3900000,2490000,2550000)

--2) 위에 결과값으로 사원의 이름 직급코드 급여 조회하기
SELECT EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000,3660000,8000000,3760000,3900000,2490000,2550000);

--3)하나로 합치기
SELECT EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);
                 
--선동일 또는 유재식 사원과 같은 부서인 사원들을 조회하시오(사원명,급여,부서코드)
SELECT EMP_NAME,SALARY,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN('선동일','유재식'));

--이오리 또는 하동운 사원과 같은 직급인 사원들을 조회하시오(사원명,직급코드,부서코드,급여)
SELECT EMP_NAME,JOB_CODE,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('이오리','하동운'));
                   
--대리임에도 과장보다 급여를 많이 받는 사원을 조회해보자 ( 사번,이름,직급,급여 )
--1)과장들의 급여를 조회 
SELECT SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND JOB_NAME = '과장'; -- 220/250/376

--2)위에 급여보다 하나라도 더 많이받는 사원들 조회
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY(2200000,2500000,3760000);

--위에 두 쿼리를 합치면서 대리만 조회하기 
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (SELECT SALARY
                FROM EMPLOYEE E,JOB J
                WHERE E.JOB_CODE=J.JOB_CODE
                AND JOB_NAME = '과장') --220/250/376 
AND JOB_NAME = '대리';

--ORACLE
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND SALARY > ANY (SELECT SALARY
                FROM EMPLOYEE E,JOB J
                WHERE E.JOB_CODE=J.JOB_CODE
                AND JOB_NAME = '과장')
AND JOB_NAME = '대리';

--과장직급임에도 '모든' 차장직급의 급여보다도 더 많이 받는 직원 조회(사번,이름,직급명,급여)
--ANSI
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME='차장')
AND JOB_NAME='과장';

--ORACLE
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND SALARY > ALL(SELECT SALARY
                    FROM EMPLOYEE E, JOB J
                    WHERE E.JOB_CODE=J.JOB_CODE
                    AND JOB_NAME='차장')
AND JOB_NAME='과장';

/*
    3. (단일행) 다중열 서브쿼리
    서브쿼리 조회 결과가 값은 한 행이지만, 나열된 컬럼의 개수가 여러개일 경우
*/

--하이유 사원과 같은 부서코드,같은 직급코드에 해당되는 사원들 조회(사원명,부서코드,직급코드,고용일)
--1) 하이유 사원의 부서코드와 직급코드를 조회
SELECT DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME='하이유'; --D5 J5

--2) 부서코드가 D5이고 직급코드가 J5 사원들 조회
SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
AND JOB_CODE='J5';

--3)하나로 합치기 -- 단일행 서브쿼리버전
SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE 
                   FROM EMPLOYEE
                   WHERE EMP_NAME='하이유')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME='하이유');
--다중열 서브쿼리 버전
--(비교대상컬럼1,비교대상컬럼2) = (비교할값1,비교할값2) - 이 형식에 맞춰 서브쿼리를 제시해야한다.
SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) = (SELECT DEPT_CODE,JOB_CODE
                              FROM EMPLOYEE
                              WHERE EMP_NAME='하이유');--다중열 서브쿼리 이용

--박나라 사원과 같은 직급코드,같은 사수사번을 가진 사원들의 사번,이름,직급코드,사수사번 조회
--다중열 서브쿼리를 이용하여.
SELECT EMP_ID,EMP_NAME,JOB_CODE,MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE,MANAGER_ID) = (SELECT JOB_CODE,MANAGER_ID
                               FROM EMPLOYEE
                               WHERE EMP_NAME='박나라');
                              
/*
    4.다중행 다중열 서브쿼리
    
    서브쿼리 조회 결과가 여러행 여러열일 경우
*/

--각 직급별 최소 급여를 받는 사원들 조회(사번,이름,직급코드,급여)
--1)각 직급별 최소 급여를 조회
SELECT JOB_CODE,MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

--2)위에 조건에 만족하는 사원
--2-1) OR 조건나열
SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) = ('J2',3700000)
OR (JOB_CODE,SALARY) = ('J7',1380000)
OR (JOB_CODE,SALARY) = ('J3',3400000)
OR (JOB_CODE,SALARY) = ('J6',2000000)
OR (JOB_CODE,SALARY) = ('J5',2200000)
OR (JOB_CODE,SALARY) = ('J1',8000000)
OR (JOB_CODE,SALARY) = ('J4',1550000);

SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (('J2',3700000)
                            ,('J7',1380000)
                            ,('J3',3400000)
                            ,('J6',2000000)
                            ,('J5',2200000)
                            ,('J1',8000000)
                            ,('J4',1550000));

--서브쿼리로 해보기
SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (SELECT JOB_CODE,MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);

--각 부서별 최고 급여를 받는 사원들 조회(사번,이름,부서코드,급여)
--부서가 없을경우 NULL => NULL처리 함수를 사용하여 '없음' 표기할것
SELECT EMP_ID,EMP_NAME,NVL(DEPT_CODE,'없음'),SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'없음'),SALARY) IN (SELECT NVL(DEPT_CODE,'없음'),MAX(SALARY)
                             FROM EMPLOYEE
                             GROUP BY DEPT_CODE);

-----------------------------------------------------------------------

/*
    5.인라인뷰 
    FROM절에서 서브쿼리를 제시하는것
    
    서브쿼리를 수행한 결과 (RESULT SET)을 테이블 대신 사용하겠다.

*/

--보너스 포함 연봉이 3000만원 이상인 사원들의 사번,이름,보너스포함연봉,부서코드 조회
SELECT EMP_ID,EMP_NAME,(SALARY+(SALARY * NVL(BONUS,0)))*12 "보너스포함연봉",DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY+(SALARY * NVL(BONUS,0)))*12 >= 30000000;

--인라인뷰를 이용하여 사원명만 골라내기
SELECT EMP_NAME
FROM (SELECT EMP_ID,EMP_NAME,(SALARY+(SALARY * NVL(BONUS,0)))*12 "보너스포함연봉",DEPT_CODE
      FROM EMPLOYEE
      WHERE (SALARY+(SALARY * NVL(BONUS,0)))*12 >= 30000000);

--인라인뷰에서 사용한 별칭을 메인 SELECT절에서 컬럼명으로 이용할 수 있다.
SELECT 보너스포함연봉
FROM (SELECT EMP_ID,EMP_NAME,(SALARY+(SALARY * NVL(BONUS,0)))*12 "보너스포함연봉",DEPT_CODE
      FROM EMPLOYEE
      WHERE (SALARY+(SALARY * NVL(BONUS,0)))*12 >= 30000000);

--TOP-N 분석 : 데이터베이스 상에 있는 자료중 최상위 N개의 자료를 보기위해 사용하는 기능
--ROWNUM : 오라클에서 제공해주는 컬럼,조회된 순서대로 1번부터 순번을 부여해준다.

--전 직원 중 급여가 가장 높은 상위 5명(순위,사원명,급여)
SELECT ROWNUM 순위,EMP_NAME 사원명,SALARY 급여
FROM EMPLOYEE  --FROM이 실행됨과 동시에 ROWNUM 번호가 매겨진다. 
--WHERE ROWNUM <=5
ORDER BY 급여 DESC; --그래서 급여 DESC를 해도 ROWNUM이 뒤죽박죽이 되는것.

SELECT ROWNUM 순위,EMP_NAME 사원명,SALARY 급여
FROM (SELECT *
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <=5;

--각 부서별 평균 급여가 높은 3개의 부서의 부서코드,평균 급여 조회
--1) 각 부서별 평균 급여 -> 높은순으로
SELECT DEPT_CODE,ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;

SELECT ROWNUM 순위,S.*
FROM (SELECT DEPT_CODE 부서코드,ROUND(AVG(SALARY))"평균 급여"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY) DESC) S --인라인뷰에 별칭 넣기
WHERE ROWNUM <=3;

--ROWNUM으로 순위를 매길수 있다.
--다만 정렬되지 않은 상태에서 매기는 순번은 의미가 없으니
--인라인뷰에서 정렬후에 순번을 매기는 형식으로 사용한다.

--가장 최근에 입사한 사원 5명 조회 (사원명,급여,입사일)
--입사일 기준 미래~과거(내림차순), 순번 부여 후 5명 뽑기

--SELECT ROWNUM,EMP_NAME,SALARY,HIRE_DATE
SELECT ROWNUM,E.*
FROM (SELECT EMP_NAME,SALARY,HIRE_DATE
      FROM EMPLOYEE
      ORDER BY HIRE_DATE DESC) E
WHERE ROWNUM <= 5;

/*
    6. 순위를 매겨주는 함수 (WINDOW FUNCTION)
    RANK() OVER(정렬 기준)
    DENSE_RANK() OVER(정렬 기준)
    
    -RANK() OVER(정렬 기준) : 공동 1위가 3명이라고 한다면 그 다음 순위는 4위로 하겠다.
    -DENSE_RANK() OVER(정렬 기준) : 공동 1위가 3명이라고 해도 그 다음 순위는 무조건 2위로 하겠다.
    
    정렬 기준 : ORDER BY 절(정렬기준 컬럼이름, 오름차순/내림차순),NULLSFIRST/NULLSLAST는 기술 불가능
    
    SELECT절에서만 사용 가능
*/
--사원들의 급여가 높은 순서대로 매겨서 사원명,급여,순위 조회 : RANK() OVER()
SELECT EMP_NAME,SALARY,RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;

SELECT EMP_NAME,SALARY,DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;

--5위까지만 조회하겠다
SELECT EMP_NAME,SALARY,RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE
WHERE RANK() OVER(ORDER BY SALARY DESC) <=5; 

--인라인뷰
SELECT E.*,'등'
FROM(SELECT EMP_NAME,SALARY,RANK() OVER(ORDER BY SALARY DESC) "순위"
     FROM EMPLOYEE) E
WHERE 순위 <=5;






      








