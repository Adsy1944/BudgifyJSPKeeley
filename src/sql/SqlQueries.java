package sql;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import objects.BalanceObject;
import objects.MonthlyPaymentObject;

import tools.Utilities;

public class SqlQueries {

	private static SqlQueries instance;

//	Makes an instance of this class available to the JSP
	public static SqlQueries getInstance() {
		if (instance == null) {
			instance = new SqlQueries();
		}
		return instance;
	}

//	Will get the balance of a specified category
	public String getBalance(String category) {
		String response = "";
		String query = "select sum(transaction_amount) as ans from transaction_table where transaction_category = '"
				+ category + "';";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				response += result.getString("ans");
			}
			result.close();
			stat.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't retrieve balance");
			response = "Couldn't retrieve balance";
		}
		return response;
	}

//	Will get the total balance of all categories combined
	public String getTotal() {
		String response = "";
		String query = "SELECT SUM(transaction_amount) as ans\r\n"
				+ "FROM transaction_table t\r\n"
				+ "JOIN category_table c\r\n"
				+ "ON t.transaction_category = c.category \r\n"
				+ "WHERE c.savings = 0;";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				response += result.getString("ans");
			}
			result.close();
			stat.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't retrieve balance");
			response += "Couldn't retrieve balance";
		}
		return response;
	}

//	Will get the total of each budget balance, and return them as a BalanceObject, containing the category and it's balance
	public ArrayList<BalanceObject> getBudgetBalances() {
		ArrayList<BalanceObject> balanceArray = new ArrayList<BalanceObject>();
		String query = 
				"select t.transaction_category, sum(t.transaction_amount) as ans " + 
				"from category_table c " + 
				"join transaction_table t " +
				"on c.category = t.transaction_category " +
				"where (c.archive != 1 OR c.archive IS NULL) AND (c.savings != 1  OR c.savings IS NULL)" +
				"group by t.transaction_category;";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				BalanceObject object = new BalanceObject(result.getString("transaction_category"),
						result.getString("ans"));
				System.out.println(object.getCategory());
				System.out.println(object.getBalance());
				balanceArray.add(object);
			}
			result.close();
			stat.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't retrieve balances");
			BalanceObject object = new BalanceObject("Couldn't find category", "Couldn't find balance");
			balanceArray.add(object);
		}
		return balanceArray;
	}
	
//	Will get the total of each savings balance, and return them as a BalanceObject, containing the category and it's balance
	public ArrayList<BalanceObject> getSavingsBalances() {
		ArrayList<BalanceObject> balanceArray = new ArrayList<BalanceObject>();
		String query = 
				"select t.transaction_category, sum(t.transaction_amount) as ans " + 
				"from category_table c " + 
				"join transaction_table t " +
				"on c.category = t.transaction_category " +
				"where (c.archive != 1 OR c.archive IS NULL) AND (c.savings = 1)" +
				"group by t.transaction_category;";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				BalanceObject object = new BalanceObject(result.getString("transaction_category"),
						result.getString("ans"));
				System.out.println(object.getCategory());
				System.out.println(object.getBalance());
				balanceArray.add(object);
			}
			result.close();
			stat.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't retrieve balances");
			BalanceObject object = new BalanceObject("Couldn't find category", "Couldn't find balance");
			balanceArray.add(object);
		}
		return balanceArray;
	}
	
//	Will get the total of each archived balance, and return them as a BalanceObject, containing the category and it's balance
	public ArrayList<BalanceObject> getArchiveBalances() {
		ArrayList<BalanceObject> balanceArray = new ArrayList<BalanceObject>();
		String query = 
				"select t.transaction_category, sum(t.transaction_amount) as ans " + 
				"from category_table c " + 
				"join transaction_table t " +
				"on c.category = t.transaction_category " +
				"where (c.archive = 1)" +
				"group by t.transaction_category;";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				BalanceObject object = new BalanceObject(result.getString("transaction_category"),
						result.getString("ans"));
				System.out.println(object.getCategory());
				System.out.println(object.getBalance());
				balanceArray.add(object);
			}
			result.close();
			stat.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't retrieve balances");
			BalanceObject object = new BalanceObject("Couldn't find category", "Couldn't find balance");
			balanceArray.add(object);
		}
		return balanceArray;
	}

