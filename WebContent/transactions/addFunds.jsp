<%@ page import="java.sql.Connection" %>
<%@ page import="controller.TransController" %>
<%@ page import="sql.SqlConnection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Budgify - Refund</title>
<script src="../js/jquery-3.4.1"></script>
<script src="../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="shortcut icon" href="../favicon.ico?" type="image/x-icon" />
<%
Connection con = SqlConnection.getInstance().getConnection();
if (con == null) {
	session.invalidate();
	response.sendRedirect("../index.jsp?message=Disconnected from Server");
}

String category = (String) request.getParameter("category");
String message = (String) request.getParameter("message");
if (message == null) {
	message = "";
}
%>
</head>
<body style="background-color: grey; overflow-x: hidden;">
	<nav class="bg-dark">
		<div class="row">
			<div class="col-sm-10">
				<button class="btn btn-dark" onclick="window.location.href='../dashboard.jsp'"><img src="../img/budgy-1.png" width="30rem">Budgify</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='../dashboard.jsp'">Dashboard</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='addFunds.jsp'">Add Funds</button>
			</div>
			<div class="col-sm-2 text-right">
				<button class="justify-right btn btn-dark" onclick="window.location.href='../admin/admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="justify-right btn btn-dark" onclick="window.location.href='../logoutHandler.jsp'">Log Out</button>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="card" style="margin: 2rem;">
			<h3 class="card-title text-center">Add Funds</h3>
			<span class="text-center text-danger"><%=message%></span>
			<div class="card-body">
				<form action="addFundsHandler.jsp">
					<table>
						<tr>
							<td><label>Date</label></td>
							<td><label>Category</label></td>
							<td><label>Description</label></td>
							<td><label>Amount</label></td>
						</tr>
						<tr>
							<td><input class="form-control" type="date" name="date" id="date" required></td>
							<td>
								<select class="form-control" name="category" id="category">
									<%=TransController.getInstance().getCategories() %>
								</select>
							</td>
							<td><input class="form-control" type="text" name="description" id="description" required></td>
							<td><input class="form-control" type="number" step="0.01" name="amount" id="amount" required ></td>
							<td><button class="btn btn-lg btn-dark" type="submit">Submit</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>