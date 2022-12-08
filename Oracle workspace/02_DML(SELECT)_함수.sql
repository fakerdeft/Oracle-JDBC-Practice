/*
    <함수 FUNCTION>
    자바로 따지면 메소드와 같은 존재
    매개변수로 전달된 값들을 읽어서 계산한 결과 반환->
    
    -단일형 함수: N개의 값을 읽어서 N개의 결과 리턴 (매 행마다 함수 실행 후 결과 반환)
    -그룹 함수: N개의 값을 읽어서 1개의 결과 리턴 (하나의 그룹별로 함수 실행 후 결과 반환)
    
    단일행 함수와 그룹 함수는 함께 사용 X -> 결과의 행수가 다르기 때문
    
    =======<단일행 함수>=======
    
    문자열과 관련된 함수
    LENGTH / LEGHTHB
    
    -LENGTH(문자열) - 해당 전달된 문자열의 글자 수 반환
    -LENGTHB(문자열) - 해당 전달된 문자열의 바이트 수 반환
    
    결과값은 숫자로 반환 => NUMBER
    문자열: 문자열 형식의 리터럴, 문자열에 해당하는 컬럼
    
    한글: '김' -> 'ㄱ' 'ㅣ' 'ㅁ' => 한 글자당 3BYTE로 취급
    영문, 숫자, 특수문자: 한 글자당 1BYTE로 취급

*/
SELECT LENGTH('오라클!'), LENGTHB('오라클!')
FROM DUAL; --DUAL 가상테이블: 산술연산이나 가상 컬럼등 값을 한 번만 조회하고자 할 때 사용할 수 있는 더미 테이블

SELECT '오라클!',1,2,3,'AAA','BBB'
FROM DUAL;

SELECT EMAIL, LENGTH(EMAIL), LENGTH(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

/*
    INSTR
    
    -INSTR(문자열,특정문자,찾을위치,순번) : 문자열로부터 특정 문자의 위치값 반환
    
    찾을 위치와 순번은 생략 가능하다.
    결과값은 NUMBER 타입으로 반환된다.
    찾을 위치(1과 -1로 기본값은 1: 앞에서부터 찾겠다 -1: 뒤에서부터 찾겠다)
*/
SELECT INSTR('AABAACAABBAA','B')
FROM DUAL; --3: 앞에서부터 첫 번째에 위치하는 B값을 찾아 해당 위치값을 돌려줌 
--찾을 위치와 순번을 생략하면 기본적으로 앞에서부터 첫 번째 위치값을 알려준다.

SELECT INSTR('AABAACAABBAA','B',1)
FROM DUAL; --3

SELECT INSTR('AABAACAABBAA','B',-1)
FROM DUAL; --10 : 뒤에서부터 첫 번째 위치하는 B값을 찾아 해당 위치값을 앞에서부터 세어서 알려준다.

SELECT INSTR('AABAACAABBAA','B',-1,2)
FROM DUAL; --9: 뒤에서부터 두 번째 위치하는 B값을 찾아 해당 위치값을 앞에서부터 세어서 알려준다.

SELECT INSTR('AABAACAABBAA','B',1,2)
FROM DUAL; --9: 앞에서부터 두 번째 위치하는 B값을 찾아 해당 위치값을 앞에서부터 세어서 알려준다.

SELECT INSTR('AABAACAABBAA','B',1,0)
FROM DUAL; -- 범위를 벗어난 순번을 제시한다면 오류가 난다.

--인덱스처럼 글자의 위치를 찾는 것은 맞지만 자바처럼 0이 아니라 1부터 시작하는 것을 알 수 있다.

--EMAIL에서 @의 위치를 찾아보자
SELECT EMAIL,INSTR(EMAIL,'@') AS "@의 위치"
FROM EMPLOYEE;

/*
    SUBSTR
    문자열로부터 특정 문자열을 추출하는 함수
    -SUBSTR(문자열,처음위치,추출할 문자개수)
    
    결과값은 CHARACTER 타입으로 반환(문자열 형태)
    추출할 문자개수는 생략 가능(생략을 했을 때 문자열 끝까지 추출하겠다.)
    처음위치는 음수로 제시 가능: 뒤에서부터 N번째 위치로부터 문자를 추출하겠다 라는 의미
*/

SELECT SUBSTR('SHOWMETHEMONEY',7)
FROM DUAL; 

SELECT SUBSTR('SHOWMETHEMONEY',5,2)
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',-8,3)
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',-5)
FROM DUAL;

-----주민등록 번호에서 성별 부분을 추출하기
SELECT EMP_NAME,EMP_NO
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO,8,1) AS 성별
FROM EMPLOYEE;

