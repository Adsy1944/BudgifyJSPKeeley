<%@ page import="controller.TransController" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Budgify - Transaction History</title>
<script src="../js/jquery-3.4.1.js"></script>
<script src="../js/bootstrap.min.js"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="../favicon.ico?" type="image/x-icon" />
<%
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../index.jsp?message=Disconnected from Server");
}

String message = (String) request.getParameter("message");
if (message == null) {
	message = "";
}
String category = (String) request.getParameter("category");
System.out.println(category);
ArrayList<String> array = TransController.getInstance().getHistory(category);
String table = "";
for (int i = 0; i < array.size(); i++) {
	table += array.get(i);
}
System.out.println(table);
%>
</head>
<body style="background-color: grey; overflow-x: hidden;">
	<nav class="bg-dark">
		<div class="row">
			<div class="col-sm-9">
				<button class="btn btn-dark" onclick="window.location.href='../dashboard.jsp'"><img src="../img/budgy-1.png" width="30rem">Budgify</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='../dashboard.jsp'">Dashboard</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='transactionHistory.jsp?category=<%=category%>'"><%=category%></button>
			</div>
			<div class="col-sm-3 text-right">
			<button class="justify-right btn btn-dark" onclick="window.location.href='../admin/admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="justify-right btn btn-dark" onclick="window.location.href='../logoutHandler.jsp'">Log Out</button>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="card text-center" style="margin: 2rem;">
		<br/>
			<div class="row">
				<div class="col-sm-5 text-centered">
					<h3 class="card-title text-center">Category<br/><%=category%></h3>
				</div>
				<div class="col-sm-5 text-centered">
					<h3>Balance<br/>£<%=TransController.getInstance().getBalance(category)%></h3>
				</div>
				<div class="col-sm-2">
					<button class="btn btn-lg btn-dark" onclick="window.location.href='addTransaction.jsp?category=<%=category%>'">New</button>
				</div>
			</div>
			
			<div class="card-body text-center">
				<h5 class="text-danger text-center"><%=message %></h5>
				<table class="table table-striped">
					<thead class="thead-light">
						<tr>
							<th scope="col">Date</th>
							<th scope="col">Description</th>
							<th scope="col">Amount</th>
							<th scope="col"></th>
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