<%@ page import="java.sql.Connection" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="sql.SqlQueries" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Budgify - Budget</title>
<script src="../../js/jquery-3.4.1.js"></script>
<script src="../../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../css/bootstrap.min.css">
<link rel="shortcut icon" href="../../favicon.ico?" type="image/x-icon" />
<%
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../../index.jsp?message=Disconnected from Server");
}

String message = request.getParameter("message");
if (message == null) {
	message = "";
}
%>
</head>
<body style="background-color: grey; overflow-x: hidden;">
	<nav class="bg-dark">
		<div class="row">
			<div class="col-sm-9">
				<button class="btn btn-dark" onclick="window.location.href='../../dashboard.jsp'"><img src="../../img/budgy-1.png" width="30rem">Budgify</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='../../dashboard.jsp'">Dashboard</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='../admin.jsp'">Admin</button>
			</div>
			<div class="col-sm-3 text-right">
				<button class="justify-right btn btn-dark" onclick="window.location.href='../admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="justify-right btn btn-dark" onclick="window.location.href='../../logoutHandler.jsp'">Log Out</button>
			</div>
		</div>
	</nav>
	<br/>
	<div class="container text-center">
		<div class="card" 	>
			<h3 class="card-title">
				Add Category
			</h3>
			<div class="card-body">
			<form action="addBudgetHandler.jsp">
			<h5 class="text-danger"><%=message %></h5>
				<table class="table">
					<tr>
						<td>Category</td>
						<td>Allowance</td>
						<td>Starting Balance</td>
						<td>Savings</td>
						<td></td>
					</tr>
					<tr>
						<td><input class="form form-control" type="text" id="category" name="category"></td>
						<td><input class="form form-control" type="number" step="0.01" id="amount" name="amount"></td>
						<td><input class="form form-control" type="number" step="0.01" id="opening" name="opening"></td>
						<td><input class="form form-control" type="checkbox" id="savings" name="savings" value="savings"></td>
						<td><button class="btn btn-dark" type="submit">Save</button></td>
					</tr>
				</table>
			</form>
			</div>
		</div>
	</div>
</body>
</html>