-----이멜에서 ID부분만 추출
SELECT EMP_NAME,EMAIL
FROM EMPLOYEE;

SELECT EMP_NAME,EMAIL,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) ID
FROM EMPLOYEE;

--남자 사원들만 조회
SELECT EMP_NAME,EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (1,3);
--WHERE SUBSTR(EMP_NO,8,1)=1 OR SUBSTR(EMP_NO,8,1)=3;

--여자 사원들만 조회
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (2,4);
--WHERE 절에 조건으로 제시할 수 있다.

/*
    LAPD / RAPD
    -LPAD/RAPD(문자열, 최종적으로 반환할 문자의 길이(BYTE), 덧붙이고자 하는 문자)
    -제시한 문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N 길이만큼 문자열을 반환
    
    결과값은 CHARACTER 타입으로 반환하며 덧붙이고자 하는 문자는 생략가능하다.
*/

SELECT LPAD(EMAIL,16)
FROM EMPLOYEE;--덧붙이고자 하는 문자 생략시 길이만큼 남는 자리에 ' '공백문자가 들어간다.

SELECT RPAD(EMAIL,20,'#')
FROM EMPLOYEE;

--주민등록번호 조회: 990101-3332232 -> 990101-3******
SELECT EMP_NAME,EMP_NO
FROM EMPLOYEE;

SELECT RPAD('990101-3',14,'*')
FROM DUAL;

--1단계 문자열 추출하기 SUBSTR 함수로 앞 8자리까지만 추출하기
SELECT EMP_NAME,SUBSTR(EMP_NO,1,8)
FROM EMPLOYEE;
--2단계 추출한 문자열 + 14자리까지 *처리
SELECT EMP_NAME,RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS 주민번호
FROM EMPLOYEE;

/*
    LTRIM / RTRIM
    
    -LTRIM / RTRIM(문자열,제거시키고자하는 문자)
    :문자열의 왼쪽 또는 오른쪽에서 제거시키고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환
    
    결과값은 CHARACTER형태로 나온다
    제거시키고자 하는 문자 생략가능 - ' '제거됨
    
*/

SELECT LTRIM('  ASD ')
FROM DUAL;

SELECT LTRIM('00012345066','0')
FROM DUAL;

SELECT RTRIM('00012345650','0')
FROM DUAL;

SELECT LTRIM('12312332653413123','123')
FROM DUAL;

SELECT LTRIM('AQWBEWC','ABC')
FROM DUAL;--제거시키고자 하는 문자열을 통째로 지워주는게 아니라 문자 하나하나가 존재하면 지워주는 원리(일치하지 않을때까지)

/*
    TRIM
    -TRIM(BOTH/LEADING/TRAILING '제거하고자 하는 문자' FROM '문자열')
    문자열의 양쪽/앞쪽/뒤쪽에 있는 특정 문자를 제거한 나머지 문자열을 반환
    
    결과값은 CHARACTER 타입으로 반환
    BOTH/LEADING/TRAILING 생략가능, 생략 시 기본값 BOTH
*/
--기본적으로 양쪽에 있는 문자 제거
SELECT TRIM('    HI       ')
FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZZWWWDASDZZZ')
FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZWWWDASDZZZ')
FROM DUAL; --LEADING 앞쪽 지우기

SELECT TRIM(TRAILING 'Z' FROM 'ZZZZWWWDASDZZZ')
FROM DUAL; --TRAILING 뒤쪽 지우기

/*
    LOWER/UPPER/INITCAP
    -LOWER(문자열)
    :소문자로 변경
    -UPPER(문자열)
    :대문자로 변경
    -INITCAP(문자열)
    :각 단어의 앞글자만 대문자로 변경
*/


