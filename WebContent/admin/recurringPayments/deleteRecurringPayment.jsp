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

String answer = TransController.getInstance().deleteMonthlyPayment(paymentRef);

response.sendRedirect("recurringPayments.jsp?message=" + answer);

%>
</head>
<body>

</body>
</html>