<%@ page import="java.sql.Connection" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="controller.TransController" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bugify - Budget</title>
<script src="../../js/jquery-3.4.1.js"></script>
<script src="../../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../css/bootstrap.min.css">
<%
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../../index.jsp?message=Disconnected from Server");
}

String category = (String) request.getParameter("category");
String amount = (String) request.getParameter("amount");
String auto = (String) request.getParameter("auto");
String open = (String) request.getParameter("opening");
String savings = (String) request.getParameter("savings");

System.out.println("savings: " + savings);

String result;

if (savings != null && savings.equals("savings")) {
	result = TransController.getInstance().newCategory(category, amount, auto, 1);
}
else {
	result = TransController.getInstance().newCategory(category, amount, auto, 0);
}

String submit = "";

if (result.equals("Budget Creation Successful")) {
	submit = TransController.getInstance().submitAllowance(category, open);
}
else {
	System.out.println(submit);
}

response.sendRedirect("addBudget.jsp?message=" + result);
%>
</head>
<body>

</body>
</html>