SELECT LOWER('HELLOW WORLD JAVA'),UPPER('HELLO WORLD JAVA'),INITCAP('HELLO WORLD JAVA')
FROM DUAL;

/*
    CONCAT
    -CONCAT(문자열1, 문자열2)
    :전달된 문자열 두 개를 하나로 합쳐서 반환
*/

SELECT CONCAT('HELLO','WORLD')
FROM DUAL;

SELECT 'HELLO' || 'WORLD'
FROM DUAL;

--차이점
--CONCAT은 두 개의 문자열만 가능
SELECT CONCAT('HELLO','WORDL','!!!')
FROM DUAL;

SELECT CONCAT('HELLO',CONCAT('WORLD','!!!'))
FROM DUAL;

SELECT 'HELLO'||'WORLD'||'!!!'
FROM DUAL;

/*
    REPLACE 
    
    -REPLACE(문자열,찾을 문자,바꿀 문자)
    :문자열로부터 찾을 문자를 바꿀 문자로 변환하여 문자열반환
*/
SELECT REPLACE('서울시 영등포구 당산동','당산동','오류동')
FROM DUAL;

SELECT REPLACE(EMAIL,'kh.or.kr','NAVER.COM')
FROM EMPLOYEE;

-------------------------------------------
/*
    숫자와 관련된 함수
    
    ABS
    -ABS(절대값을 구할 숫자): 절대값을 구해주는 함수
    
    결과값 NUMBER타입
*/

SELECT ABS(-10)
FROM DUAL;

SELECT ABS(-55.21)
FROM DUAL;

/*
    MOD
    -MOD(숫자,나눌값): 두 수를 나눈 나머지값을 반환해주는 함수
*/
SELECT MOD(10,3)
FROM DUAL; --1

SELECT MOD(10,2)
FROM DUAL; --0

SELECT MOD(-25,3)
FROM DUAL; -- -1

SELECT MOD(10.5,3)
FROM DUAL; -- 1.5

/*
    ROUND
    -ROUND(반올림 하고자 하는 수, 반올림 위치): 반올림처리 함수
    반올림위치: 소수점 기준으로 아래 N번째에서 반올림 하겠다 
    (생략가능 생략시 기본값 0,소수점 첫 번째 자리에서 반올림)
  
*/
SELECT ROUND(123.456)
FROM DUAL;

SELECT ROUND(123.456,1)
FROM DUAL;

SELECT ROUND(123.456,2)
FROM DUAL;

SELECT ROUND(123.456,-1)
FROM DUAL; --음수 제시시 반대로 1의 자리

SELECT ROUND(123.456,-2)
FROM DUAL;

/*
    CEIL
    -CEIL(올림할 숫자): 소수점 아래의 수를 무조건 올림처리 해주는 함수
*/
SELECT CEIL(123.123)
FROM DUAL;

SELECT CEIL(555.089)
FROM DUAL;

/*
    FLOOR
    -FLOOR(버림할 숫자): 소수점 아래의 수를 무조건 버림처리 해주는 함수
*/
SELECT FLOOR(123.333)
FROM DUAL;

--근무일수 깔끔하게 조회하기
SELECT EMP_NAME, (FLOOR(SYSDATE-HIRE_DATE)) AS 근무일수
FROM EMPLOYEE;

/*
    TRUNC
    -TRUNC(버림처리할 숫자,위치): 위치가 지정가능한 버림처리 함수
    위치 생략 가능 기본값 0
*/

SELECT TRUNC(123.555)
FROM DUAL;

SELECT TRUNC(123.555,1)
FROM DUAL;

SELECT TRUNC(123.553,-1)
FROM DUAL;

---------------------------------------
/*
    <날짜 관련 함수>
    
    DATE 타입: 년도,월,일,시,분,초 둘 다 포함한 자료형
    
*/
--SYSDATE:현재 시스템 날자 변환
SELECT SYSDATE 
FROM DUAL;

--1.
--MONTHS_BETWEEN(DATE,DATE2): 두 날짜 사이의 개월 수 반환(결과값은 NUMBER)
--DATE2가 더 미래일 경우 음수가 나온다
--각 직원별 근무 일수, 근무 개월 수
SELECT EMP_NAME
    ,FLOOR(SYSDATE-HIRE_DATE)||'일' 근무일수
    ,CONCAT(FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)),'월') 근무개월수
