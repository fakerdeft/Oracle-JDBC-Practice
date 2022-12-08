-------------------그룹 함수-------------------
--그룹함수: 데이터들의 합(SUM), 데이터들의 평균(AVG),...등등
--N개의 값을 읽어서 1개의 결과값 반환

--1.SUM(숫자타입컬럼): 해당 컬럼값들의 총 합계 반환해주는 함수
--전체 사원들의 총 급여 합계
SELECT SUM(SALARY)
FROM EMPLOYEE;

--부서 코드가 'D5'인 사원들의 총 합계
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--남자 사원들의 총 급여 합계
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)=1;

--2.AVG(숫자 타입 컬럼):해당 컬럼값들의 평균을 구해서 반환
--전체 사원들의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

--3.MIN(아무타입): 해당 컬럼값들 중 가장 작은 값 반환
--전체 사원들 중 최저급여, 가장 작은 이름값, 가장 작은 이멜, 제일 오래된 입사일
SELECT MIN(SALARY), MIN(EMP_NAME), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME
FROM EMPLOYEE
ORDER BY EMP_NAME;

SELECT EMAIL
FROM EMPLOYEE
ORDER BY EMAIL;

SELECT HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE;

--MIN함수의 경우 오름차순으로 정렬 시 가장 위의 값을 보여줌

--4.MAX(아무타입): 해당 컬럼들 중 가장 큰 값을 반환
SELECT MAX(SALARY),MAX(EMP_S),MAX(HIR_DATE)
FROM EMPLOYEE;
--MAX함수의 경우 내림차순으로 정렬 시 가장 위의 값 보여줌

--5. COUTNT(컬럼이름):조회된 행의 개수를 세어서 반환
--COUNT(*): 조회결과에 해당하는 모든 행의 개수를 다 세어서 반한
--COUNT(컬럼이름): 제시한 해당 컬럼값이 NULL이 아닌 것만 개수세어서 반환
--COUNT(DISTINCT 컬럼이름): 제시한 해당 컬럼값이 중복값 있을 경우
--하나로만 개수 세어서 반환, NULL 포함X

SELECT*
FROM EMPLOYEE;
--전체 사원 수 조회
SELECT COUNT(*)
FROM EMPLOYEE;
--부서배치가 된 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;
--부서배치가 된 여자 사 수 
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
AND SUBSTR(EMP_NO,8,1)=2;
--사수가 있는 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

SELECT COUNT(MANAGER_ID)
FROM EMPLOYEE;

--현재 사원들이 속해있는 부서의 갯수
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

--유효한 직급의 개수                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               -------
SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;

SELECT COUNT(DISTINCT JOP_CODE)
FROM EMPLOYEE;


/*
    <GROUP BY 설>
    
    그룹을 묶어줄 기준을 제시할 수 있는 구문 -> 그룹함수와 같이 쓰인다.
    해당 제시된 기준별로 그룹을 묶을 수 있다.
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용한다.
    
    [표현법]
    GROUP BY 묶어줄 기준 칼럼   


*/
--각 부서별로 총 급여의 합계
SELECT  DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--'D1'부서의 총 급여 합
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1'
GROUP BY DEPT_CODE;

--각 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--각 부서별 총 급여합을 부서별 오름차순으로 정렬해서 조회
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE  
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--각 직급별 직급코드,총급여합,사원수,보너스를 받는 사원수,평균급여,최소급여,최고급여를 조회
SELECT JOB_CODE
      ,COUNT(*) 사원수
      ,COUNT(BONUS) "보너스를 받는 사원수"
      ,ROUND(AVG(SALARY))평균급여
      ,MIN(SALARY) 최소급여
      ,MAX(SALARY) 최고급여
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--각 부서별 부서코드,사원수,보너스를 받는 사원 수,사수가 있는 사원 수, 평균급여
SELECT DEPT_CODE
      ,COUNT(*)
      ,COUNT(BONUS)
      ,COUNT(MANAGER_ID)
      ,ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--성별 별 사원 수
SELECT SUBSTR(EMP_NO,8,1)
      ,COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

