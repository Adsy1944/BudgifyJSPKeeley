package pageBuilder;

import java.util.ArrayList;

import objects.BalanceObject;

public class DashboardBuilder {
	
	private static DashboardBuilder instance;
	
	public static DashboardBuilder getInstance() {
		if (instance == null) {
			instance = new DashboardBuilder();
		}
		return instance;
	}
	
	public String dashTile(String category, String amount) {
		String response = "<div class=\"card\" style=\"width: 15rem; margin: 1rem;\"" +
				"onclick=\"window.location.href='transactions/transactionHistory.jsp?category=" + 
				category + "'\">" + 
				"<div class=\"card-body\">" + 
				"<h4 class=\"card-title\">" + 
				category +
				"</h4>" + 
				"<p class=\"card-subtitle\">" + 
				"£" +
				amount +
				"</p>" + 
				"</div>" + 
				"</div>";
		return response;
	}
	
	public String getTiles(ArrayList<BalanceObject> balances) {
		String response = "";
		for (int i = 0; i < balances.size(); i++) {
			response += dashTile(balances.get(i).getCategory(), balances.get(i).getBalance());
		}
		return response;
	}

}
