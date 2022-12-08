package com.kh.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.kh.model.vo.Member;
//DAO(Data Access Object)
//Controller한테 요청받은 데이터 작업 해주는 클래스
//DB에 직접적으로 접근하여 해당 SQL 구문을 실행 후 결과를 받는 작업을 한다.
public class MemberDao {
	/*
	 * JDBC용 객체
	 * -Connection: DB의 연결정보를 담고 있는 객체(IP주소, PORT번호, 계정명, 비번)
	 * -(Prepared)Statement: 해당 DB에 SQL문을 전달하고 실행한 후 결과를 받아내는 객체
	 * -ResultSet: 만일 실행한 SQL문이 SELECT문일 경우 조회된 결과들이 담겨있는 객체
	 * 
	 * PreparedStatement 특징:
	 * -SQL문을 바로 실행x 잠시 보관
	 * -미완성된 SQL문을 먼저 전달하고 실행하기 전에 완성 형태로 만든 후 실행
	 * -미완성된 SQL문 만들기 (사용자가 입력한 값들이 들어갈 수 있는 공간을 ?(위치홀더)로 확보)
	 * -각 위치홀더에 맞는 값들을 세팅한다.
	 * 
	 * Statmenet(부모) 와 PreparedStatement(자식) 관계이다.
	 * 차이점
	 * 1)Statement는 완성된 SQL문, PreparedStatement는 미완성 SQL문
	 * 
	 * 2)Statement 객체 생성 시: stmt=conn.createStatement();
	 * 	 PreparedStatement 객체 생성 시: pstmt=conn.prepareStatement(SQL);
	 * 
	 * 3)Statement로 SQL문 실행 시
	 * 	-stmt=stmt.executeXXXX(SQL);
	 * 	PreparedStatement로 SQL문 실행 시
	 * 	-pstmt.setString(?위치,세팅값);
	 * 	-pstmt.setInt(?위치,세팅값);
	 * 	결과 받기=pstmt.executeXXXX;
	 */
	
