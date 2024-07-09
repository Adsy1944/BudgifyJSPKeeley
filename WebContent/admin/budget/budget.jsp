<%@ page import="java.util.ArrayList" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="sql.SqlQueries" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="controller.TransController" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Budgify - Budget</title>
<script src="../../js/jquery-3.4.1.js"></script>
<script src="../../js/bootstrap.min.js"></script>
<link href="../../css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="../../favicon.ico?" type="image/x-icon" />
<%
String user = (String) session.getAttribute("user");
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../../index.jsp?message=Disconnected from Server");
}

String table = "";
ArrayList<String> array = SqlQueries.getInstance().getBudgets();
for (int i = 0; i < array.size(); i++) {
	table += array.get(i);
}

String total = TransController.getInstance().getTotalBudget();
System.out.println("Total: " + total);

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
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='budget.jsp'">Budget</button>
			</div>
			<div class="col-sm-3 text-right">
				<button class="justify-right btn btn-dark" onclick="window.location.href='../admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="justify-right btn btn-dark" onclick="window.location.href='../logoutHandler.jsp'">Log Out</button>
			</div>
		</div>
	</nav>
	<div class="container text-center">
		<div class="card" style="margin: 2rem;">
		<br/>
			<h3 class="card-title">
				Budget
				<br/>
				£<%=total%>
			</h3>
			<div class="card-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Category</th>
							<th>Budget</th>
							<th>Savings</th>
							<th>Archived</th>
							<th><button class="btn btn-sm btn-dark" onclick="window.location.href='addBudget.jsp'">New</button></th>
						</tr>
					</thead>
					<tbody>
						<%=table%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>