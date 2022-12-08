package com.kh.view;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;
import com.kh.comtroller.MemberController;
import com.kh.model.vo.Member;

public class MemberView {//View: 사용자가 보게 될 시각적인 요소를 담당(화면->입력,출력)
	
	//전역에서 사용할 수 있는 Scanner 생성
	private Scanner sc = new Scanner(System.in);
	//전역에서 사용가능한 MemberController 생성
	private MemberController mc = new MemberController();
	
	
	public void mainView() {//사용자가 보게 될 첫 메뉴화면
		while(true) {
			int menu=0;

			while(true) {//정수 입력
				
				System.out.println("-----회원 관리 프로그램-----");
				System.out.println("1.회원 추가");
				System.out.println("2.회원 전체 조회");
				System.out.println("3.회원 아이디로 검색");
				System.out.println("4.회원 이름으로 검색");
				System.out.println("5.회원 정보 변경");
				System.out.println("6.회원 탈퇴");
				System.out.println("0.프로그램 종료");
				System.out.println("----------------------");
				System.out.println("이용할 메뉴 선택:");
				try {
					menu = sc.nextInt();
					sc.nextLine();
					break;
				}catch(InputMismatchException ime) {
					sc = new Scanner(System.in);
					System.out.println("정수만 입력해주세요.");
					System.out.println();
				}
			}//while
			
			switch (menu) {
			case 1: insertMember();				
				break;
			case 2: selectAll();
				break;
			case 3: selectById();
				break;
			case 4: selectByName();
				break;
			case 5: updateMember();
				break;
			case 6: deleteMember();
				break;
			case 0: System.out.println("프로그램 종료"); 
				return;
			default: System.out.println("잘못된 번호를 입력하셨습니다.\n다시 입력하세요.");
			}//switch
			System.out.println();
			 
		}//while
		
	}//public void mainView()

	public void insertMember() {//회원 추가용 화면
		
		String gender="";
		int age=0;
		
		System.out.println("-----회원 추가-----");
		System.out.println("아이디:");
		String userId = sc.nextLine();
		System.out.println("비밀번호:");
		String userPw = sc.nextLine();
		System.out.println("이름:");
		String userName = sc.nextLine();
		
		while(true) {//성별 입력
			System.out.println("성별(M/F):");
			gender=sc.nextLine().toUpperCase();
			if(gender.equals("M")||gender.equals("F"))
				break;
			else {
				System.out.println("M 또는 F만 입력이 가능합니다.\n다시 입력해주세요.");
			}
		}
		
		while(true) {//나이 입력
			System.out.println("나이:");
			try {
				age = sc.nextInt();
				sc.nextLine();
				break;
			}catch(InputMismatchException ime) {
				sc = new Scanner(System.in);
				System.out.println("자연수만 입력해주세요.");
				ime.printStackTrace();
				System.out.println(ime.getClass().getName()+"예외가 "+ime.getMessage()+"때문에 발생했습니다.");
			}
		}
		
		System.out.println("이메일:");
		String email=sc.nextLine();
		System.out.println("핸드폰 번호:");
		String phone =sc.nextLine();
		System.out.println("주소:");
		String address = sc.nextLine();
		System.out.println("취미:");
		String hobby = sc.nextLine();
		
		//입력받은 정보를 Controller에게 요청 보내기
		mc.insertMember(userId,userPw,userName,gender,age,email,phone,address,hobby);
		
	}//public void insertMember
		
	public void selectAll() {//회원 전체 조회 화면
		System.out.println("-----회원 전체 조회-----");
		mc.selectAll();
	}//public void selectAll
		
	public void selectById() {//회원 아이디로 검색 화면
		String userid="";
		System.out.println("-----회원 아이디로 검색-----");
		System.out.println("아이디 입력:");
		
		while(true) {//조회 할 때 까지 반복
			userid = sc.nextLine();
			mc.selectById2(userid);
			
			System.out.println(mc.selectById2(userid));
			if(mc.selectById2(userid)=="조회 결과가 없습니다.") {//조회 실패
				System.out.println("다시 입력:");
			}
			else {//조회 성공하면 반복문 탈출
				break;
			}
		}//while
		mc.selectById(userid);
		
	}//public void selectById
	
	public void selectByName() {//회원 이름으로 검색 화면
		String username="";
		System.out.println("-----회원 이름으로 검색-----");
		System.out.println("이름 입력:");
		
		while(true) {//조회 할 때 까지 반복
			username = sc.nextLine();
			mc.selectByName2(username);
			
			System.out.println(mc.selectByName2(username));
			if(mc.selectByName2(username)=="조회 결과가 없습니다.") {//조회 실패
				System.out.println("다시 입력:");
			}
			else {//조회 성공하면 반복문 탈출
				break;
			}
		}//while
		mc.selectByName(username);
		
	}//public void selectByName
		