//	Gets all the transaction history for all the categories.
	public ArrayList<String> getAllHistory() {
		ArrayList<String> response = new ArrayList<String>();
		String query = "select * from transaction_table where transaction_date between now() - interval 70 day and now() order by transaction_date desc;";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				String ans = "<tr><td>" + result.getString("transaction_date") + "</td><td>"
						+ result.getString("transaction_description") + "</td><td>"
						+ result.getString("transaction_category") + "</td><td>"
						+ result.getString("transaction_amount") + "</td><td>"
						+ "<form action='deleteTransaction.jsp'><input hidden name='transID' id='transID' type='number' value='"
						+ result.getString("transaction_no")
						+ "'><input type='text' name='category' id='category' hidden value='null"
						+ "'><button class='btn btn-dark' type='submit'>Delete</button></form></td></tr>";
				response.add(ans);
			}
			result.close();
			stat.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't obtain full history");
			response.add("Couldn't get history");
		}
		return response;
	}

//	Will get all of the transactions for a given category, returned as an ArrayList of Strings, one line of HTML for each transaction
	public ArrayList<String> getHistory(String category) {
		ArrayList<String> response = new ArrayList<String>();
		String query = "select * from transaction_table where "
				+ "transaction_category = '" + category + "' order by transaction_date desc;";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				System.out.println("Transaction Date: " + result.getString("transaction_date"));
				System.out.println("Transaction Description: " + result.getString("transaction_description"));
				System.out.println("Transaction Amount: " + result.getString("transaction_amount"));
				System.out.println("Transaction No: " + result.getString("transaction_no"));
				String ans = "<tr><td>" + result.getString("transaction_date") + "</td><td>"
						+ result.getString("transaction_description") + "</td><td>£"
						+ result.getString("transaction_amount") + "</td>"
						+ "<td><form action='deleteTransaction.jsp'><input hidden name='transID' id='transID' type='number' value='" 
						+ result.getString("transaction_no") 
						+ "'><input type='text' name='category' id='category' hidden value='" + category 
						+ "'><button class='btn btn-dark' type='submit'>Delete</button></form></td></tr>";
				response.add(ans);
			}
			result.close();
			stat.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get history");
			response.add("Couldn't get history");
		}
		return response;
	}

//	Will get a String containing HTML to create a select option for each category
	public String getCategories() {
		String response = "<option disabled selected='selected'>Please select a category</option>";
		String query = "select category from category_table where archive = 0;";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				response += "<option value=" + result.getString("category") + ">" + result.getString("category")
						+ "</option>";
			}
			result.close();
			stat.close();
		}

		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't retrieve categories");
			response = "<option disabled>Couldn't retrieve categories</option>";
		}
		return response;
	}
	
//	Gets a list of all the categories and their budgets.
	public ArrayList<String> getBudgets() {
		ArrayList<String> response = new ArrayList<String>();
		String query = "select category, budget, savings, archive from category_table";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				String line = "<tr><td>" + result.getString("Category") + "</td><td>£" + result.getString("budget") + "</td><td>" 
			+ Utilities.intToYesNo(result.getInt("savings")) + "</td><td>" + Utilities.intToYesNo(result.getInt("archive")) + "</td><td>" +
			"<button class=\"btn btn-sm btn-dark\" onclick=\"window.location.href='changeBudget.jsp?category=" + result.getString("category") + "'\">Change</button></td></tr>";
				response.add(line);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't retrieve budgets");
			response.add("Couldn't retrieve budgets");
		}
		return response;
	}
	

	
//	------------------------------------------------------------------------------------------------------------------------------
//	New methods controlled by transaction controller instead of the JSP directly:
//	------------------------------------------------------------------------------------------------------------------------------

//	Returns a list of all of the budget categories and their allowances
	public ArrayList<BalanceObject> getBudgetObjects() {
		ArrayList<BalanceObject> response = new ArrayList<BalanceObject>();
		String query = "select * from category_table;";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				BalanceObject answer = new BalanceObject(result.getString("category"), result.getString("balance"));
				response.add(answer);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get budgets");
			BalanceObject error = new BalanceObject("Error", "Couldn't find budgets");
			response.add(error);
		}
		return response;
	}
	
