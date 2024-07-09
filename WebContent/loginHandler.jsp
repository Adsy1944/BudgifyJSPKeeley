<%@ page import="sql.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Budgify - Loading</title>
<script src="js/jquery-3.4.1.js"></script>
<script src="js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
<%
String user = (String) request.getParameter("username");
String pword = (String) request.getParameter("password");
Connection con = SqlConnection.getInstance().userConnection(user, pword); 
if (con != null) {
	session.setAttribute("con", con);
	session.setAttribute("user", user);
	response.sendRedirect("dashboard.jsp");
}
else {
	response.sendRedirect("index.jsp?message=fail");
}
%>
</head>
<body>



</body>
</html>