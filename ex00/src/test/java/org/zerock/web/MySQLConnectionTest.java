package org.zerock.web;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MySQLConnectionTest {

	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/book_ex?useSSL=false&serverTimezone=UTC";
	
	@Test
	public void testConnection() throws Exception{
		Class.forName(DRIVER);
		
		try (Connection con = DriverManager.getConnection(URL, "zerock", "zerock")){
			System.out.println(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
