<%@ page import="controller.TransController" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="sql.SqlConnection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Monthly Payments</title>
<script src="../../js/jquery-3.4.1.js"></script>
<script src="../../js/bootstrap.min.js"></script>
<link href="../../css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="../../favicon.ico?" type="image/x-icon" />
<%
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../../index.jsp?message=Disconnected from Server");
}

String message = (String)request.getParameter("message");
if (message == null) {
	message = "";
}
String table = TransController.getInstance().getRecurringPayments();
if (table == null) {
	table = "";
}

%>
</head>
<body style="background-color: grey; overflow-x: hidden;">
	<nav class="bg-dark">
		<div class="row">
			<div class="col-sm-9">
				<button class="btn btn-dark" onclick="window.location.href='../../dashboard.jsp'"><img src="../../img/budgy-1.png" width="30rem">Budgify</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href-'../dashboard.jsp'">Dashboard</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='../admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='recurringPayments.jsp'">Monthly Payments</button>
			</div>
			<div class="col-sm-3 text-right">
				<button class="justify-right btn btn-dark" onclick="window.location.href='../admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="justify-right btn btn-dark" onclick="window.location.href='../../logoutHandler.jsp'">Log Out</button>
			</div>
		</div>
	</nav>
	<br/>
	<div class="container">
		<div class="card">
			<h3 class="title text-center">Monthly Payments</h3>
			<div class="card-body text-right">
				<button class="btn btn-lg btn-dark" onclick="window.location.href='monthlyPaymentsHandler.jsp'">Make Monthly Payments</button>
				<button class="btn btn-lg btn-dark" onclick="window.location.href='newRecurringPayment.jsp'">New</button>
				<div class="text-center text-danger">
					<%=message %>
				</div>
				<table class="text-center">
					<thead>
						<tr>
							<th>Payment Day</th>
							<th>Category</th>
							<th>Payment Description</th>
							<th>Payment Amount</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<%=table %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>