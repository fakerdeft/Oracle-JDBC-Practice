package com.kh.model.vo;

import java.sql.*;

/*
 * VO(Value Object)
 * DB 테이블의 한 행에 대한 데이터를 기록할 수 있는 저장용 객체
 * 
 * 	-유사용어
 * 	DTO(Data Transger Object)
 * 	DO(Domain Object)
 * 	Entity (Strut에서는 이 용어로 사용)
 * 	bean(EJB에서는 이 용어로 사용)
 * 
 * VO 조건
 * 1) 반드시 캡슐화 적용
 * 2) 기본생성자 및 매개변수 생성자를 작성할 것
 * 3) 모든 필드에 대해 getter/setter 메소드 작성할 것
 * 
 * */

public class Member {
  //필드부: DB 테이블의 컬럼 정보와 유사하게 작업
	private int userNo;//	  USERNO NUMBER PRIMARY KEY,
	private String userId;//    USERID VARCHAR2(20) UNIQUE NOT NULL,
	private String userPw;//    USERPWD VARCHAR2(20) NOT NULL,
	private String userName;//    USERNAME VARCHAR2(20) NOT NULL,
	private String gender;//    GENDER CHAR(1) CHECK (GENDER IN ('M','F')),
	private int age;//    AGE NUMBER,
	private String email;//    EMAIL VARCHAR2(30),
	private String phone;//    PHONE CHAR(11),
	private String address;//    ADDRESS VARCHAR2(100),
	private String hobby;//    HOBBY VARCHAR2(50),
	private Date enrollDate;//    ENROLLDATE DATE DEFAULT SYSDATE NOT NULL
	//import sql.Date로 하세요
	
	
	public Member() {
		super();
	}

	public Member(String userId, String userPw, String userName, String gender, int age, String email, String phone,
			String address, String hobby) {
		super();
		this.userId = userId;
		this.userPw = userPw;
		this.userName = userName;
		this.gender = gender;
		this.age = age;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.hobby = hobby;
	}


	public Member(int userNo, String userId, String userPw, String userName, String gender, int age, String email,
			String phone, String address, String hobby, Date enrollDate) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userPw = userPw;
		this.userName = userName;
		this.gender = gender;
		this.age = age;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.hobby = hobby;
		this.enrollDate = enrollDate;
	}

	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public Date getEnrollDate() {
		return enrollDate;
	}
	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}
	
	@Override
	public String toString() {
		return "학번: " + userNo + "/아이디: " + userId + "/비밀번호: " + userPw + "/이름: " + userName
				+ "/성별: " + gender + "/나이: " + age + "/이메일: " + email + "/핸드폰: " + phone + "/주소: "
				+ address + "/취미: " + hobby + "/등록일: " + enrollDate ;
	}


	
	

}