FROM EMPLOYEE;

--DATE2가 더 미래일 경우 음수가 나오나 절대값 함수로 처리
SELECT EMP_NAME
    ,FLOOR(SYSDATE-HIRE_DATE)||'일' 근무일수
    ,CONCAT(FLOOR(ABS(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))),'월') 근무개월수
FROM EMPLOYEE;

--ADD_MONTHS(DATE,NUMBER) : 특정 날짜에 해당 숫자만큼 개월수를 더한 날짜 반환(결과값은 DATE타입)
--오늘 날짜로부터 5개월 이후 
SELECT ADD_MONTHS(SYSDATE,5)
FROM DUAL;

--전체 사원들의 1년 근속 일 (==입사일 기준 1주년)
SELECT EMP_NAME, HIRE_DATE,ADD_MONTHS(HIRE_DATE,12) AS "1주년"
FROM EMPLOYEE;

--NEXT_DAY(DATE,요일(문자/숫자)): 특정 날짜에서 가장 가까운 해당 요일을 찾아 그 날짜를 반환(결과값은 DATE 타입)
SELECT NEXT_DAY(SYSDATE,'월요일')
FROM DUAL;

SELECT NEXT_DAY(SYSDATE,'화')
FROM DUAL;
--1:일 2:월~ 7:토요일
SELECT NEXT_DAY(SYSDATE,7)
FROM DUAL;

--현재 세팅 언어가 KOREAN으로 되어 있기 때문에 에러
SELECT NEXT_DAY(SYSDATE,'SUNDAY')
FROM DUAL;

--언어변경
--DDL(데이터 정의 언어): CREATE, ALTER, DROP
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

SELECT NEXT_DAY(SYSDATE,'SUNDAY')
FROM DUAL;

--언어가 AMERICAN으로 변경되었기 때문에 오류
SELECT NEXT_DAY(SYSDATE,'토욜')
FROM DUAL;

--다시 한국어로 세팅
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

SELECT NEXT_DAY(SYSDATE,'토욜')
FROM DUAL;

--LAST DAY(DATE): 해당 특정 날짜 달의 마지막 날짜를 구해서 반환 (결과값은 DATE타입)
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--이름,입사일,입사한 날의 마지막 날짜 조회
SELECT EMP_NAME,HIRE_DATE,LAST_DAY(HIRE_DATE)
FROM DUAL;

/*
    EXTRACT: 년도 또는 월 또는 일 정보를 추출해서 반환(결과값은 NUMBER타입)
    -EXTRACT(YEAR FROM 날짜): 특정 날짜로부터 년도만 추출
    -EXTRACT(MONTH FROM 날짜): 특정 날짜로부터 월만 추출
    -EXTRACT(DAY FROM 날짜): 특정 날짜로부터 일만 추출
*/
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;
SELECT EXTRACT(MONTH FROM SYSDATE)
FROM DUAL;
SELECT EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

--사원명, 입사년도, 입사월, 입사일 조회 정렬 입사년도 기준 오름차순
SELECT EMP_NAME 사원명
    ,EXTRACT(YEAR FROM HIRE_DATE) 입사년도
    ,EXTRACT(MONTH FROM HIRE_DATE) 입사월
    ,EXTRACT(DAY FROM HIRE_DATE) 입사일
    
FROM EMPLOYEE
ORDER BY 입사년도,입사월,입사일;

------------------------------------------------

/*
    <형변환 함수>
    NUMBER/DATE -> CHARACTER
    
    -TO_CHAR(NUMBER/DATE,포맷)
    :숫자형 또는 날짜형 데이터를 문자형 타입으로 반환(포맷 맞춰서)
*/
--숫자를 문자열로
SELECT TO_CHAR(1234)
FROM DUAL; --1234 = '1234'

--자리수 포맷 지정: 넘어가면 알 수 없는 문자로 표현됨
SELECT TO_CHAR(1234,'00000')
FROM DUAL; --'01234': 빈칸을 0으로 채움

