package objects;

public class BalanceObject {
	
	private String category;
	private String balance;
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}
	
	public BalanceObject(String category, String balance) {
		this.category = category;
		this.balance = balance;
	}
	
	public BalanceObject() {
	}

}