--성별 기준으로 평균 급여
SELECT CASE WHEN SUBSTR(EMP_NO,8,1)=1 THEN '남'
            WHEN SUBSTR(EMP_NO,8,1)=2 THEN '여'
       END 성별
       ,ROUND(AVG(SALARY)) 평균급여
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

--각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE,ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY)>=3000000 --오류!
GROUP BY DEPT_CODE;

/*
    <HAVING 절>
    그룹에 대한 조건을 제시하고자 할 때 사용되는 구문(주로 그룹함수를 가지고 조건 제시)
    -GROUP BY절 뒤에 쓰인다
*/

--각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY)) 평균급여
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >=3000000;

--각 직급별 급여 평균이 300만원 이상인 직급 코드, 평균 급여, 사원수, 최고급여, 최소급여
SELECT JOB_CODE "직급코드"
      ,ROUND(AVG(SALARY)) 평균급여
      ,COUNT(*) 사원수
      ,MAX(SALARY) 최고급여
      ,MIN(SALARY) 최소급여
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING AVG(SALARY) >=3000000;

--각 직급별 총 급여합이 1000만원 이상인 직급코드, 급여 합을 조회
SELECT JOB_CODE "직급코드"
      ,SUM(SALARY) "급여 합"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >=10000000;

--각 부서별 보너스를 받는 사원이 없는 부서만을 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS)=0;

--각 부서별 평균 급여가 350만원 이하인 부서만을 조회
SELECT DEPT_CODE 부서코드
      ,ROUND(AVG(SALARY)) "평균 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) <=3500000;

-----------------------------------------------

/*
    <SELECT문 구조 및 실행순서>
    
    1.FROM절 조회하고자 하는 테이블명 / 가상테이블(DUAL)
    2.WHERE절 조건식 (그룹함수는 안된다)
    3.GROUP BY절 그룹 기준에 해당하는 컬럼명 또는 함수식
    4.HAVING 그룹함수식에 대한 조건식
    5.SELECT 조회하고자 하는 컬럼명들 나열 / * /리터럴/산술연산식/함수식
    6.ORDER BY절 정렬기준에 해당하는 컬럼명 /별칭/컬럼의 순번 -ASC/DESC /NULLS FIRST/NULLS LAST
*/
-------------------------------------------------
/*
    <집합 연산자 SET OPERATOR>
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    -UNION(합집합): 두 쿼리문을 수행한 결과값을 더한 후 중복되는 부분은 한번만 빼서 중복제거한 것
    -UNION ALL: 두 쿼리문을 수행한 결과값을 더한 후 중복제거를 하지 않은 것 - 합집합 + 교집합
    -INTERSECT(교집합): 두 쿼리문을 수행한 결과값의 중복된 부분 -> AND
    -MINUS(차집합): 선행 쿼리문 결과값에서 후행 쿼리문 결과값을 뺀 나머지 부분 -> 선행쿼리문 결과값 - 교집합
    
    주의: 두 쿼리문의 결과를 합쳐서 한개의 테이블로 보여줘야하기 때문에 두 쿼리문의 SELECT절 부분은
        같아야 한다. 즉, 조회할 컬럼이 동일해야한다.
*/

--1.UNION(합집합): 두 쿼리문을 수행한 결과값을 더하지만 중복은 제거한다.
--부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들 조회(사번,사원명,부서코드,급여) -> OR

--부서코드가 D5인 사원들만 조회 OR 급여 300만원 초과인 사원 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY > 3000000;

SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--UNION으로 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--직급코드가 J6인 사원 + 부서코드가 D1인 사원 UNION으로 합치기
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6';

SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

--2. UNION ALL: 여러개의 쿼리 결과를 더해서 보여주는 연산자(중복제거X)
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
UNION ALL
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D1';
-->9명 6+3: 중복제거 하지 않고 결과값 전부 더해서 보여줌

--3. INTERSECT: 교집합, 여러쿼리 결과의 중복된 결과만을 조회->AND
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
INTERSECT
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D1';
--2명(중복된 결과만)
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D1' AND JOB_CODE='J6';

--4.MINUS: 차집합, 선행쿼리결과에 후행쿼리결과를 뺀 나머지
--선행 쿼리문
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
MINUS
--후행
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D1';
--4명 중복된 2명 제외
