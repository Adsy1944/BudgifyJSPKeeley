<%@ page import="sql.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="controller.TransController" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Recurring Payment</title>
<%
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../../index.jsp?message=Disconnected from Server");
}

String paymentDay = (String) request.getParameter("paymentDate");

System.out.println("Payment Day: " + paymentDay);

String paymentDescription = (String) request.getParameter("paymentDescription");

String paymentCategory = (String) request.getParameter("paymentCategory");

String paymentAmount = (String) request.getParameter("paymentAmount");

String result = TransController.getInstance().addRecurringPayment(paymentDay, paymentCategory, paymentAmount, paymentDescription);

response.sendRedirect("newRecurringPayment.jsp?message=" + result);
%>
</head>
<body>

</body>
</html>