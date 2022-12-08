/*
    <시퀀스 SEQUENCE>
    
    자동으로 번호를 발생시켜주는 역할을 하는 객체
    정수값을 자동으로 순차적으로 발생시켜준다 (연속된 숫자)
    EX)주차번호,회원번호,사번,게시글 번호 등등
    ->순차적으로 겹치지 않는 숫자를 필요로 할때 사용한다.
    
    1.시퀀스 객체 생성 구문
    
    [표현법]
    CREATE SEQUENCE 시퀀스명
    START WITH 시작숫자     -생략가능,처음 발생시킬 시작값 지정
    INCREMENT BY 증가값     -생략가능,한번 시퀀스 증가할때 몇씩 증가할 것인지 설정
    MAXVALUE 최대값         -생략가능,최대값 지정
    MINVALUE 최소값         -생략가능,최소값 지정
    CYCLE/NOCYCLE          -생략가능,값의 순환 여부를 결정
    CACHE 바이트크기/NOCACHE -생략가능, 캐시메모리 여부 지정 기본값 20BYTE
    
    *캐시메모리란?
    시퀀스로부터 미리 발생될 값들을 생성해서 저장해두는 공간으로 
    매번 호출할때마다 새롭게 번호를 생성하는것보다
    캐시메모리에 미리 생성된 값들을 가져다 쓰게 되면 훨씬 속도가 빠르다.
    단,접속이 끊기고 나서 재접속 후 기존에 생성되어있던 값들은 날라가고 없다.

*/
CREATE SEQUENCE SEQ_TEST;

--현재 접속한 계정이 소유하고 있는 시퀀스에 대한 정보 조회용 데이터 딕셔너리
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

/*
    2.시퀀스 사용 구문
    
    시퀀스명.CURRVAL : 현재 시퀀스의 값(마지막으로 발생된 NEXTVAL의 값을 의미한다.)
    시퀀스명.NEXTVAL : 현재 시퀀스의 값을 증가시키고 그 증가된 시퀀스의 값
    
    단 시퀀스 생성 후 첫 NEXTVAL은 START WITH로 지정된 시작값으로 발생한다.
     그렇기때문에 시퀀스 생성후 첫 CURRVAL은 수행할수없다.
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--시퀀스가 생성되고나서 NEXTVAL이 한번이라도 수행되어야 CURRVAL을 볼수있다.
--CURRVAL은 마지막에 성공적으로 수행된 NEXTVAL의 값을 보여주는 임시값이기 때문

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  --300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;  --300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  --305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  --310
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;  --310

--sequence %s.NEXTVAL %s %sVALUE and cannot be instantiated
--지정한 MAXVALUE 값을 초과했기때문에 오류
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;

--마지막으로 성공적으로 수행된 NEXTVAL 값
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

--시작값 15 , 증가값 3, 최대값 30인 SEQ_TESTQ 시퀀스를 생성해보고 3번 증가시켜보기

/*
    시퀀스 변경
    
    [표현법]
    ALTER SEQUENCE 시퀀스명
    INCREMENT BY 증가값
    MAXVALUE 최대값
    MINVALUE 최소값
    CYCLE/NOCYCLE
    CACHE 바이트크기/NOCACHE
    
    -START WITH는 변경 불가 : 변경하고 싶다면 시퀀스 삭제 후 재생성해야함
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --310
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --320

--SEQUENCE 삭제하기
DROP SEQUENCE SEQ_EMPNO;

--매번 새로운 사번이 발생되는 시퀀스 생성 (시퀀스명 : SEQ_EID) 
CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 400;
--300번시작 1씩 증가 최대값 400으로 생성하시오
--EMPLOYEE테이블에 사번에 시퀀스.NEXTVAL로 사원 추가 2명 해보기(사번을 제외한 나머지 데이터는 임의로 지정해서 넣으시오)
SELECT * FROM EMPLOYEE;

--INSERT
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL) VALUES(SEQ_EID.NEXTVAL,'김철수','999999-2222222','J9','S1');
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL) VALUES(SEQ_EID.NEXTVAL,'임수정','920929-112224','J7','S2');
SELECT * FROM EMPLOYEE;

--사원이라던지 게시글이라던지 추가 요청이 있을때
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES (EMP_ID.NEXTVAL,?,?,?,?,SYSDATE);










