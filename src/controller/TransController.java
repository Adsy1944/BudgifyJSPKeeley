package controller;

import java.util.ArrayList;
import java.util.Date;

import objects.MonthlyPaymentObject;
import sql.SqlQueries;
import sql.SqlTransactions;
import tools.DateTool;

public class TransController {
	
	private static TransController instance;
	
//	Makes an instance of this class available to the JSP
	public static TransController getInstance() {
		if (instance == null) {
			instance = new TransController();
		}
		return instance;
	}

//	Transfers amount from one category to another
	public String transfer(String date, String from, String to, String amount) {
		String response = "";
		String description1 = "transfer to " + to;
		String description2 = "transfer from " + from;
		String charge = SqlTransactions.getInstance().submitTransaction(date, from, description1, amount);
		if (charge.equals(amount + " added to " + from + " for " + description1 + " successfully")) {
			String deposit = SqlTransactions.getInstance().addFunds(date, to, description2, amount);
			if (deposit.equals("Funds submitted successfully")) {
				System.out.println("add funds: " + deposit);
				response = "Transfer completed successfully";
			}
			else {
				response = "Funds taken from " + from + ", but couldn't be deposited to " + to;
			}
		}
		else {
			response = "Couldn't take funds from " + from;
		}
		return response;
	}
	
//	Adds all the new allowances for the month
	public String newMonth() {
		String results = SqlTransactions.getInstance().postAllowances(SqlQueries.getInstance().getAllowances());
		return results;
	}
	
//	Modifies the budget of an existing
	public String changeBudget(String category, String budget, String savings, String archive) {
		String response = SqlTransactions.getInstance().changeBudget(category, budget, savings, archive);
		System.out.println("TransControllerArchive: " + archive);
		return response;
	}
	
//	Deletes a transaction from the transaction_table
	public String deleteTransaction(String transID) {
		String response = SqlQueries.getInstance().deleteTransaction(transID);
		return response;
	}
	
//	Builds and provides the table for recurring payments
	public String getRecurringPayments() {
		ArrayList<MonthlyPaymentObject> payments = SqlQueries.getInstance().getMonthlyPayments();
		String response = "";
		for(int i = 0; i < payments.size(); i++) {
			response += "<tr><td>" + payments.get(i).getDayNumber() + "</td><td>" + payments.get(i).getCategory() + "</td><td>" 
		+ payments.get(i).getPaymentDescription() + "</td><td>" + payments.get(i).getAmount() 
		+ "</td><td><form action='recPaymentEdit.jsp'><input id='paymentRef' name='paymentRef' value='" 
		+ payments.get(i).getPaymentRef() + "' hidden><button type='submit' class='btn btn-dark'>Edit</button></form></td></tr>";
		}
		return response;
	}
	
//	Adds a new recurring payment
	public String addRecurringPayment(String day, String category, String amount, String description) {
		return SqlTransactions.getInstance().addRecurringPayment(day, category, amount, description);
	}
	
//	Gets a single recurring payment
	public MonthlyPaymentObject getMonthlyPayment(String paymentRef) {
		return SqlQueries.getInstance().getMonthlyPayment(paymentRef);
	}
	
//	Saves changes to the selected Monthly Payment
	public String editMonthlyPayment(String paymentRef, String paymentAmount, String paymentCategory, String paymentDay, 
			String paymentDescription) {
		return SqlTransactions.getInstance().editMonthlyPayment(paymentRef, paymentAmount, paymentCategory, paymentDay, paymentDescription);
	}
	
//	Deletes the selected monthly payment
	public String deleteMonthlyPayment(String paymentRef) {
		return SqlTransactions.getInstance().deleteMonthlyPayment(paymentRef);
	}
	
//	Adds a new category to the budget
	public String newCategory(String category, String amount, String auto, int savings) {
		return SqlTransactions.getInstance().newCategory(category, amount, auto, savings);
	}
	
//	Submits an allowance
	public String submitAllowance(String category, String amount) {
		return SqlTransactions.getInstance().submitAllowance(category, amount);
	}
	
//	Adds funds into a budget category
	public String addFunds(String date, String category, String description, String amount) {
		return SqlTransactions.getInstance().addFunds(date, category, description, amount);
	}
	
//	Submits a transaction to its category
	public String submitTransaction(String date, String category, String description, String amount) {
		return SqlTransactions.getInstance().submitTransaction(date, category, description, amount);
	}
	
//	Submits a preformatted refund to the category
	public String submitRefund(String date, String category, String description, String amount) {
		return SqlTransactions.getInstance().submitRefund(date, category, description, amount);
	}
	
//	Gets the transaction history for the specified category
	public ArrayList<String> getHistory(String category) {
		return SqlQueries.getInstance().getHistory(category);
	}
	
//	Gets all the transaction History
	public ArrayList<String> getAllHistory() {
		return SqlQueries.getInstance().getAllHistory();
	}
	
// 	Gets the balance of the specified category
	public String getBalance(String category) {
		return SqlQueries.getInstance().getBalance(category);
	}
	
//	Gets the list of budget categories and returns them as select options
	public String getCategories() {
		return SqlQueries.getInstance().getCategories();
	}
	
//	Gets the total available balance for the entire budget
	public String getTotal() {
		return SqlQueries.getInstance().getTotal();
	}
	
	public String makeMonthlyPayments() {
		String response = "";
		ArrayList<MonthlyPaymentObject> monthlyPayments = SqlQueries.getInstance().getMonthlyPayments();
		for (int i = 0; i < monthlyPayments.size(); i++) {
			String date = DateTool.getInstance().getDate() + "-" + monthlyPayments.get(i).getDayNumber();
			String category = monthlyPayments.get(i).getCategory();
			String description = "Auto: " + monthlyPayments.get(i).getPaymentDescription();
			String amount = monthlyPayments.get(i).getAmount();
			response += SqlTransactions.getInstance().submitTransaction(date, category, description, amount) + "<br/>";
		}
		System.out.println(response);
		return response;
	}
	
//	Gets the total budget
	public String getTotalBudget() {
		return SqlQueries.getInstance().getTotalBudget();
	}
	
//	Finds out if a category is a savings account
	public int getIsSavings(String category) {
		return SqlQueries.getInstance().getIsSavings(category);
	}
	
//	Gets the total allocated in the budget screen
	public String getTotalAllocated() {
		return SqlQueries.getInstance().getTotalAllocated();
	}
	
//	Gets the total savings allocated in the budget screen
	public String getSavingsAllocated() {
		return SqlQueries.getInstance().getSavingsAllocated();
	}
	
//	Finds out if a category is archived
	public int getIsArchived(String category) {
		return SqlQueries.getInstance().getIsArchived(category);
	}
	
}
