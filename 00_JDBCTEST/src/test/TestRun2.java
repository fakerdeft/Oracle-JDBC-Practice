package test;

import java.sql.*;
import java.util.*;

public class TestRun2 {

	public static void main(String[] args) {
		//좀 전에 진행했던 insert문을 진행하는데 사용자에게 입력받아서 넣어보기
		//스캐너 활용 숫자랑 이름 입력받아 넣어보기
		Scanner sc=new Scanner(System.in);
		
		int result =0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("jdbc driver 등록성공");
			
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
			
			System.out.println("원하는 번호와 이름 입력");						
			System.out.println("번호:");
			int num= sc.nextInt();
			sc.nextLine();
			
			System.out.println("이름:");
			String name=sc.nextLine();
			
			String sql = "INSERT INTO TEST VALUES(?,?,SYSDATE)";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1,num);

			stmt.setString(2, name);
			
			result = stmt.executeUpdate();
			
			if(result>0) {
				conn.commit();
				System.out.println("커밋 성공");
			}
			else {
				conn.rollback();
				System.out.println("롤백");
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("드라이버 문제");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류");
		}finally {
			try {
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}//main메소드

}//class
















