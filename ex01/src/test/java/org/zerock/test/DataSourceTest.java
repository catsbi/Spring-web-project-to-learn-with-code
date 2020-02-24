package org.zerock.test;

import java.sql.Connection;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})// -알 수 없는 오류
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
public class DataSourceTest {

	@Inject
	private DataSource ds;

	@Test
	public void testConection() throws Exception {
		try (Connection con = ds.getConnection()) {
			System.out.println(con);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
