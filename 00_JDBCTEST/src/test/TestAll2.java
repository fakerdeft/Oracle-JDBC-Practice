package test;

import java.util.*;
import java.sql.*;
import java.sql.Date;

public class TestAll2 {

	public static void main(String[] args) {
		/*
		 * DB에 PHONE 테이블 생성
		 * PNO 시퀀스 생성해서 넣어보세요 SEQ_PHONE
		 * PNAME 데이터 타입 원하시는 대로 문자열 담을 수 있게
		 * PRICE 데이터 타입 원하시는 대로 숫자 담을 수 있게
		 * PDATE 생산시점 담을 수 있게
		 * 
		 * 추가,수정,삭제,전체삭제,조회(조건/전체),종료
		 * 
		 * */
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
		
		int pno =0;
		int PNO =0;
		String pname="";
		String PNAME ="";
		int price=0;
		int PRICE = 0;
		Date pdate=null;
		Date PDATE = null;
		int n1=0;
		String sql="";
		
		int result =0;
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Scanner sc = new Scanner (System.in);
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			while(n1!=10) {
				
				System.out.println("=====메뉴=====");
				System.out.println("1.데이터 입력");
				System.out.println("2.데이터 수정");
				System.out.println("3.데이터 삭제");
				System.out.println("4.원하는 데이터 조회");
				System.out.println("5.데이터 전체 조회");
				System.out.println("9.프로그램 종료");
				System.out.println("메뉴 번호 입력:");
				int num=sc.nextInt();
				sc.nextLine();
				
				switch(num) {
				
				case 1://데이터 입력
					sql="INSERT INTO PHONE VALUES (SEQ_PHONE.NEXTVAL,?,?,DEFAULT)";
					
					System.out.println("기종, 가격을 입력하세요");
					System.out.println("기종:");
					pname = sc.nextLine();
					System.out.println("가격:");
					price =sc.nextInt();
					sc.nextLine();
					
					pstm= conn.prepareStatement(sql);
					
					pstm.setString(1, pname);
					pstm.setInt(2, price);
					
					result = pstm.executeUpdate();
					if(result > 0) {
						conn.commit();
						System.out.println("입력 성공!");
					}
					else {
						conn.rollback();
						System.out.println("입력 실패!");
					}
					break;
				case 2://데이터 수정
					System.out.println("1.기종 명 수정");
					System.out.println("2.가격 수정");
					System.out.println("번호 입력:");
					int n=sc.nextInt();
					sc.nextLine();
					
					if(n==1) {//기종 명 수정
						sql="UPDATE PHONE SET 기종 = ? WHERE 번호 = ?";
						System.out.println("변경할 폰의 번호:");
						pno =sc.nextInt();
						sc.nextLine();
						System.out.println("새 기종:");
						pname = sc.nextLine();
						
						pstm= conn.prepareStatement(sql);
						
						pstm.setString(1, pname);
						pstm.setInt(2, pno);
						
						result = pstm.executeUpdate();
						if(result > 0) {
							conn.commit();
							System.out.println("수정 성공!");
						}
						else {
							conn.rollback();
							System.out.println("수정 실패!");
						}
					}
					else if(n==2) {//가격 수정
						sql="UPDATE PHONE SET 가격 = ? WHERE 번호 = ?";
						System.out.println("변경할 폰의 번호:");
						pno =sc.nextInt();
						sc.nextLine();
						System.out.println("새 가격:");
						price = sc.nextInt();
						sc.nextLine();
						
						pstm= conn.prepareStatement(sql);
						
						pstm.setInt(1, price);
						pstm.setInt(2, pno);
						
						result = pstm.executeUpdate();
						if(result > 0) {
							conn.commit();
							System.out.println("수정 성공!");
						}
						else {
							conn.rollback();
							System.out.println("수정 실패!");
						}
					}
					else {
						System.out.println("메뉴로 돌아갑니다.");
					}
					
					break;
				case 3://데이터 삭제
					System.out.println("1.원하는 기종 삭제");
					System.out.println("2.전체 삭제");
					System.out.println("번호 입력:");
					int n2 = sc.nextInt();
					sc.nextLine();
					
					if(n2==1) {
						sql="DELETE FROM PHONE WHERE 기종 = ?";
						System.out.println("원하는 기종을 입력하세요:");
						pname=sc.nextLine();
						
							pstm=conn.prepareStatement(sql);
							
							pstm.setString(1, pname);
							
							result=pstm.executeUpdate();
							
							if(result > 0) {
								conn.commit();
								System.out.println("삭제 성공!");
							}
							else {
								conn.rollback();
								System.out.println("삭제 실패!");
							}
						
					}
					else if(n2==2) {
						sql="DELETE FROM PHONE";
						
						pstm=conn.prepareStatement(sql);
						
						result = pstm.executeUpdate();
						if(result > 0) {
							conn.commit();
							System.out.println("삭제 성공!");
							
						}
						else {
							conn.rollback();
							System.out.println("삭제 실패!");
						}
					}
					else {
						System.out.println("메뉴로 돌아갑니다.");
					}
					break;
				case 4://원하는 데이터 조회
					sql="SELECT * FROM PHONE WHERE 기종 =?";
					System.out.println("원하는 기종을 입력하세요:");
					pname=sc.nextLine();
					
					pstm=conn.prepareStatement(sql);
					
					pstm.setString(1, pname);
					
					rs = pstm.executeQuery();
					
					if(rs != null) {
						while(rs.next()) {
							PNO =rs.getInt("번호");
							PNAME=rs.getString("기종");
							PRICE=rs.getInt("가격");
							PDATE =rs.getDate("생산시점");
							
							System.out.println("번호: "+PNO+"/기종: "+PNAME+"/가격: "+PRICE+"원/생산시점: "+PDATE);
						}
					}
					else {
						System.out.println();
					}
					
					break;
				case 5://데이터 전체 조회
					sql="SELECT * FROM PHONE";
				
					pstm= conn.prepareStatement(sql);
					
					rs = pstm.executeQuery();
					
					if(rs!=null) {
						while(rs.next()) {
							PNO =rs.getInt("번호");
							PNAME=rs.getString("기종");
							PRICE=rs.getInt("가격");
							PDATE =rs.getDate("생산시점");
							
							System.out.println("번호: "+PNO+"/기종: "+PNAME+"/가격: "+PRICE+"원/생산시점: "+PDATE);
						}
					}
					else {
						System.out.println("데이터가 없습니다!");
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
			System.out.println("드라이버 오류!");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			if(pstm!=null)
				try {
					pstm.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		
	}//main

}//class



