//	Returns the categories and their monthly allowance figures
	public ArrayList<BalanceObject> getAllowances() {
		ArrayList<BalanceObject> response = new ArrayList<BalanceObject>();
		String query = "select * from category_table";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while(result.next()) {
				BalanceObject object = new BalanceObject();
				object.setBalance(result.getString("budget"));
				object.setCategory(result.getString("category"));
				response.add(object);
			}
			result.close();
			stat.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get allowances");
		}
		return response;
	}

//	Retrieves the current budget for a category
	public String getBudget(String category) {
		String response = "";
		String query = "select * from category_table where category = '" + category + "';";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
			response = "£" + result.getString("budget");
			}
			result.close();
			stat.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get existing budget");
			response = "Error";
		}
		return response;
	}
	
//	Deletes a transaction
	public String deleteTransaction(String transID) {
		String query = "delete from transaction_table where transaction_no = " + transID + ";";
		String response = "";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.execute(query);
			response = "Transaction ID: " + transID + " successfully deleted";
			stat.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't delete transaction ID: " + transID);
			response = "Couldn't delete transaction ID: " + transID;
		}
		return response;
	}
	
//	Retrieves all of the recurring payments
	public ArrayList<MonthlyPaymentObject> getMonthlyPayments() {
		ArrayList<MonthlyPaymentObject> monthlyPayments = new ArrayList<MonthlyPaymentObject>();
		String query = "select * from monthly_payments";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				MonthlyPaymentObject monthlyPayment = new MonthlyPaymentObject();
				monthlyPayment.setCategory(result.getString("payment_category"));
				monthlyPayment.setPaymentDescription(result.getString("payment_description"));
				monthlyPayment.setAmount(result.getString("payment_amount"));
				monthlyPayment.setPaymentRef(result.getString("payment_Ref"));
				monthlyPayment.setDayNumber(result.getString("payment_day"));
				monthlyPayments.add(monthlyPayment);
			}
			result.close();
			stat.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get monthly payments");
		}
		return monthlyPayments;
	}
	
//	Gets a single monthly payment based on the provided payment reference
	public MonthlyPaymentObject getMonthlyPayment(String paymentRef) {
		String query = "select * from monthly_payments where payment_ref = " + paymentRef + ";";
		MonthlyPaymentObject payment = new MonthlyPaymentObject();
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				payment.setAmount(result.getString("payment_amount"));
				payment.setCategory(result.getString("payment_category"));
				payment.setDayNumber(result.getString("payment_day"));
				payment.setPaymentDescription(result.getString("payment_description"));
				payment.setPaymentRef(result.getString("payment_ref"));
			}
			result.close();
			stat.close();
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't retrieve monthly payment");
		}
		return payment;
	}
	
//	Gets the total budget allocated.
	public String getTotalBudget() {
		String query = "select SUM(budget) as total from category_table WHERE savings = 0;";
		String ans = "";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				ans = result.getString("total");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get total budget");
		}
		return ans;
	}
	
//	Gets the total monies allocated.
	public String getTotalAllocated() {
		String query = "select SUM(budget) as total from category_table;";
		String ans = "";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				ans = result.getString("total");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get total allocated");
		}
		return ans;
	}
	
//	Gets the total savings allocated.
	public String getSavingsAllocated() {
		String query = "select SUM(budget) as total from category_table WHERE savings = 1;";
		String ans = "";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				ans = result.getString("total");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get total savings");
		}
		return ans;
	}
	
//	Finds out if a category is a savings account
	public int getIsSavings(String category) {
		String query = "select savings from category_table where category = '" + category + "';";
		int response = 2;
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				response = result.getInt("savings");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get savings marker");
		}
		return response;
	}
	
//	Finds out if a category is archived
	public int getIsArchived(String category) {
		String query = "select archive from category_table where category = '" + category + "';";
		int response = 2;
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet result = stat.executeQuery(query);
			while (result.next()) {
				response = result.getInt("archive");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't get archive marker");
		}
		return response;
	}
	
}

