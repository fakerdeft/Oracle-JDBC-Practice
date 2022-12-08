package com.kh.run;

import java.util.Properties;

import com.kh.view.MemberView;

public class Run {

	public static void main(String[] args) {
		
		/*
		 * Properties: Map계열의 컬렉션 key+value 세트로 담는게 특징
		 * Properties는 주로 외부 설정파일을 읽어오기 또는 파일형태로 출력하고자 할때 사용.
		 * Properties,xml파일 내보내기 -> store(),storeToXML().
		 */
		//resource폴더 만들기
//		File f =new File("resource");
//		f.mkdir();//폴더생성
		
		//프로퍼티스 값 세팅
//		Properties prop=new Properties();
		
//		prop.setProperty("driver", "oracle.jdbc.driver.OracleDriver");
//		prop.setProperty("url", "jdbc:oracle:thin:@localhost:1521:xe");
//		prop.setProperty("username", "JDBC");
//		prop.setProperty("password", "JDBC");
//		
//		try {
//			//properties와 xml파일 내보내기(출력)
//			prop.store(new FileOutputStream("resource/driver.properties"), "driver properties");
//			prop.storeToXML(new FileOutputStream("resource/driver.xml"), "driver xml");
//		} catch (FileNotFoundException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		
		//내보낸 파일 정보 읽기(입력)
		
//		try {
//			prop.load(new FileInputStream("resource/driver.properties"));
//			
//			System.out.println(prop.getProperty("driver"));
//			System.out.println(prop.getProperty("url"));
//			System.out.println(prop.getProperty("username"));
//			System.out.println(prop.getProperty("password"));
//			System.out.println(prop.getProperty("aaa"));
//			
//		} catch (FileNotFoundException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		
		new MemberView().mainView();
	}

}



























