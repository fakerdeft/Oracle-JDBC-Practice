package com.kh.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCTemplate {
	
	//JDBC과정중 반복적으로 쓰이는 구문들을 메소드로 정의해놓고 사용.
	//재사용의 목적
	
	//이 클래스에 있는 모든 메소드들은 static키워드를 붙여서 생성할 것
	//싱글톤 패턴: 메모리 영역에 객체를 한번만 올려서 재사용하는 방법.
	
	//공통적으로 사용하게 될 부분
	//1.DB와 접속된 Connection 객체를 생성해서 반환시켜주는 메소드
	public static Connection getConnection() {
		
		//Connection객체를 담을 객체 변수
		Connection conn=null;
		
		//드라이버 연결 후 커넥션 객체 생성
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("드라이브 오류!");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}
		
		return conn;
	}
	
	//2. 전달받은 JDBC용 객체를 반납시켜주는 메소드 (각 객체별로 생성)
	//2_1) Connection 객체 반납 메소드
	public static void close(Connection conn) {
		try {
			//만약 conn이 null이면 nullpointerException 발생할 수 있다. 조건처리 해야함
			if(conn!=null && !conn.isClosed()) {//커넥션객체가 null이 아니고 닫혀있지 않다면
				conn.close(); //커넥션객체 닫아서 반납해줘
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//2_2) Statement 객체 반납 메소드(오버로딩 이용)
	public static void close(Statement stmt) {
		try {
			//만약 statement이 null이면 nullpointerException 발생할 수 있다. 조건처리 해야함
			if(stmt!=null && !stmt.isClosed()) {//스테잍먼트객체가 null이 아니고 닫혀있지 않다면
				stmt.close(); //스테이트먼트객체 닫아서 반납해줘
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//2_3) ResultSet 객체 반납 메소드(오버로딩 이용)
	public static void close(ResultSet rs) {
		try {
			//만약 conn이 null이면 nullpointerException 발생할 수 있다. 조건처리 해야함
			if(rs!=null && !rs.isClosed()) {//리설트셋객체가 null이 아니고 닫혀있지 않다면
				rs.close(); //리설트셋객체 닫아서 반납해줘
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//3)트랜잭션 처리 메소드
	//3_1)commit메소드
	public static void commit(Connection conn) {
		
		try {
			if(conn!=null&&conn.isClosed())
				conn.commit();
				System.out.println("커밋 성공!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//3_2)rollback메소드
	public static void rollback(Connection conn) {
		
		try {
			if(conn!=null&&conn.isClosed())
				conn.rollback();
				System.out.println("롤백!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}

































