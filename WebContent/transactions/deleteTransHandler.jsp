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
	response.sendRedirect("../index.jsp?message=Disconnected from Server");
}

String transID = (String)request.getParameter("transID");
String category = (String)request.getParameter("category");

String message = TransController.getInstance().deleteTransaction(transID);

response.sendRedirect("transactionHistory.jsp?message=" + message + "&category=" + category);
%>
</head>
<body>

</body>
</html>