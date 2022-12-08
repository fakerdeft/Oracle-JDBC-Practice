package test;

import java.sql.*;

public class SelectTest {

	public static void main(String[] args) {
		
		//Test테이블에 있는 정보를 조회해보자
		//Select문 -> ResultSet(조회된 결과가 객체에 담겨온다)
		
		//필요한 변수
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql ="SELECT *  FROM TEST";
		//드라이버 등록
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//2)Connection 객체
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
			//3)Statement 객체
			stmt = conn.createStatement();
			//4)sql문 담아 보내기 - 조회결과값 받아올 객체 ResultSet
			rs = stmt.executeQuery(sql);
			
			//5)ResultSet에 담겨있는 데이터 꺼내오기
			while(rs.next()) {
				int tno =rs.getInt("TNO");
				String tName=rs.getString("TNAME");
				Date tdate =rs.getDate("TDATE");
				
				System.out.println(tno+","+tName+","+tdate);
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}//main메소드

}//class































