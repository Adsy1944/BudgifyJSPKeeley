<%@ page import="sql.SqlConnection"%>
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
	response.sendRedirect("index.jsp?message=Disconnected from Server");
}
else {
	SqlConnection.getInstance().closeConnection();
	session.invalidate();
	response.sendRedirect("index.jsp?message=logout");
}
%>
</head>
<body>

</body>
</html>