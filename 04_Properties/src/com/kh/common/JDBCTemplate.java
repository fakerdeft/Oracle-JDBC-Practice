package com.kh.common;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCTemplate {
	
	//JDBC과정중 반복적으로 쓰이는 구문들을 메소드로 정의해놓고 사용.
	//재사용의 목적
	
	//이 클래스에 있는 모든 메소드들은 static키워드를 붙여서 생성할 것
	//싱클톤 패턴: 메모리 영역에 객체를 한번만 올려서 재사용하는 방법.
	
	//공통적으로 사용하게 될 부분
	//1.DB와 접속된 Connection 객체를 생성해서 반환시켜주는 메소드
	public static Connection getConnection() {
		/*
		 * 기존 방식: JDBC Driver 구문, 내가 접속할 DB의 url, 계정명, 비번
		 * 		   자바 소스코드 내에 명시적 작성->정적 코딩방식(하드코딩)
		 * -문제점: DBMS가 변경됐을 경우 또는 접속할 url,계정명,비번등이 변경됐을 경우
		 * 		  자바 코드를 수정해야함. 수정하려면 프로그램 재구동 해야함
		 * 		  유지보수가 불편하고 사용자에게 의도치 않은 점검을 제공함
		 * -해결방식: DB관련된 정보들을 별도로 관리하는 외부파일을 만들어서 관리한다.
		 * 			외부 파일로부터 key와 value의 형태로 읽어서 반영시킨다 -> 동적 코딩방식
		 */
		
		//연결정보들이 담겨있는 설정파일 properties를 읽기 위해 객체 생성
		Properties prop=new Properties();
		
		
		//Connection객체를 담을 객체 변수
		Connection conn=null;
		
		//드라이버 연결 후 커넥션 객체 생성
		try {
			//미리 만들어둔 driver정보가 담긴 파일 읽어오기
			prop.load(new FileInputStream("resource/driver.properties"));
			//prop객체로부터 driver키값을 가진 value값을 얻어올 것
			Class.forName(prop.getProperty("driver"));
			
			conn=DriverManager.getConnection(prop.getProperty("url")
											,prop.getProperty("username")
											,prop.getProperty("password"));
		
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("드라이브 오류!");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
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
				System.out.println("입력 성공!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//3_2)rollback메소드
	public static void rollback(Connection conn) {
		
		try {
			if(conn!=null&&conn.isClosed())
				conn.rollback();
				System.out.println("입력 실패!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}

































