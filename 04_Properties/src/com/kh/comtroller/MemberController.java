package com.kh.comtroller;

import java.util.ArrayList;

import com.kh.model.service.MemberService;
import com.kh.model.vo.Member;
import com.kh.view.MemberView;

public class MemberController {

	public void insertMember(String userId, String userPw, String userName, String gender, int age, String email,
			String phone, String address, String hobby) {
		//1. 전달된 데이터들을 Member 객체에 담기 - 가공처리 후 Service에게 요청 전달
		Member m = new Member(userId,userPw,userName,gender,age,email,phone,address,hobby);
	
		//가공처리한 데이터를 Service에게 요청전달
		int result = new MemberService().insertMember(m);
	
		//결과값으로 사용자에게 보여줄 화면 지정
		if(result>0) {
			new MemberView().displaySuccess("회원 정보 추가 성공!");
		}
		else {
			new MemberView().displayFail("회원 정보 추가 실패!");
		}
	
	}//public void insertMember
	
	public void selectAll() {//회원 전체 조회
		
		ArrayList<Member> list =new MemberService().selectAll();
		
		//조회 결과가 있는지 없는지 판별하기
		if(list.isEmpty()) {//비어있다=조회된 결과 없다
			new MemberView().displayNodata("전체 조회 결과가 없습니다.");
		}
		else {//조회된 결과가 한 행이라도 있다.
			new MemberView().displayList(list);
		}
	}//public void selectAll

	public void selectById(String userid) {//회원 아이디로 검색
		
			Member m = new MemberService().selectById(userid);
			
			if(m.getUserId()==null) {//비어있다=조회된 결과 없다
				new MemberView().displayNodata("조회 결과가 없습니다.");
			}
			else {//조회된 결과가 있다.
				new MemberView().displayList2(m);
			}
				
	}//public void selectById
	
	public String selectById2 (String userid) {//회원 아이디로 검색2
		
		Member m = new MemberService().selectById(userid);
		
		if(m.getUserId()==null) {//비어있다=조회된 결과 없다
			return "조회 결과가 없습니다.";
		}
		else {//조회된 결과가 있다.
			return "조회 성공!";
		}
			
	}//public void selectById2
	
	public void selectByName(String username) {//회원 이름으로 검색
		
		ArrayList<Member> list = new MemberService().selectByName(username);
		
		if(list.isEmpty()) {//비어있다=조회된 결과 없다
			new MemberView().displayNodata("조회 결과가 없습니다.");
		}
		else {//조회된 결과가  있다.
			new MemberView().displayList(list);
		}	
		
	}//public void selectByName
	
	public String selectByName2 (String username) {//회원 이름으로 검색2
		
		ArrayList<Member> list = new MemberService().selectByName(username);
		
		if(list.isEmpty()) {//비어있다=조회된 결과 없다
			return "조회 결과가 없습니다.";
		}
		else {//조회된 결과가 있다.
			return "조회 성공!";
		}
			
	}//public void selectByName2
	
	public void updateMemberName(String userId,String userName) {//회원 이름 변경
		
		int result = new MemberService().updateMemberName(userId, userName);
			
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

		int result = new MemberService().updateMemberPw(userId, userPw);
		
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
		
		int result = new MemberService().updateMemberGender(userId, gender);
		
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

		int result = new MemberService().updateMemberAge(userId, age);
		
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

		int result = new MemberService().updateMemberEmail(userId, email);
		
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

		int result = new MemberService().updateMemberPhone(userId, phone);
		
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
		
		int result = new MemberService().updateMemberAddress(userId, address);
		
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
		
		int result = new MemberService().updateMemberHobby(userId, hobby);
		
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
		int result = new MemberService().deleteMember(mid);
		
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
		int result = new MemberService().deleteAllMember();
		
		if(result>0) {//성공했을 경우
				//성공메세지를 띄워주는 화면 호출
			new MemberView().displaySuccess("전체 탈퇴 성공!");
		}
		else {//실패했을 경우
				//실패메세지를 띄워주는 화면 호출
			new MemberView().displayFail("전체 탈퇴 실패!");
		}
		
	}
	
	
	
	
	
	
	
	
}//class MemberController