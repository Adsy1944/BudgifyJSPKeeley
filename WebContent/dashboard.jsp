<%@ page import="java.sql.Connection" %>
<%@ page import="sql.SqlConnection" %> 
<%@ page import="sql.SqlQueries" %>
<%@ page import="pageBuilder.DashboardBuilder" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Budgify - Dashboard</title>
<script src="js/jquery-3.4.1.js"></script>
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="favicon.ico?" type="image/x-icon" />
<%
String user = (String) session.getAttribute("user");
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("index.jsp?message=Disconnected from Server");
}
%>
</head>
<body style="background-color: grey; overflow-x: hidden;">
	<nav class="bg-dark">
		<div class="row">
			<div class="col-sm-9">
				<button class="btn btn-dark" onclick="window.location.href='dashboard.jsp'"><img src="img/budgy-1.png" width="30rem">Budgify</button>
				<span class="text-white">|</span>
			</div>
			<div class="col-sm-3 text-right">
				<button class="justify-right btn btn-dark" onclick="window.location.href='admin/admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="justify-right btn btn-dark" onclick="window.location.href='logoutHandler.jsp'">Log Out</button>
			</div>
		</div>
	</nav>
	<div class="container text-center">
		<div class="card" style="margin: 1rem;" >
			<br/>
			<h3 class="card-title" onclick="window.location.href='transactions/allHistory.jsp'">
				Total Funds Available
				<br/>
				£<%=SqlQueries.getInstance().getTotal()%>
			</h3>
			<div class="card-body" >
				<button class="btn btn-dark" onclick="window.location.href='transactions/addTransaction.jsp'">New Transaction</button>
				<button class="btn btn-dark" onclick="window.location.href='transactions/addRefund.jsp'">New Refund</button>
				<button class="btn btn-dark" onclick="window.location.href='transactions/addFunds.jsp'">Add Funds</button>
				<button class="btn btn-dark" onclick="window.location.href='transactions/addTransfer.jsp'">Transfer Funds</button>
			</div>
		</div>
	</div>
	<div class="container text-center">
		<div class="row">
			<h3>Monthly Budget</h3>
		</div>
		<div class="row">
			<%=DashboardBuilder.getInstance().getTiles(SqlQueries.getInstance().getBudgetBalances())%>
		</div>
		<div class="row">
			<hr size="8" width="90%" color="dark-grey">	
		</div>
		<div class="row">
			<h3>Other Pots</h3>
		</div>
		<div class="row">
			<%=DashboardBuilder.getInstance().getTiles(SqlQueries.getInstance().getSavingsBalances())%>
		</div>
		<div class="row">
			<hr size="8" width="90%" color="dark-grey">
		</div>
		<div class="row">
			<h3>Archived</h3>
		</div>
		<div class="row">
			<%=DashboardBuilder.getInstance().getTiles(SqlQueries.getInstance().getArchiveBalances())%>
		</div>
	</div>
</body>
</html>