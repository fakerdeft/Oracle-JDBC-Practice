--한 줄 주석

/*
    여러줄 주석
*/

--계정 생성
--일반 사용자 계정을 만들 수 있는 권한은 관리자 계정에 있다.
--사용자 계정 생성 방법
--[표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER KH IDENTIFIED BY KH;

--계정 생성만으로는 접속X
--생성된 사용자 계정에게 접속 권한 및 최소한의 권한을 줘야한다.
--최소한의 권한 내역: 접속, 데이터 관리
--[표현법] GRANT 권한1, 권한2, TO 계정명;
GRANT CONNECT,RESOURCE TO KH;

--관리자 계정: DB의 생성과 관리를 담당하는 계정이며, 모든 권한과 책임을 가지는 계정
--사용자 계정: DB에 대해 질의 갱신, 보고서 작성 등을 수행할 수 있는 계정, 
--           업무에 필요한 최소한의 권한만 가지는 것을 원칙으로 한다.

--ROLE: 권한묶음
--CONNECT: 사용자가 데이터베이스에 접속 가능하도록 하기 위한 CREATE SESSION 권한이 있는 ROLE
--RESOURCE: CREATE 구문을 통해 객체를 생성할 수 있는 권한과 INSERT, UPDATE
--          , DELETE 구문을 사용할 수 있는 권한을 모아놓은 ROLE

CREATE USER SCOTT IDENTIFIED BY TIGER;
GRANT CONNECT,RESOURCE TO SCOTT;

--춘대학 예제용 계정 생성 아디랑 비번 STUDY로 생성 및 기본 권한 주고 접속계정 생성 후
--춘대학계정으로 이름 짓고 접속 및 WORKBOOK 스크립트 실행하여 SELECT 예제 진행하기.

CREATE USER STUDY IDENTIFIED BY STUDY;
GRANT CONNECT,RESOURCE TO STUDY;

--DDL계정
CREATE USER DDL IDENTIFIED BY DD;
--최소한의 권한 부여
GRANT CONNECT,RESOURCE TO DDL;