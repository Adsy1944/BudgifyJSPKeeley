package objects;

public class MonthlyPaymentObject {
	
	private MonthlyPaymentObject instance;
	
	private String category;
	private String paymentDescription;
	private String amount;
	private String dayNumber;
	private String paymentRef;
	
//	Makes an instance of the class available
	public MonthlyPaymentObject getInstance() {
		if (instance == null) {
			instance = new MonthlyPaymentObject();
		}
		return instance;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPaymentDescription() {
		return paymentDescription;
	}

	public void setPaymentDescription(String paymentDescription) {
		this.paymentDescription = paymentDescription;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getDayNumber() {
		return dayNumber;
	}

	public void setDayNumber(String dayNumber) {
		this.dayNumber = dayNumber;
	}

	public String getPaymentRef() {
		return paymentRef;
	}

	public void setPaymentRef(String paymentRef) {
		this.paymentRef = paymentRef;
	}
	
}