SELECT TO_CHAR(1234,'99999')
FROM DUAL; --'1234': 빈칸을 공백으로 채운다

SELECT TO_CHAR(12345,'FM99999')
FROM DUAL; --'1234': 빈칸 또는 0을 없애준다

SELECT TO_CHAR(1234,'L00000')
FROM DUAL; --L: LOCAL - 현재 설정된 나라의 화폐단위

SELECT TO_CHAR(1234,'L99999')
FROM DUAL;

SELECT TO_CHAR(1234,'L99,999')
FROM DUAL; --급여정보를 3자리마다 끊어서 표시도 가능

SELECT EMP_NAME,SALARY 기존표시, LTRIM(TO_CHAR(SALARY,'L99,999,999')) AS "변경한 급여 표시"
FROM EMPLOYEE;

--날짜를 문자열로
SELECT SYSDATE
FROM DUAL;

SELECT TO_CHAR(SYSDATE)
FROM DUAL; --'22/09/02'

--2022-09-02
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

--시 분 초: 오전(AM)/오후(PM)
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS')
FROM DUAL;--PM: 오전/오후

--24시간 형식: HH24
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS')
FROM DUAL;

--요일표시
SELECT TO_CHAR(SYSDATE, 'MON DY,YYYY')
FROM DUAL; -- DY: 요일을 알려주되 '요일'을 뺀 상태로 앞에 무슨 요일인지만 알려줌

SELECT TO_CHAR(SYSDATE, 'MON DAY,YYYY')
FROM DUAL; --DAY: 요일을 붙여서 금요일 토요일로 알려준다.

--년도로 표기할 수 있는 방법
SELECT TO_CHAR(SYSDATE, 'YYYY')
    ,TO_CHAR(SYSDATE,'RRRR')
    ,TO_CHAR(SYSDATE,'YY')
    ,TO_CHAR(SYSDATE,'RR')
    ,TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;
--YY와 RR의 차이점
--R이 뜻하는 단어 ROUND(반올림)
--YY: 앞자리에 무조건 20이 붙는다 -> (20)21
--RR: 50년 기준으로 작으면 20이 붙고 크면 19가 붙는다 -> (20)19 / (19)88

--월로써 쓸 수 있는 포맷
SELECT TO_CHAR(SYSDATE,'MM')
    ,TO_CHAR(SYSDATE,'MON')
    ,TO_CHAR(SYSDATE,'MONTH')
    ,TO_CHAR(SYSDATE,'RM')
FROM DUAL;

--일로 쓸 수 있는 포맷
SELECT TO_CHAR(SYSDATE,'D')
    ,TO_CHAR(SYSDATE,'DD')
    ,TO_CHAR(SYSDATE,'DDD')
FROM DUAL;
--D: 1주일 기준으로 일요일부터 며칠째인지 알려주는 포맷
--DD: 1달 기준으로 1일부터 며칠째인지 알려주는 포맷
--DDD: 1년 기준으로 1월1일부터 며칠째인지 알려주는 포맷

--요일로 쓸 수 있는 포맷
SELECT TO_CHAR(SYSDATE,'DY')
    ,TO_CHAR(SYSDATE,'DAY')
FROM DUAL; --요일이라는 단어가 포함인지 아닌지 차이

--2022년 09월 02일 (금) 포맷으로 적용시켜보자
SELECT TO_CHAR(SYSDATE, 'YYYY "년" MM"월" DD"일" (DY)')
FROM DUAL;

--사원명, 입사일(위에 포맷 사용)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY "년" MM"월" DD"일" (DY)') 입사일
FROM EMPLOYEE;
--2010년 이후에 입사한 사원들의 정보도 조회해보자.
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)') 입사일
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2010;
--WHERE HIRE_DATE >= '10/01/01'; -자동형변환이 되어 비교됨

/*
    NUMBER/CHARACTER -> DATE
    -TO_DATE(NUMBER/CHARACTER,포맷): 숫자형 또는 문자형 데이터를 날짜형으로 변환 (결과값은 DATE 타입)
*/
SELECT TO_DATE(20211231)
FROM DUAL; --기본포맷 YY/MM/DD로 변환이 된다.

