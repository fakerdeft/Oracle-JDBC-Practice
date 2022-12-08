package com.kh.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.kh.common.JDBCTemplate;
import com.kh.model.vo.Member;

public class MemberDao {
	
	public int insertMember(Connection conn,Member m) {
	
		int result = 0;//처리된 행 수
		PreparedStatement pstmt=null; 
		String sql="INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL,?,?,?,?,?,?,?,?,?,DEFAULT)";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, m.getUserId());
			pstmt.setString(2, m.getUserPw());
			pstmt.setString(3, m.getUserName());
			pstmt.setString(4, m.getGender());
			pstmt.setInt(5, m.getAge());
			pstmt.setString(6, m.getEmail());
			pstmt.setString(7, m.getPhone());
			pstmt.setString(8, m.getAddress());
			pstmt.setString(9, m.getHobby());
			
			result=pstmt.executeUpdate();
			
			//트랜잭션 처리도 서비스에서 할 것
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	public ArrayList<Member> selectAll(Connection conn) {//멤버 전체 조회 메소드

		//조회된 결과인 멤버 객체들을 담아서 가져갈 ArrayList 생성
		ArrayList<Member> list = new ArrayList<>();
		
		PreparedStatement pstm = null;
		ResultSet rs=null;
		
		try {
			String sql ="SELECT * FROM MEMBER";
			
			pstm=conn.prepareStatement(sql);
			
			//ResultSet은 한 행만 담기 때문에 조회된 모든 행을 담으려면 커서의 위치를 옮기면서 행을 담고
			//담은 행의 데이터를 VO객체에 옮겨 담아 list에 담아서 가져간다.
			rs=pstm.executeQuery();
			
			while(rs.next()) {
				Member m = new Member();

				m.setUserNo(rs.getInt("학번"));
				m.setUserId(rs.getString("아이디"));
				m.setUserPw(rs.getString("비밀번호"));
				m.setUserName(rs.getString("이름"));
				m.setGender(rs.getString("성별"));
				m.setAge(rs.getInt("나이"));
				m.setEmail(rs.getString("이메일"));
				m.setPhone(rs.getString("핸드폰"));
				m.setAddress(rs.getString("주소"));
				m.setHobby(rs.getString("취미"));
				m.setEnrollDate(rs.getDate("등록일"));
				
				//리스트에 데이터를 담아놓은  Member객체를 담아주기
				list.add(m);
				
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstm);
		}//finally
		
		return list;
	}//public void selectAll
	
	public Member selectById(Connection conn,String userid) {//회원 아이디로 검색 조회 메소드

		PreparedStatement pstm = null;
		ResultSet rs=null;

		Member m = new Member();
		
		try {
			String sql ="SELECT * FROM MEMBER WHERE 아이디= ?";
			
			pstm=conn.prepareStatement(sql);
			
			pstm.setString(1, userid);
			
			rs=pstm.executeQuery();
			
			while(rs.next()) {
				m.setUserNo(rs.getInt("학번"));
				m.setUserId(rs.getString("아이디"));
				m.setUserPw(rs.getString("비밀번호"));
				m.setUserName(rs.getString("이름"));
				m.setGender(rs.getString("성별"));
				m.setAge(rs.getInt("나이"));
				m.setEmail(rs.getString("이메일"));
				m.setPhone(rs.getString("핸드폰"));
				m.setAddress(rs.getString("주소"));
				m.setHobby(rs.getString("취미"));
				m.setEnrollDate(rs.getDate("등록일"));
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstm);
		}//finally
		
		return m;
	}
	