	public void updateMember() {//회원 정보 변경 화면
		String userId ="";
		System.out.println("-----회원 정보 변경-----");
		System.out.println("수정할 회원의 아이디를 입력하세요:");		
		
		while(true) {//조회 할 때 까지 반복
			userId = sc.nextLine();
			mc.selectById2(userId);
			
			System.out.println(mc.selectById2(userId));
			if(mc.selectById2(userId)=="조회 결과가 없습니다.") {//조회 실패
				System.out.println("다시 입력:");
			}
			else {//조회 성공하면 반복문 탈출
				break;
			}
		}//while
		
		while(true) {//조회가 성공했을 경우 나오는 메뉴
			int menu=0;
			
			while(true) {//정수 입력
				System.out.println("---수정할 메뉴---");
				System.out.println("1.이름");
				System.out.println("2.비밀번호");
				System.out.println("3.성별");
				System.out.println("4.나이");
				System.out.println("5.이메일");
				System.out.println("6.핸드폰");
				System.out.println("7.주소");
				System.out.println("8.취미");
				System.out.println("0:메인 메뉴로");
				System.out.println("이용할 메뉴 번호 입력:");				
				try {
					menu = sc.nextInt();
					sc.nextLine();
					break;
				}catch(InputMismatchException ime) {
					sc = new Scanner(System.in);
					System.out.println("정수만 입력해주세요.");
					System.out.println();
				}
			}
			
			switch (menu) {
			case 1:
				System.out.println("새 이름:");
				String userName = sc.nextLine();
				mc.updateMemberName(userId, userName);
				break;
			case 2:
				System.out.println("새 비밀번호:");
				String userPw = sc.nextLine();
				mc.updateMemberPw(userId, userPw);
				break;
			case 3:
				System.out.println("새 성별:");
				String gender = sc.nextLine().toUpperCase();
				mc.updateMemberGender(userId, gender);
				break;
			case 4: 
				System.out.println("새 나이:");
				int age = sc.nextInt();
				mc.updateMemberAge(userId, age);
				break;
			case 5: 
				System.out.println("새 이메일:");
				String email = sc.nextLine();
				mc.updateMemberEmail(userId, email);
				break;
			case 6: 
				System.out.println("새 핸드폰:");
				String phone = sc.nextLine();
				mc.updateMemberPhone(userId, phone);
				break;
			case 7:
				System.out.println("새 주소:");
				String address =sc.nextLine();
				mc.updateMemberAddress(userId, address);
				break;
			case 8:
				System.out.println("새 취미:");
				String hobby=sc.nextLine();
				mc.updateMemberHobby(userId, hobby);
				break;
			case 0: System.out.println("메인 메뉴로 돌아갑니다."); 
				return;
			default: System.out.println("잘못된 번호를 입력하셨습니다.\n다시 입력하세요.");
			}//switch
			System.out.println();
		}//while
		
	}//public void updateMember
		
	public void deleteMember() {//회원 탈퇴 화면
		int n=0;
		System.out.println("-----회원 탈퇴-----");

		
		while(true) {//정수 입력
			System.out.println("1.원하는 회원 탈퇴");
			System.out.println("2.전체 탈퇴");
			System.out.println("1,2를 제외한 아무 숫자나 입력하면 메인 메뉴로 돌아갑니다.");
			System.out.println("번호 입력:");
			try {
				n = sc.nextInt();
				sc.nextLine();
				break;
			}catch(InputMismatchException ime) {
				sc = new Scanner(System.in);
				System.out.println("정수만 입력해주세요.");
				System.out.println();
			}
		}
		
		if(n==1) {
			System.out.println("탈퇴를 원하는 회원의 아이디를 입력하세요:");
			String mid=sc.nextLine();
			mc.deleteMember(mid);
		}
		else if(n==2) {
			mc.deleteAllMember();
		}
		else {
			System.out.println("메인 메뉴로 돌아갑니다.");
		}
		
	}//public void deleteMember
	
	
	//------------------------------------------
	//사용자가 보게 될 결과 화면 메소드들
	
	//사용자 요청 성공 시 보여질 화면
	public void displaySuccess(String message){
		System.out.println("서비스 요청 성공: "+message);
	}

	public void displayFail(String message) {
		System.out.println("서비스 요청 실패: "+message);
	}

	public void displayNodata(String message) {//전체조회시 결과가 없을 경우 보여줄 화면
		System.out.println(message);
	}

	public void displayList(ArrayList<Member> list) {//전체조회시 결과가 있을 경우 보여줄 화면

		System.out.println("조회된 결과는"+list.size()+"명 입니다.");
		
		for(Member m: list) {
			System.out.println(m);
		}
		
	}

	public void displayList2(Member m) {//특정 아이디로 조회시 결과가 있을 경우 보여줄 화면
		
		System.out.println(m);
		
	}


}//public class MemberView



