SELECT TO_DATE('20211231')
FROM DUAL; --문자열또한 YY/MM/DD로 기본변환

SELECT TO_DATE(000101)
FROM DUAL; -- 000101==101:0으로 시작하는 숫자로 인지하여 에러 발생

SELECT TO_DATE('000101')
FROM DUAL; --0으로 시작하는 년도는 반드시 문자열표기로 해주어야 날짜형변환 가능

SELECT TO_DATE('20220101','YYYYMMDD')
FROM DUAL; --YY/MM/DD 형식으로 출력

SELECT TO_DATE('041030 182001', 'YYMMDD HH24:MI:SS')
FROM DUAL;

SELECT TO_DATE('990630','YYMMDD')
FROM DUAL;

SELECT TO_DATE('990630','RRMMDD')
FROM DUAL;

/*
    CHARACTER -> NUMBER
    
    -TO_NUMBER(CHAR,포맷): 문자형 데이터를 숫자형으로 변환 (결과값은 NUMBER타입)
*/
--자동형변환의 예시(문자열->숫자)
SELECT '123'+'123'
FROM DUAL; --246: 자동형변환 후 산술연산까지 가능하다.

SELECT '10,000,000'+'5,000'
FROM DUAL; --문자(,) 포함되어있기 때문에 자동형변환이 안된다.

SELECT TO_NUMBER('10,000,000','99,999,999')+TO_NUMBER('5,000','9,999')
FROM DUAL;

SELECT TO_NUMBER('0123')
FROM DUAL; --123

--문자열, 숫자, 날짜, TO_CHAR, TO_NUMBER,TO_DATE

-----연습문제-----
--1.JOB 테이블의 모든 정보 조회
SELECT *
FROM JOB;
--2.JOB 테이블의 직급 이름 조회
SELECT JOB_NAME
FROM JOB;
--3. DEPARTMENT 테이블의 모든 정보 조회
SELECT *
FROM DEPARTMENT;
--4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME 이름, EMAIL 이멜, PHONE 전번, HIRE_DATE 고용일
FROM EMPLOYEE;
--5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
SELECT EMP_NAME 이름, SALARY 월급, HIRE_DATE 고용일
FROM EMPLOYEE;
--6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT EMP_NAME 이름, (SALARY*12) 연봉, (SALARY+BONUS*SALARY)*12 "총수령액(보너스포함)"
,((SALARY+BONUS*SALARY)*12) - (SALARY*12*(3/100)) 실수령액
FROM EMPLOYEE;
--7. EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME 이름, SALARY 월급 , PHONE 전번, HIRE_DATE 고용일
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';
--8. EMPLOYEE테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
SELECT EMP_NAME 이름, SALARY 월급 ,((SALARY+BONUS*SALARY)*12) - (SALARY*12*(3/100)) 실수령액, HIRE_DATE 고용일
FROM EMPLOYEE
WHERE ((SALARY+BONUS*SALARY)*12) - (SALARY*12*(3/100)) >= 50000000;
--9. EMPLOYEE테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY>=4000000;
--10. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중 
--고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME 이름,DEPT_CODE 부서코드,HIRE_DATE 고용일
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D9','D5') AND HIRE_DATE < '02/01/01';
--11. EMPLOYEE테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE > '90/01/01' AND HIRE_DATE < '01/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
--12. EMPLOYEE테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
SELECT EMP_NAME 이름
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
--13. EMPLOYEE테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT EMP_NAME 이름, PHONE 전화번호
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--14. EMPLOYEE테이블에서 메일주소 '_'의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를  조회
--ESCAPE 문자: LIKE 연산시에 '_'나 '%'는 와일드 카드로써 작용하기 때문에 문자로 인식시키고 싶다면
--앞에 ESCAPE 문자를 넣어준다. ESCAPE 문자는 아무 특수문자나 상관없다.
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____$_%' ESCAPE '$' 
AND DEPT_CODE IN ('D9','D6')
AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
AND SALARY>=2700000;

--15. EMPLOYEE테이블에서 사원 명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
SELECT SUBSTR(EMP_NO,1,2),SUBSTR(EMP_NO,3,2),SUBSTR(EMP_NO,5,2)
FROM EMPLOYEE;