	//INSERT문을 실행시켜 멤버를 추가할 메소드
	public int insertMember(Member m) {//처리된 행 수를 반환해줘야 하기 때문에 반환타입 int
		
		//준비물
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
		
		//Connection,Statement,ResultSet -> finally구문에서 자원 반납을 하기 위해 미리 선언해두는 것
		int result=0; //처리된 행 수를 받아 줄 변수
		Connection conn=null; //접속 DB정보를 담는 객체변수
		PreparedStatement pstm=null; //접속한 DB에 SQL문을 전달하고 결과를 돌려받을 객체변수
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL,"
					+ "?,?,?,?,?,?,?,?,?,SYSDATE)";
			
			pstm=conn.prepareStatement(sql);
			
			pstm.setString(1, m.getUserId());
			pstm.setString(2, m.getUserPw());
			pstm.setString(3, m.getUserName());
			pstm.setString(4, m.getGender());
			pstm.setInt(5, m.getAge());
			pstm.setString(6, m.getEmail());
			pstm.setString(7, m.getPhone());
			pstm.setString(8, m.getAddress());
			pstm.setString(9, m.getHobby());
			
			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("입력 성공!");
			}
			else {
				conn.rollback();
				System.out.println("입력 실패!");
			}
			
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
		}//finally
		
		//결과반환
		return result;
	}//public int insertMember
	
	public ArrayList<Member> selectAll() {//멤버 전체 조회 메소드
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
		
		//조회된 결과인 멤버 객체들을 담아서 가져갈 ArrayList 생성
		ArrayList<Member> list = new ArrayList<>();
		
		ResultSet rs=null;
		Connection conn =null;
		PreparedStatement pstm = null;
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql ="SELECT * FROM MEMBER";
			
			pstm=conn.prepareStatement(sql);
			
			//ResultSet은 한 행만 담기 때문에 조회된 모든 행을 담으려면 커서의 위치를 옮기면서 행을 담고
			//담은 행의 데이터를 VO객체에 옮겨 담아 list에 담아서 가져간다.
			rs=pstm.executeQuery();
			
			while(rs.next()) {
				//커서의 위치를 옮기면서 해당 위치에 있는 행의 데이터를 뽑아 Member객체에 담는다.
				Member m = new Member();
				//커서의 위치가 옮겨져 rs에 조회된 행의 데이터가 담겨있고
				//그 rs에서 어떠한 컬럼 데이터를 뽑을 것인지 제시
				//제시한 컬럼 데이터를 Member객체의 필드에 대입시켜 Member객체에 담아준다.
				//Member객체에 담은 데이터를 list에 하나씩 담아서 최종적으로 list반환
				
				//rs으로부터 어떤 컬럼에 해당하는 값을 뽑을 것인지?
				//컬럼명(대소문자 가리지 않지만 대문자로 표기),컬럼 순번
				//- 권장사항은 대문자로 쓰면서 컬럼명을 넣어서 작성하는 방법
				//rs.getInt(컬럼명 또는 순번); : int 자료형
				//rs.getString(컬럼명 또는 순번); : String 자료형
				//rs.getDate(컬럼명 또는 순번); : Date 자료형
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
		}//finally
		
		return list;
	}//public void selectAll
	
	public Member selectById(String userid) {//회원 아이디로 검색 조회 메소드
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
		
		ResultSet rs=null;
		Connection conn =null;
		PreparedStatement pstm = null;

		Member m = new Member();
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
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
		}//finally
		
		return m;
	}
	
	public ArrayList<Member> selectByName(String username) {//회원 이름으로 검색 조회 메소드
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
		
		ResultSet rs=null;
		Connection conn =null;
		PreparedStatement pstm = null;
		
		ArrayList<Member> list = new ArrayList<>();
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql ="SELECT * FROM MEMBER WHERE 이름 = ?";
			
			pstm=conn.prepareStatement(sql);
			
			pstm.setString(1, username);
			
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
		}//finally
		
		return list;
	}

	public int updateMemberName(String userId,String userName) {//회원 이름 변경 메소드 
		
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url="jdbc:oracle:thin:@localhost:1521:xe";
			String id="JDBC";
			String pw="JDBC";
							
			int result=0; 
			Connection conn=null; 
			PreparedStatement pstm=null; 
				
			try {
				Class.forName(driver);
				conn = DriverManager.getConnection(url,id,pw);
				String sql="UPDATE MEMBER SET 이름 = ? WHERE 아이디 = ?";
					
				pstm=conn.prepareStatement(sql);
					
				pstm.setString(1, userName);
				pstm.setString(2, userId);
					
				result = pstm.executeUpdate();
				if(result>0) {
					conn.commit();
					System.out.println("변경 성공!");
				}
				else {
					conn.rollback();
					System.out.println("변경 실패!");
				}
					
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
			}//finally
				
			//결과반환
			return result;
	}//public int updateMemberId

	public int updateMemberPw(String userId, String userPw) {//회원 비밀번호 변경 메소드
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
						
		int result=0; 
		Connection conn=null; 
		PreparedStatement pstm=null; 
			
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="UPDATE MEMBER SET 비밀번호 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, userPw);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("변경 성공!");
			}
			else {
				conn.rollback();
				System.out.println("변경 실패!");
			}
				
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
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberPw

	public int updateMemberGender(String userId, String gender) {//회원 성별 변경 메소드
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
						
		int result=0; 
		Connection conn=null; 
		PreparedStatement pstm=null; 
			
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="UPDATE MEMBER SET 성별 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, gender);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("변경 성공!");
			}
			else {
				conn.rollback();
				System.out.println("변경 실패!");
			}
				
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
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberGender

	public int updateMemberAge(String userId, int age) {//회원 나이 변경 메소드
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
						
		int result=0; 
		Connection conn=null; 
		PreparedStatement pstm=null; 
			
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="UPDATE MEMBER SET 나이= ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setInt(1, age);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("변경 성공!");
			}
			else {
				conn.rollback();
				System.out.println("변경 실패!");
			}
				
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
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberAge

	public int updateMemberEmail(String userId, String email) {//회원 이메일 변경 메소드

		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
						
		int result=0; 
		Connection conn=null; 
		PreparedStatement pstm=null; 
			
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="UPDATE MEMBER SET 이메일 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, email);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("변경 성공!");
			}
			else {
				conn.rollback();
				System.out.println("변경 실패!");
			}
				
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
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberEmail

	public int updateMemberPhone(String userId, String phone) {//회원 핸드폰번호 변경 메소드

		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
						
		int result=0; 
		Connection conn=null; 
		PreparedStatement pstm=null; 
			
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="UPDATE MEMBER SET 핸드폰 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, phone);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("변경 성공!");
			}
			else {
				conn.rollback();
				System.out.println("변경 실패!");
			}
				
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
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberPhone

	public int updateMemberAddress(String userId, String address) {//회원 주소 변경 메소드
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
						
		int result=0; 
		Connection conn=null; 
		PreparedStatement pstm=null; 
			
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="UPDATE MEMBER SET 주소 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, address);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("변경 성공!");
			}
			else {
				conn.rollback();
				System.out.println("변경 실패!");
			}
				
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
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberAddress

	public int updateMemberHobby(String userId, String hobby) {//회원 취미 변경 메소드
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
						
		int result=0; 
		Connection conn=null; 
		PreparedStatement pstm=null; 
			
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="UPDATE MEMBER SET 취미 = ? WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, hobby);
			pstm.setString(2, userId);
				
			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("변경 성공!");
			}
			else {
				conn.rollback();
				System.out.println("변경 실패!");
			}
				
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
		}//finally
			
		//결과반환
		return result;
		
	}//public int updateMemberHobby

	public int deleteMember(String mid) {//특정 회원 탈퇴 메소드
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
						
		int result=0; 
		Connection conn=null; 
		PreparedStatement pstm=null; 
			
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="DELETE FROM MEMBER WHERE 아이디 = ?";
				
			pstm=conn.prepareStatement(sql);
				
			pstm.setString(1, mid);
				
			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("삭제 성공!");
			}
			else {
				conn.rollback();
				System.out.println("삭제 실패!");
			}
				
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
		}//finally
			
		//결과반환
		return result;
		
	}//public int deleteMember

	public int deleteAllMember() {//전체 회원 탈퇴 메소드
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="JDBC";
		String pw="JDBC";
						
		int result=0; 
		Connection conn=null; 
		PreparedStatement pstm=null; 
			
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
			String sql="DELETE FROM MEMBER";
				
			pstm=conn.prepareStatement(sql);

			result = pstm.executeUpdate();
			if(result>0) {
				conn.commit();
				System.out.println("삭제 성공!");
			}
			else {
				conn.rollback();
				System.out.println("삭제 실패!");
			}
				
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
		}//finally
			
		//결과반환
		return result;
		
	}//public int deleteAllMember
	

	
}//public class MemberDao































