package tools;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DateFormat;

public class DateTool {
	
	private static DateTool instance;
	private Date date;
	
	public static DateTool getInstance() {
		if (instance == null) {
			instance = new DateTool();
		}
		return instance;
	}
	
	public String dateToday() {
		date = new Date();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(date);
	}
	
	public String getDate() {
		date = new Date();
		DateFormat format = new SimpleDateFormat("yyyy-MM");
		return format.format(date);
	}
	
}
