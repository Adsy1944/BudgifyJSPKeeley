<%@ page import="controller.TransController" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Monthly Payment</title>
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
%>
</head>
<body style="background-color: grey; overflow-x: hidden;">
	<nav class="bg-dark">
		<div class="row">
			<div class="col-sm-9">
				<button class="btn btn-dark" onclick="window.location.href='../../dashboard.jsp'"><img src="../../img/budgy-1.png" width="30rem">Budgify</button>
				<span class="text-white">|</span>
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
			<div class="card-body text-center">
				<h5 class="text-danger text-center">
					<%=message %>
				</h5>
				<form action="newRecurringPaymentHandler.jsp">
					<table>
						<tr class="text-center">
							<td>Payment Day</td>
							<td>Payment Description</td>
							<td>Payment Category</td>
							<td>Payment Amount</td>
						</tr>
						<tr>
							<td><input type="number" name="paymentDate" id="paymentDate" class="form-control" required></td>
							<td><input type="text" name="paymentDescription" id="paymentDescription" class="form-control" required></td>
							<td>
								<select name="paymentCategory" id="paymentCategory" class="form-control" required>
									<%=TransController.getInstance().getCategories() %>
								</select>
							</td>
							<td><input type="number" step="0.01" name="paymentAmount" id="paymentAmount" class="form-control" required></td>
							<td><button type="submit" class="btn btn-dark">Save</button>
 						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>