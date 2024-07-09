package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SqlConnection {
	
	private static SqlConnection instance;
	private Connection connection;
	
	public static SqlConnection getInstance() {
		if (instance == null) {
			instance = new SqlConnection();
		}
		return instance;
	}
	
	public Connection getConnection() {
		return connection;
	}
	
	public Connection userConnection(String user, String pword) {
		String url = "jdbc:mariadb://192.168.0.15:3306/budgify_keeley?user=" + user
//		String url = "jdbc:mysql://192.168.0.15:3306/TEST_budgify?user=" + user
//		String url = "jdbc:mysql://localhost:3306/test_budgify?user=" + user
				+ "&password=" + pword;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
//			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(url);
			System.out.print("Connection successful");
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't establish connection");
		}
		return connection;
	}
	
	public void closeConnection() {
		try {
			connection.close();
			connection = null;
			instance = null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
