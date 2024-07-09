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
<script src="../js/jquery-3.4.1.js"></script>
<%
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../index.jsp?message=Disconnected from Server");
}

String date = (String) request.getParameter("date");
String category = (String) request.getParameter("category");
String description = (String) request.getParameter("description");
String amount = (String) request.getParameter("amount");

String refund = TransController.getInstance().submitRefund(date, category, description, amount);
response.sendRedirect("addRefund.jsp?message=" + refund);
%>
</head>
<body>
<%=refund %>
</body>
</html>