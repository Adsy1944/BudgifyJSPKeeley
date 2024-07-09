<%@ page import="controller.TransController" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../../index.jsp?message=Disconnected from Server");
}

String category = (String) request.getParameter("category");
String amount = (String) request.getParameter("amount");
String savings = (String) request.getParameter("savings");
String archive = (String) request.getParameter("archive");

if (savings == null) {
	savings = "0";
}
else {
	savings = "1";
}

if (archive == null) { 
	archive = "0";
}
else {
	archive = "1";
}

System.out.println("Submitted Savings: " + savings);
System.out.println("Submitted Archive: " + archive);

String result = TransController.getInstance().changeBudget(category, amount, savings, archive);

response.sendRedirect("changeBudget.jsp?message=" + result + "&category=" + category);
%>
</head>
<body>

</body>
</html>