--16. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,7),14,'*')
FROM EMPLOYEE;

--17. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회  
--(단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
SELECT EMP_NAME ,ABS(FLOOR(HIRE_DATE -SYSDATE)) 근무일수1 , FLOOR(SYSDATE-HIRE_DATE) 근무일수2
FROM EMPLOYEE;

--18. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID,2)=1; --사번을 2로 나눈 나머지가 1인(홀수) 조건 조회

--19. EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
--WHERE (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE))>=20;
WHERE MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12 >=20;

--20. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '|9,000,000' 형식으로 표시)
SELECT EMP_NAME 사원명 ,LTRIM(TO_CHAR(SALARY,'L99,999,999')) AS 급여
FROM EMPLOYEE;

--21. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이(만) 조회
 --(단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며
 --나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)
 SELECT EMP_NAME "직원 명"
    , DEPT_CODE 부서코드
    , SUBSTR(EMP_NO,1,2)||'년' || SUBSTR(EMP_NO,3,2)||'월'||SUBSTR(EMP_NO,5,2)||'일' AS 생년원일
    , FLOOR(FLOOR(SYSDATE-TO_DATE(SUBSTR(EMP_NO,1,6)))/365) AS "나이(만)"
 FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO,3,2)<13 AND SUBSTR(EMP_NO,5,2)<32;


--NULL: 값이 존재하지 않음을 나타내는 값
--NULL 처리 함수들: NVL,NVL2,NULLIF

--NVL(컬럼명,해당 컬럼값이 NULL일 경우 반환할 값)
--해당 컬럼값이 존재할 경우(NULL이 아닐 경우) 기존의 컬럼값 반환
--해당 컬럼값이 존재X -> 내가 제시한 특정 값 반환

--사원명, 보너스 조회 보너스 없는 경우 0으로 조회
SELECT EMP_NAME,NVL(BONUS,0)
FROM EMPLOYEE;

--보너스 포함 연봉 조회
SELECT EMP_NAME,(SALARY*NVL(BONUS,0)+SALARY)*12 연봉
FROM EMPLOYEE;

--사원명 부서코드(없는 경우 없음으로 조회)
SELECT EMP_NAME,NVL(DEPT_CODE,'없음')
FROM EMPLOYEE;

--NVL2(컬럼명, 결과값1, 결과값2)
--해당 컬럼값이 NULL이 아니면 결과값1 반환
--해당 컬럼값이 NULL이면 결과값2 반환

--보너스가 있는 사원은 보너스 있음, 없는 사원은 보너스 없음으로 조회
SELECT EMP_NAME, NVL2(BONUS,'보너스 있음','보너스 없음') 보너스유무
FROM EMPLOYEE;

--사원명, 부서코드(부서 없으면 부서없음 있으면 부서있음)으로 조회
SELECT EMP_NAME, NVL2(DEPT_CODE,'부서있음','부서없음') 부서유무
FROM EMPLOYEE;

--NULLIF(비교대상1,비교대상2)
--두 값이 동일하면 NULL반환
--동일하지 않으면 비교대상1 반환

SELECT NULLIF('123','123')
FROM DUAL;

SELECT NULLIF('132','535')
FROM DUAL;

--선택함수
/*
    -DECODE(비교대상, 조건값1, 결과값2, 조건값2, 결과값2,....,결과값(DEFAULT))
    -자바에서 SWITCH문과 비슷하다
    
    *비교대상에는 컬럼명, 산술연산(결과는 숫자),함수(리턴값)이 들어갈 수 있다.
    
*/

--사번,사원명,주민번호,주민번호로 성별위치 추출(1이면 남자 2면 여자)표기
SELECT EMP_ID,EMP_NAME,EMP_NO
    ,DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') "성별"
FROM EMPLOYEE;

--직원들의 급여를 인상시켜서 조회
--직급코드가 J7인 사원은 급여를 10% 인상 
--직급코드가 J6인 사원은 급여를 15% 인상 
--직급코드가 J5인 사원은 급여를 20% 인상 
--사원명, 직급코드, 변경 전 급여, 변경 후 급여 조회
SELECT EMP_NAME,JOB_CODE,SALARY "변경 전 급여"
    ,DECODE(JOB_CODE
         ,'J7',SALARY*1.1
         ,'J6',SALARY*1.15
         ,'J5',SALARY*1.2
         ,SALARY) "변경 후 급여"
