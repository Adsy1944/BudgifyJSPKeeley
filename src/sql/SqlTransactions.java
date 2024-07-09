package sql;

import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;

import objects.BalanceObject;
import tools.DateTool;

public class SqlTransactions {
	
	private static SqlTransactions instance;
	
//	Makes and instance of the class available to the JSP
	public static SqlTransactions getInstance() {
		if (instance == null) {
			instance = new 	SqlTransactions();
		}
		return instance;
	}
	
//	Submits a new transaction to the database
	public String submitTransaction(String date, String category, String description, String amount) {
		String response = "";
		String query = "insert into transaction_table (transaction_date, transaction_category, transaction_description, transaction_amount, transaction_auto)" +
		"values ('" + date + "', '" + category + "', '" + description + "', -" + amount + ", false);";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.execute(query);
			response = amount + " added to " + category + " for " + description + " successfully";
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't submit transaction");
			response = "Couldn't submit transaction";
		}
		return response;
	}
	
//	Creates a new category in the budget 
	public String newCategory(String category, String amount, String auto, int savings) {
		String response = "";
		String query = "insert into category_table (category, budget, auto_spend, savings, archive)" + 
		"values ('" + category + "', " + amount + ", " + auto + ", " + savings + ", 0);";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.executeUpdate(query);
			response = "Budget Creation Successful";
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't create new category");
			response = "Budget Creation Failed";
		}
		return response;
	}
	
//	Adds the allowance amount to the available balance
	public String submitAllowance(String category, String amount) {
		String response = "";
		String query = "insert into transaction_table (transaction_date, transaction_category, transaction_description, transaction_amount, transaction_auto)" +
		"values (CURDATE(), '" + category + "', 'Allowance', " + amount + ", false);";
		System.out.println("Submit Transaction: " + query);
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.execute(query);
			response = "success";
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't submit transaction");
			response = "fail";
		}
		return response;
	}
	
//	Submits a refund to a category, increasing the amount available and adding the "Refund:" to the description string
	public String submitRefund(String date, String category, String description, String amount) {
		String response = "";
		String query = "insert into transaction_table (transaction_date, transaction_category, transaction_description, transaction_amount) " +
		"values ('" + date + "', '" + category + "', 'Refund: " + description + "', " + amount + ");";
		System.out.println("Submit refund: " + query);
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.execute(query);
			response = "Refund submitted to " + category + " successfully";
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't submit refund");
			response = "fail";
		}
		return response;
	}
	
//	Adds funds to a category, increasing the available amount
	public String addFunds(String date, String category, String description, String amount) {
		String response = "";
		String query = "insert into transaction_table (transaction_date, transaction_category, transaction_description, transaction_amount) " +
		"values ('" + date + "', '" + category + "', '" + description + "', " + amount + ");";
		System.out.println("Submit refund: " + query);
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.execute(query);
			response = "Funds submitted successfully";
			System.out.println(response);
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't submit funds");
			response = "fail";
		}
		return response;
	}
	
//	Adds the monthly allowances to the application, by taking an ArrayList<BalanceObject>
	public String postAllowances(ArrayList<BalanceObject> budget) {
		String response = "The following categories failed to update:\n";
		boolean success = true;
		for (int i = 0; i < budget.size(); i++) {
			if (addFunds(DateTool.getInstance().dateToday(), budget.get(i).getCategory(), "Monthly Allowance", budget.get(i).getBalance()).equals("Couldn't submit funds")) {
				success = false;
				response += budget.get(i).getCategory();
				response += "\n";
			}
		}
		if (success == true) {
			response = "All categories updated";
		}
		System.out.println(response);
		return response;
	}
	
//	Changes the budget value of a category
	public String changeBudget(String category, String budget, String savings, String archive) {
		String response = "";
		String query = "update category_table set savings = " + savings + ", archive = " + archive;
		if (budget != null && !budget.equals("")) {
			query += ", budget = " + budget;
		}
		query += " where category = '" + category + "';" ;

		System.out.println("Change Budget query:");
		System.out.println(query);
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.execute(query);
			response = category + " updated";
			stat.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't modify " + category);
			response = "update of " + category + " failed";
		}
		return response;
	}
	
//	Adds a new recurring payment
	public String addRecurringPayment(String day, String category, String amount, String description) {
		String response = "";
		String query = "insert into monthly_payments (payment_day, payment_category, payment_amount, payment_description) values (" + day + ", '"
				+ category + "', " + amount + ", '" + description + "');";
		System.out.println("New recurring payment: " + query);
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.execute(query);
			response = "New payment added successfully";
			stat.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't create recurring payment");
			response = "Failed to set up payment";
		}
		return response;
	}
	
//	Saves changes to the selected monthly payment
	public String editMonthlyPayment(String paymentRef, String paymentAmount, String paymentCategory, String paymentDay, 
			String paymentDescription) {
		String response = "";
		String query = "update monthly_payments set payment_amount = " + paymentAmount + ", payment_category = '" 
		+ paymentCategory + "', payment_day = " + paymentDay + ", payment_description = '" + paymentDescription + "';";
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.execute(query);
			System.out.println("Monthly payment successfully altered");
			response = "Monthly payment successfully altered";
			stat.close();
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't update monthly payment");
			response = "Couldn't update monthly payment";
		}
		return response;
	}
	
//	Deletes the selected monthly payment
	public String deleteMonthlyPayment(String paymentRef) {
		String response = "";
		String query = "delete from monthly_payments where payment_ref = " + paymentRef;
		System.out.println("Delete payment ref: " + paymentRef);
		Connection con = SqlConnection.getInstance().getConnection();
		try {
			Statement stat = con.createStatement();
			stat.execute(query);
			System.out.println("Monthly payment successfully deleted");
			response = "Monthly payment successfully deleted";
			stat.close();
		}
		catch (Exception e) {
			e.printStackTrace();
			System.err.println("Couldn't delete monthly payment");
			response = "Couldn't delete monthly payment";
		}
		return response;
	}

}
