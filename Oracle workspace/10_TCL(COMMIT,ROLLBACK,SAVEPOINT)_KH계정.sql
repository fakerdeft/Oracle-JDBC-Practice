/*
    TCL(TRANSACTION CONTROL LANGUAGE)
    트랜잭션을 제어하는 언어
    
    트랜잭션(TRANSACTION)
    -DB의 논리적 작업 단위
    -DB의 변경사항(DML)들을 하나의 트랜잭션으로 묶어서 처리
    ->COMMIT(확정) 하기 전까지의 변경사항들을 하나의 트랜잭션으로 담겠다.
    -트랜잭션 대상 SQL: INSERT,UPDATE,DELETE(DML)
    
    트랜잭션 종류
    -COMMIT; 진행: 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠다는것 의미
                실제 DB에 반영시킨 후 트랜잭션은 비워진다->확정의 개념
                
    -ROLLBACK; :하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영X
                트랜잭션에 담겨있는 변경사항들 전부 제거 후 마지막 COMMIT 시점으로 돌아감
    
    -SAVEPOINT 포인트명; : 현재 이 시점에 임시저장점을 정의해두는것
    -ROLLBACK TO 포인트명; : 전체 변경사항들을 삭제(마지막 커밋시점으로 돌아가는것) 하는것이 아니라
                            해당 포인트 지점까지의 트랜잭션만 롤백    
*/

SELECT *
FROM EMP_01;

--사번이 998인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 998;

--사번 999인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID=999;

ROLLBACK; --25명

---------------------------------------------------------------

--사번이 200번 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID=200;

--사번 800번 이름 김철수 부서이름 철수부 사원 추가
INSERT INTO EMP_01 VALUES(800,'김철수','철수부');

SELECT * FROM EMP_01; --25명

COMMIT;

SELECT * FROM EMP_01; --25명

ROLLBACK;

-----------------------------------------------
--EMP_01 테이블에서 사번이 217,216,214 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID IN ('217','216','214');

SELECT * FROM EMP_01;

--3개 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT SP1;

--EMP_01 테이블에 사번 801 이름 김영희 부서 인사부 추가
INSERT INTO EMP_01 VALUES(801,'김영희','인사부');

SELECT * FROM EMP_01; --23명

--EMP_01 테이블에서 사번 800,998 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID IN (800,998);

SELECT * FROM EMP_01; --21명

ROLLBACK TO SP1;

SELECT* FROM EMP_01;

ROLLBACK;

SELECT * FROM EMP_01;

COMMIT;

SELECT * FROM EMP_01;

--사번 800,998 삭제
DELETE FROM EMP_01
WHERE EMP_ID IN (800,998);
--이름이 김추석 삭제 
DELETE FROM EMP_01
WHERE EMP_NAME='김추석';
SELECT * FROM EMP_01;
--SELECT 로 현재 인원 조회 후 주석처
SELECT * FROM EMP_01;
--TID NUMBER 컬럼 하나를 가지는 테이블 생성
CREATE TABLE TEST(
    TID NUMBER
);
--SELECT로 다시 인원 조회 후 ROLLBACK 해보기
SELECT * FROM EMP_01;

ROLLBACK;

SELECT * FROM EMP_01;

/*
    주의)
    DDL 구문(CREATE,ALTER,DROP)을 실행하는 순간
    기존 트랜잭션에 있던 모든 변경사항들을 무조건 실제 DB에 반영(COMMIT)시킨 후 DDL 실행
    --DDL 수행 전에 변경사항이 있었다면 정확히 작업을 마친 후 (COMMIT OR ROLLBACK) DDL구문 진행해야함
*/


                        


