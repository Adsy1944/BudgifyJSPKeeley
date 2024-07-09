<%@ page import="controller.TransController" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Budgify - Loading</title>
<%
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../index.jsp?message=Disconnected from Server");
}

String date = (String) request.getParameter("date");
System.out.println("Date: " + date);
String category = (String) request.getParameter("category");
System.out.println("Category: " + category);
String description = (String) request.getParameter("description");
System.out.println("Description: " + description);
String amount = (String) request.getParameter("amount");
System.out.println("Amount: " + amount);

String result = TransController.getInstance().submitTransaction(date, category, description, amount);
response.sendRedirect("addTransaction.jsp?message=" + result);

%>
</head>
<body>
<%=result %>
</body>
</html>