package test;

import java.util.*;
import java.sql.*;
import java.sql.Date;

public class TestAll {

	public static void main(String[] args) {
		
		//DB에 테이블 STUDENT테이블을 만들고 컬럼은 SNO-NUMBER,
		//SNAME-VARCHAR2(30),
		//SDATE - DATE(SYSDATE)로 생성하고
		//데이터 3개 INSERT 해보고 DELETE로 1개 UPDATE로 1개 변경해보시오
		//마지막은 조회까지 진행하세요.
		
		//SWITCH문을 사용해서 사용자정보 입력,수정,삭제,조회 - 스캐너로 번호와 이름을 입력받아 넣기
		Scanner sc=new Scanner(System.in);
		int result=0;
		int n1=0;
		int sno=0;
		String sname="";
		String sql="";
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet result2=null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
			
			while(n1!=10) {
				System.out.println("=====메뉴=====");
				System.out.println("1.데이터 입력");
				System.out.println("2.데이터 수정");
				System.out.println("3.데이터 삭제");
				System.out.println("4.데이터 전체 조회");
				System.out.println("9.프로그램 종료");
				System.out.println("메뉴 번호 입력:");
				int num=sc.nextInt();
				sc.nextLine();
				
				switch(num) {
				
				case 1://데이터 입력
					sql="INSERT INTO STUDENT VALUES(?,?,SYSDATE)";
					
					System.out.println("학번,이름 입력하세요");
					System.out.println("학번 입력:");
					sno=sc.nextInt();
					sc.nextLine();
					
					System.out.println("이름 입력:");
					sname = sc.nextLine();
					
					pstm = conn.prepareStatement(sql);
					
					pstm.setInt(1, sno);
					pstm.setString(2, sname);
					
					result = pstm.executeUpdate();
					
					if(result>0) {
						conn.commit();
						System.out.println("커밋 성공");
					}
					else {
						conn.rollback();
						System.out.println("롤백");
					}
					break;
				case 2://데이터 수정
					sql="UPDATE STUDENT SET 이름 = ? WHERE 학번 = ?";
					System.out.println("바꾸고 싶은 학생의 학번:");
					sno=sc.nextInt();
					sc.nextLine();
					
					System.out.println("바꿀 이름:");
					sname = sc.nextLine();
					
					pstm = conn.prepareStatement(sql);
					
					pstm.setString(1, sname);
					pstm.setInt(2, sno);
					
					result = pstm.executeUpdate();
					
					if(result>0) {
						conn.commit();
						System.out.println("수정성공");
					}
					else {
						conn.rollback();
						System.out.println("롤백");
					}
					break;
				case 3://데이터 삭제
					sql="DELETE FROM STUDENT WHERE 이름 = ?";
					System.out.println("삭제할  학생의 학번:");
					sno=sc.nextInt();
					sc.nextLine();
					
					pstm = conn.prepareStatement(sql);
					
					pstm.setInt(1, sno);
					
					result = pstm.executeUpdate();
					
					if(result>0) {
						conn.commit();
						System.out.println("수정성공");
					}
					else {
						conn.rollback();
						System.out.println("롤백");
					}
					break;
				case 4://데이터 전체 조회
					sql="SELECT * FROM STUDENT";
					
					pstm= conn.prepareStatement(sql);
					
					result2 = pstm.executeQuery(sql);
					
					while(result2.next()) {
						int SNO =result2.getInt("학번");
						String SNAME=result2.getString("이름");
						Date SDATE =result2.getDate("등록날짜");
						
						System.out.println("학번: "+SNO+"/이름: "+SNAME+"/등록날짜: "+SDATE);
					}
					break;
				case 9://프로그램 종료
					System.out.println("프로그램을 종료합니다.");
					n1=10;
				}//switch
				System.out.println();
			}//while

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("드라이버 오류");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류 ");
		}finally {
			if(pstm != null)
				try {
					pstm.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		
	}//main

}//class












