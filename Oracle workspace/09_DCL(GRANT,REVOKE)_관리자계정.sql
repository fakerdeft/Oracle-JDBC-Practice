/*
    DCL(DATA CONTROL LANGUAGE)
    데이터 제어 언어
    
    계정에게 시스템권한 또는 객체 접근 권한 부여(GRANT) 하거나 회수(REVOKE)하는 언어
    
    -권한부여(GRANT)
    시스템 권한:특정 DB에 접근하는 권한, 객체들을 생성할 수 있는 권한.
    객체 접근 권한: 특정 객체들에 접근해서 조작할 수 있는 권한
    
    -시스템 권한
    GRANT 권한1,권한2,...TO 계정명;
    
    -시스템 권한 종류
    CREATE SESSION : 계정 접속
    CREATE TABLE : 테이블 생성
    CREATE VIEW : 뷰 생성
    CREATE SEQUENCE : 시퀀스 생성
    CREATE USER : 계정 생성
    ...
    
*/

DROP USER SAMPLE CASCADE;
--1.SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

--2.SAMPLE 계정에 접속권한 CREATE SESSION 부여
GRANT CREATE SESSION TO SAMPLE;

--3_1 SAMPLE 계정에 테이블 생성권한 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO SAMPLE;

--3_2 SAMPEL 계정에 테이블스페이스 할당해주기
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--QUOTA: 몫 , 할당하다
--2M: 2MEGA BYTE


--4.SAMPLE계정에 VIEW 생성 권한 부여하기 CREATE VIEW
GRANT CREATE VIEW TO SAMPLE;

/*
    -객체 권한
    특정 객체들을 조작할 수 있는 권한
    조작: SELECT, INSERT, UPDATE, DELETE =>DML
    
    [표현법]
    GRANT 권한종류 ON 특정객체 TO 계정명;
    
    권한 종류 | 특정 객체
    -------------------
    SELECT | TABLE,VIEW,SEQUENCE
    INSERT | TABLE,VIEW
    UPDATE | TABLE,VIEW
    DELETE | TABLE,VIEW
*/

--5.SAMPLE계정에 KH.EMPLOYEE테이블에 접근하여 조회할 수 있는 권한 부여
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

--6.SAMPLE계정에 KH.DEPARTMENT테이블에 접근하여 조회할 수 있는 권한을 부여
GRANT SELECT ON KH.DEPARTMENT TO SAMPLE;
--행을 추가하고자 한다면 조회 권한이 아닌 삽입 권한을 부여해야 한다
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

--최소한의 권한을 부여해서 사용하고자 할 때 CONNECT,RESOURCE만 부여
--GRANT CONNECT,RESOURCE TO 계정명;

/*
    <롤 ROLE>
    특정 권한들을 하나의 집합으로 모아 놓은 것
    
    CONNECT : CREATE SESSION(DB에 접속할 수 있는 권한)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, SELECT, INSER...(특정 객체들을 생성 및 조작할 수 있는 권한들)
*/
-----------------------------------------------------------

/*
    권한 회수 (REVOKE)
    권한을 회수할 때 사용하는 명령어
    
    [표현법]
    REVOKE 권한1,권한2,...FROM 계정명
*/

--7.SAMPLE계정에서 테이블을 생성하는 권한을 회수
REVOKE CREATE TABLE FROM SAMPLE;




















