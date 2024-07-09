<%@ page import="sql.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
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
	response.sendRedirect("../index.jsp?message=Disconnected from Server");
}

String date = (String)request.getParameter("date");
String categoryFrom = (String)request.getParameter("categoryFrom");
String categoryTo = (String)request.getParameter("categoryTo");
String amount = (String)request.getParameter("amount");

String result = TransController.getInstance().transfer(date, categoryFrom, categoryTo, amount);
response.sendRedirect("addTransfer.jsp?message=" + result);
%>
</head>
<body>

</body>
</html>