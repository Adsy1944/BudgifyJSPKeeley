<%@ page import="java.sql.Connection" %>
<%@ page import="sql.SqlConnection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Budgify - Admin</title>
<script src="../js/jquery-3.4.1.js"></script>
<script src="../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="shortcut icon" href="../favicon.ico?" type="image/x-icon" />
<%
String user = (String) session.getAttribute("user");
String message = request.getParameter("message");
if (message == null) {
	message = "";
}
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../index.jsp?message=Disconnected from Server");
}
%>
</head>
<body style="background: grey; overflow-x: hidden;">
	<nav class="bg-dark">
		<div class="row">
			<div class="col-sm-9">
				<button class="btn btn-dark" onclick="window.location.href='../dashboard.jsp'"><img src="../img/budgy-1.png" width="30rem">Budgify</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href-'../dashboard.jsp'">Dashboard</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='admin.jsp'">Admin</button>
			</div>
			<div class="col-sm-3 text-right">
				<button class="justify-right btn btn-dark" onclick="window.location.href='admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="justify-right btn btn-dark" onclick="window.location.href='../logoutHandler.jsp'">Log Out</button>
			</div>
		</div>
	</nav>
	<div class="container text-center">
		<div class="card" style="margin: 2rem;">
		<h3 class="card-title">
			Admin
		</h3>
			<button class="btn btn-lg btn-dark" onclick="window.location.href='budget/budget.jsp'">Budget</button>
			<br/>
			<button class="btn btn-lg btn-dark" onclick="window.location.href='recurringPayments/recurringPayments.jsp'">Monthly Payments</button>
			<br/>
			<button class="btn btn-lg btn-dark" onclick="window.location.href='newMonth/newMonth.jsp'">Start New Month</button>
			<br/>
			
			<button class="btn btn-lg btn-dark" onclick="window.location.href='about.jsp'">About</button>
			<h5 class="text-danger"><%=message%></h5>
		</div>
	</div>
</body>
</html>