FROM EMPLOYEE;

/*
    CASE WHEN THEN 구문
    -DECODE 선택함수와 비교하면 DECODE는 자바의 SWITCH문처럼 조건검사시에 동등비교만 수행
    -CASE WHEN THEN 구문은 자바의 IF문처럼 조건식도 기술 가능
    [표현법]
    CASE WHEN 조건식1 THEN 결과값1
         WHEN 조건식2 THEN 결과값2
         WHEN 조건식3 THEN 결과값3
         ...
         ELSE 결과값
    END
    --------------------------------------
    자바에서의 IF-ELSE IF문과 유사하다
*/

--사번,사원명,주민번호,주민번호 성별추출 후 남자 여자 조회
SELECT EMP_ID
      ,EMP_NAME
      ,EMP_NO
      ,CASE WHEN SUBSTR(EMP_NO,8,1)=1 
            OR SUBSTR(EMP_NO,8,1)=3 THEN '남'
            WHEN SUBSTR(EMP_NO,8,1)=2 
            OR SUBSTR(EMP_NO,8,1)=4 THEN '여'
       END
FROM EMPLOYEE;

--직원들의 급여를 인상시켜서 조회
--직급코드가 J7인 사원은 급여를 10% 인상 
--직급코드가 J6인 사원은 급여를 15% 인상 
--직급코드가 J5인 사원은 급여를 20% 인상 
--그 외의 직급코드인 사원은 급여를 5% 인상
--사원명, 직급코드, 변경 전 급여, 변경 후 급여 조회
SELECT EMP_NAME
      ,JOB_CODE
      ,SALARY "변경 전 급여"
      ,CASE JOB_CODE
            WHEN 'J7' THEN SALARY*1.1
            WHEN 'J6' THEN SALARY*1.15
            WHEN 'J5' THEN SALARY*1.2
            ELSE SALARY*1.05
       END AS "변경 후 급여"
FROM EMPLOYEE;

--사원명,급여,급여등급(~350이하:초급,350초과~500이하:중급,500초과~:고급)
--CASE WHEN THEN 구문으로 작성
SELECT EMP_NAME
      ,SALARY
      ,CASE WHEN SALARY<=3500000 THEN ' 초급'
            WHEN 3500000<SALARY 
            AND SALARY<=5000000 THEN ' 중급'
            WHEN 5000000<SALARY THEN ' 고급'
       END AS 급여등급
FROM EMPLOYEE;

-------------------여기까지가 단일행 함수--------------------

--22. EMPLOYEE테이블에서 부서코드가 D5, D6, D9인 사원만 조회하되 
--D5면 총무부, D6면 기획부, D9면 영업부로 처리
--(단, 부서코드 오름차순으로 정렬)
ALTER TABLE EMPLOYEE MODIFY(DEPT_CODE VARCHAR(10));

SELECT EMP_NAME 이름
        ,CASE DEPT_CODE 
                WHEN 'D5' THEN '총무부'
                WHEN 'D6' THEN '기획부'
                WHEN 'D9' THEN '영업부'
           END AS 부서
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY DEPT_CODE ASC;

--23. EMPLOYEE테이블에서  사번이  201번인  사원명,  주민번호  앞자리,  주민번호  뒷자리,   
--      주민번호  앞자리와  뒷자리의  합  조회 
SELECT EMP_NAME
      ,SUBSTR(EMP_NO,1,6) AS "주민번호 앞자리"
      ,SUBSTR(EMP_NO,8,7) AS "주민번호 뒷자리"
      ,SUBSTR(EMP_NO,1,6)+SUBSTR(EMP_NO,8,7) AS "앞자리+뒷자리"
FROM EMPLOYEE
WHERE EMP_ID = '201';
--24. EMPLOYEE테이블에서  부서코드가  D5인  직원의  보너스  포함  연봉  합  조회
SELECT SUM((SALARY+SALARY*NVL(BONUS,0))*12)
        AS "D5직원의 연봉 합"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';







