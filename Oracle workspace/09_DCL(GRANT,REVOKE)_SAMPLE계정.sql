
--테이블 생성
CREATE TABLE TEST(
    TEST_ID NUMBER
);
--CREATE TABLE 권한 부여 전
--INSUFFICIENT PRIVILEGES 오류
--불충분한 권한: SAMPLE 계정에 테이블 생성 권한이 부여돼있지 않아서 오류

--CREATE TABLE 권한 부여 후
--NO PRIVILEGES ON TABLESPACE
--TABLESPACE: 테이블이 모여있는 공간
--TABLESPACE가 할당되지 않아서 오류가 발생한다.

--TABLESPACE까지 할당 받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);
--위에 테이블 생성 권한을 부여 받으면 DML구문 실행 가능
INSERT INTO TEST VALUES(1);
SELECT * FROM TEST;

--뷰 생성해보기
CREATE VIEW V_TEST
AS SELECT * FROM TEST;
--INSUFFICIENT PRIVILEGES 오류
--불충분한 권한: 뷰 객체를 생성할 수 있는 CREATE VIEW 권한을 부여받지 않았기 때문에 오류

--CREATE VIEW 권한을 부여 받은 뒤
CREATE VIEW V_TEST
AS SELECT * FROM TEST;
--뷰 생성 완료
SELECT * FROM V_TEST;

----------------------------------------------
--SAMPLE 계정에서 KH계정에 있는 테이블에 접근해보기
SELECT *
FROM KH.EMPLOYEE;
--TABLE OR VIEW DOES NOT EXIST
--KH 계정의 테이블에 조회할 수 있는 권한이 없기 때문에 오류가 발생한다.
--SELECT ON 권한 부여 후
SELECT *
FROM KH.EMPLOYEE;

SELECT *
FROM KH.DEPARTMENT;
--KH계정에 DEPARTMENT테이블에 접근할 수 있는 권한이 없기 때문.

--SAMPLE 계정에서 KH계정에 DEPARTMENT테이블에 접근해서 행 삽입
INSERT INTO KH.DEPARTMENT VALUES('D0','비비디바비디부','L2');
--TABLE OR VIEW DOES NOT EXIST
--접근권한이 없어서 오류

--INSERT ON 권한을 부여 받아야 행 삽입 가능
SELECT *
FROM KH.DEPARTMENT;
COMMIT;

--REVOKE로 CREATE TABLE 권한 회수 후 테이블 생성
CREATE TABLE TEST2(
    TEST_ID NUMBER
);
--INSUFFICIENT PRIVILEGES : 권한을 회수당했기 때문에 생성X 불충분한 권한
















