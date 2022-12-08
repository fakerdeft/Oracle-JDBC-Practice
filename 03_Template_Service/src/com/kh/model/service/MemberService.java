package com.kh.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.common.JDBCTemplate;
import com.kh.model.dao.MemberDao;
import com.kh.model.vo.Member;

/*
 * Service: 기존 DAO의 역할을 분담한다.
 * -컨트롤러에서 서비스 호출 후 서비스를 거쳐서 DAO로 넘어갈 것
 * -DAO호출시 커넥션 객체와 기존에 넘기고자 했던 데이터값을 같이 넘긴다.
 * -DAO처리가 끝나면 서비스단에서 결과에 따른 트랜잭션 처리까지 한다.
 * -Service단을 추가함으로써 DAO에는 SQL문 처리 구문만 남게 된다(역할세분화)
 * 
 * */

public class MemberService {
	
	public int insertMember(Member m) {//회원 입력
		//Connection 객체를 생성한다;
		
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().insertMember(conn,m);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}
	
	public ArrayList<Member> selectAll() {//전체 조회
		
		Connection conn=JDBCTemplate.getConnection();
		ArrayList<Member> list = new MemberDao().selectAll(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}
	
	public Member selectById(String userid) {//아이디로 조회
		Connection conn=JDBCTemplate.getConnection();
		Member m = new MemberDao().selectById(conn, userid);
		
		JDBCTemplate.close(conn);
		return m;
	}

	public ArrayList<Member> selectByName(String username) {//이름으로 조회

		Connection conn=JDBCTemplate.getConnection();
		ArrayList<Member> list = new MemberDao().selectByName(conn, username);
		
		JDBCTemplate.close(conn);
		return list;
	}

	
	public int updateMemberName(String userId, String userName) {//이름 변경
		
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().updateMemberName(conn, userId, userName);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	
	public int updateMemberPw(String userId, String userPw) {//비밀번호 변경
		
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().updateMemberPw(conn, userId, userPw);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int updateMemberGender(String userId, String gender) {//성별 변경
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().updateMemberGender(conn,userId, gender);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int updateMemberAge(String userId, int age) {//나이 변경
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().updateMemberAge(conn, userId, age);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int updateMemberEmail(String userId, String email) {//이메일 변경
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().updateMemberEmail(conn, userId, email);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int updateMemberPhone(String userId, String phone) {//폰 번호 변경
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().updateMemberPhone(conn, userId, phone);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int updateMemberAddress(String userId, String address) {//주소 변경
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().updateMemberAddress(conn, userId, address);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int updateMemberHobby(String userId, String hobby) {//취미 변경
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().updateMemberHobby(conn, userId, hobby);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int deleteMember(String mid) {//특정 아이디 삭제
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().deleteMember(conn, mid);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int deleteAllMember() {//전체 삭제
		Connection conn= JDBCTemplate.getConnection();
		
		//생성된 Connection객체와 넘겨받은 데이터 m을 Dao한테 전달하며 요청한다.
		int result=new MemberDao().deleteAllMember(conn);
		
		//트랜잭션 처리
		if(result>0) {
			JDBCTemplate.commit(conn);
		}
		else {
			JDBCTemplate.rollback(conn);
		}
		
		//Connection객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}


	
	
}



















