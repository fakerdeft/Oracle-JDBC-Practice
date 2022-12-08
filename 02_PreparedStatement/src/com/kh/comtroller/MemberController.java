package com.kh.comtroller;

import java.util.*;

import com.kh.model.dao.MemberDao;
import com.kh.model.vo.Member;
import com.kh.view.MemberView;

//Controller: View를 통해서 요청(Request)한 기능을 담당
//해당 메소드로 전달된 데이터들을 가공처리 (VO 객체에 담아) Dao에 메소드 호출하며 전달
//Dao로부터 db작업을 마친 결과를 돌려받고 해당 결과에 따라 사용자에게 보여줄 화면(View)를 선택하는 응답(Response)을 진행한다.

public class MemberController {

	public void insertMember(String userId, String userPw, String userName, String gender, int age, String email,
			String phone, String address, String hobby) {
		//1. 전달된 데이터들을 Member 객체에 담기 - 가공처리
		Member m = new Member(userId,userPw,userName,gender,age,email,phone,address,hobby);
		
		//2.DAO에 있는 insertMember 메소드 호출하기(멤버객체를 담아서)
		int result = new MemberDao().insertMember(m);
		
		//3.결과값에 따라서 사용자가 보게될 화면을 지정한다.
		if(result>0) {//성공했을 경우
			//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("회원 추가 성공!");
		}
		else {//실패했을 경우
			//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("회원 추가 실패!");
		}
		
	}//public void insertMember
	

	public void selectAll() {//회원 전체 조회
		
		//DAO에게 요청 보내기(처리결과인 list를 반환했으니 담아놓기)
		ArrayList<Member> list =new MemberDao().selectAll();
		
		//조회 결과가 있는지 없는지 판별하기
		if(list.isEmpty()) {//비어있다=조회된 결과 없다
			new MemberView().displayNodata("전체 조회 결과가 없습니다.");
		}
		else {//조회된 결과가 한 행이라도 있다.
			new MemberView().displayList(list);
		}
	}//public void selectAll

	public void selectById(String userid) {//회원 아이디로 검색
		
			Member m = new MemberDao().selectById(userid);
			
			if(m.getUserId()==null) {//비어있다=조회된 결과 없다
				new MemberView().displayNodata("조회 결과가 없습니다.");
			}
			else {//조회된 결과가 있다.
				new MemberView().displayList2(m);
			}
				
	}//public void selectById
	
	public String selectById2 (String userid) {//회원 아이디로 검색2
		
		Member m = new MemberDao().selectById(userid);
		
		if(m.getUserId()==null) {//비어있다=조회된 결과 없다
			return "조회 결과가 없습니다.";
		}
		else {//조회된 결과가 있다.
			return "조회 성공!";
		}
			
	}//public void selectById2
	
	public void selectByName(String username) {//회원 이름으로 검색
		
		ArrayList<Member> list = new MemberDao().selectByName(username);
		
		if(list.isEmpty()) {//비어있다=조회된 결과 없다
			new MemberView().displayNodata("조회 결과가 없습니다.");
		}
		else {//조회된 결과가  있다.
			new MemberView().displayList(list);
		}	
		
	}//public void selectByName
	
	public String selectByName2 (String username) {//회원 이름으로 검색2
		
		ArrayList<Member> list = new MemberDao().selectByName(username);
		
		if(list.isEmpty()) {//비어있다=조회된 결과 없다
			return "조회 결과가 없습니다.";
		}
		else {//조회된 결과가 있다.
			return "조회 성공!";
		}
			
	}//public void selectByName2
	
	public void updateMemberName(String userId,String userName) {//회원 이름 변경
		
		int result = new MemberDao().updateMemberName(userId, userName);
			
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("이름 변경 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("이름 변경 실패!");
		}
			
	}//public void updateMember

	public void updateMemberPw(String userId, String userPw) {//회원 비밀번호 변경

		int result = new MemberDao().updateMemberPw(userId, userPw);
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("비밀번호 변경 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("비밀번호 변경 실패!");
		}
		
	}

	public void updateMemberGender(String userId, String gender) {//회원 성별 변경
		
		int result = new MemberDao().updateMemberGender(userId, gender);
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("성별 변경 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("성별 변경 실패!");
		}
		
	}

	public void updateMemberAge(String userId, int age) {//회원 나이 변경

		int result = new MemberDao().updateMemberAge(userId, age);
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("나이 변경 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("나이 변경 실패!");
		}
		
	}

	public void updateMemberEmail(String userId, String email) {//회원 이메일 변경

		int result = new MemberDao().updateMemberEmail(userId, email);
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("이메일 변경 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("이메일 변경 실패!");
		}
		
	}

	public void updateMemberPhone(String userId, String phone) {//회원 핸드폰 번호 변경

		int result = new MemberDao().updateMemberPhone(userId, phone);
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("핸드폰번호 변경 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("핸드폰번호 변경 실패!");
		}
		
	}

	public void updateMemberAddress(String userId, String address) {//회원 주소 변경
		
		int result = new MemberDao().updateMemberAddress(userId, address);
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("주소 변경 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("주소 변경 실패!");
		}
		
	}

	public void updateMemberHobby(String userId, String hobby) {//회원 취미 변경
		
		int result = new MemberDao().updateMemberHobby(userId, hobby);
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("취미 변경 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("취미 변경 실패!");
		}
	}

	public void deleteMember(String mid) {//특정 회원 탈퇴
		int result = new MemberDao().deleteMember(mid);
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("회원 탈퇴 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("회원 탈퇴 실패!");
		}
	}

	public void deleteAllMember() {//전체 회원 탈퇴
		int result = new MemberDao().deleteAllMember();
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("전체 탈퇴 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("전체 탈퇴 실패!");
		}
		
	}

}//public class MemberController