	public ArrayList<Member> selectByName(Connection conn,String username) {//회원 이름으로 검색 조회 메소드
		PreparedStatement pstm = null;
		ResultSet rs=null;
		
		ArrayList<Member> list = new ArrayList<>();
		
		try {
			String sql ="SELECT * FROM MEMBER WHERE 이름 LIKE ?";
			
			pstm=conn.prepareStatement(sql);
			
			pstm.setString(1, "%"+username+"%");
			
			rs=pstm.executeQuery();
			
			while(rs.next()) {
				Member m = new Member();
				m.setUserNo(rs.getInt("학번"));
				m.setUserId(rs.getString("아이디"));
				m.setUserPw(rs.getString("비밀번호"));
				m.setUserName(rs.getString("이름"));
				m.setGender(rs.getString("성별"));
				m.setAge(rs.getInt("나이"));
				m.setEmail(rs.getString("이메일"));
				m.setPhone(rs.getString("핸드폰"));
				m.setAddress(rs.getString("주소"));
				m.setHobby(rs.getString("취미"));
				m.setEnrollDate(rs.getDate("등록일"));
				
				list.add(m);
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstm);
		}//finally
		
		return list;
	}

	public int updateMemberName(Connection conn,String userId,String userName) {//회원 이름 변경 메소드 
							
			int result=0; 
			
			PreparedStatement pstm=null; 
				
			try {
				String sql="UPDATE MEMBER SET 이름 = ? WHERE 아이디 = ?";
					
				pstm=conn.prepareStatement(sql);
					
				pstm.setString(1, userName);
				pstm.setString(2, userId);
					
				result = pstm.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("DB 오류!");
			}finally {
				JDBCTemplate.close(pstm);
			}//finally
				
			//결과반환
			return result;
	}//public int updateMemberId

	public int updateMemberPw(Connection conn,String userId, String userPw) {//회원 비밀번호 변경 메소드
		
		int result=0; 
		PreparedStatement pstm=null; 
			
		try {
			String sql="UPDATE MEMBER SET 비밀번호 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, userPw);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
				
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(pstm);
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberPw

	public int updateMemberGender(Connection conn,String userId, String gender) {//회원 성별 변경 메소드
						
		int result=0; 
		PreparedStatement pstm=null; 
			
		try {
			String sql="UPDATE MEMBER SET 성별 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, gender);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(pstm);
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberGender

	public int updateMemberAge(Connection conn,String userId, int age) {//회원 나이 변경 메소드
						
		int result=0; 
		PreparedStatement pstm=null; 
			
		try {
			String sql="UPDATE MEMBER SET 나이= ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setInt(1, age);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(pstm);
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberAge

	public int updateMemberEmail(Connection conn,String userId, String email) {//회원 이메일 변경 메소드

		int result=0; 
		PreparedStatement pstm=null; 
			
		try {
			String sql="UPDATE MEMBER SET 이메일 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, email);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(pstm);
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberEmail

	public int updateMemberPhone(Connection conn,String userId, String phone) {//회원 핸드폰번호 변경 메소드

		int result=0; 
		PreparedStatement pstm=null; 
			
		try {
			String sql="UPDATE MEMBER SET 핸드폰 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, phone);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(pstm);
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberPhone

	public int updateMemberAddress(Connection conn,String userId, String address) {//회원 주소 변경 메소드
		
		int result=0; 
		PreparedStatement pstm=null; 
			
		try {
			String sql="UPDATE MEMBER SET 주소 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, address);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(pstm);
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberAddress

	public int updateMemberHobby(Connection conn,String userId, String hobby) {//회원 취미 변경 메소드
				
		int result=0; 
		PreparedStatement pstm=null; 
			
		try {
			String sql="UPDATE MEMBER SET 취미 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, hobby);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(pstm);
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberHobby

	public int deleteMember(Connection conn,String mid) {//특정 회원 탈퇴 메소드
			
		int result=0; 
		PreparedStatement pstm=null; 
			
		try {
			String sql="DELETE FROM MEMBER WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, mid);
				
			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(pstm);
		}//finally
			
		//결과반환
		return result;
		
	}//public int deleteMember

	public int deleteAllMember(Connection conn) {//전체 회원 탈퇴 메소드
			
		int result=0;
		PreparedStatement pstm=null; 
			
		try {
			String sql="DELETE FROM MEMBER";
				
			pstm=conn.prepareStatement(sql);

			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 오류!");
		}finally {
			JDBCTemplate.close(pstm);
		}//finally
			
		//결과반환
		return result;
		
	}//public int deleteAllMember
	
}















