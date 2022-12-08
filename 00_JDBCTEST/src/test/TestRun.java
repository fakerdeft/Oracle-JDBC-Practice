package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class TestRun {

	public static void main(String[] args) {
		
		/*
		 * JDBC용 객체
		 * -Connection: DB의 연결정보를 담고 있는 객체(IP주소, PORT번호, 계정명, 비번)
		 * -(Prepared)Statement: 해당 DB에 SQL문을 전달하고 실행한 후 결과를 받아내는 객체
		 * -ResultSet: 만일 실행한 SQL문이 SELECT문일 경우 조회된 결과들이 담겨있는 객체
		 * 
		 * JDBC 처리 순서
		 * 1)JDBC Driver 등록: 해당 DBMS가 제공하는 클래스 등록
		 * 2)Connection 생성: 접속하고자 하는 DB에 정보를 입력해서 DB에 접속하면서 생성
		 * 3)Statement 생성: Connection객체를 이용해서 생성
		 * 4)SQL문을 전달하면서 실행: Statement 객체를 이용해서 SQL문을 실행
		 * - SELECT문일 경우: excuteQuery() 메소드를 이용해서 실행
		 * - 나머지 DML문일 경우: excute Update() 메소드를 이용해서 실행
		 * 5)결과 받기
		 * 6_1 SELECT문)- SELECT문일 경우 ResultSet객체(조회된 데이터가 담겨있다)로 받음
		 * 6_2 SELECT문)- ResultSet객체에 담긴 데이터들을 하나씩 뽑아서 VO객체에 담기(ArrayList로 묶어 관리하기)
		 * 6_1 DML문)- 나머지 DML문일 경우 - int형 변수(처리된 행의 개수)로 받기
		 * 6_2 DML문)- 트랜잭션 처리(성공이면 COMMIT; / 실패면 ROLLBACK;)
		 * 7)사용완료한 JDBC용 객체 자원반납(close) 생성의 역순으로 반납한다.
		 */
		
		//INSERT문 -> 처리된 행의 수(int)
		
		int result = 0; //결과(처리행 수)를 받아 놓을 변수
		Connection conn=null; //DB에 연결정보를 보관할 객체
		Statement stmt = null;
		
		//내가 실행하고자 하는 sql문 문자열에 담아두기
		String sql = "INSERT INTO TEST VALUES(1,'김디비',SYSDATE)";
		
		try {
			//1)jdbc driver 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("jdbc driver 등록성공");
			
			//2)Connection 객체 생성: DB연결 정보들 알려주기(url,계정명,비번)-ip주소,port번호,xe(버전)
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
			
			//3)Statement 생성
			stmt = conn.createStatement();
			
			//4-5)SQL문을 전달하면서 결과값 돌려받기
//			result/*처리된 행의 수*/ = stmt.executeUpdate(sql);*insert(DML)문이라서 executeUpdate()로 전달*/
			result= stmt.executeUpdate(sql);
			
			//6)트랜잭션 처리
			if(result>0) {//성공했을 경우(처리된 행의 수가 1이라도 있을 경우)
				conn.commit();
			}
			else {//실패했을 경우
				conn.rollback();
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			//7)다 쓴 자원 반납하기 - 생성의 역순
			try {
				stmt.close();
				conn.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
}





























