<%@ page import="java.sql.Connection" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="controller.TransController" %>
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

String paymentRef = (String) request.getParameter("paymentRef");

String paymentAmount = (String) request.getParameter("paymentAmount");

String paymentCategory = (String) request.getParameter("paymentDay");

String paymentDescription = (String) request.getParameter("paymentDescription");

String paymentDay = (String) request.getParameter("paymentDay");

String answer = TransController.getInstance().editMonthlyPayment(paymentRef, paymentAmount, paymentCategory, paymentDay, paymentDescription);

response.sendRedirect("recurringPayments.jsp?message=" + answer);

%>
</head>
<body>

</body>
</html>