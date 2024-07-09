<%@ page import="java.sql.Connection" %>
<%@ page import="sql.SqlConnection" %>
<%@ page import="objects.MonthlyPaymentObject" %>
<%@ page import="controller.TransController" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Recurring Payment</title>
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

String message = (String) request.getParameter("message");
if (message == null) {
	message = "";
}

String paymentRef = (String) request.getParameter("paymentRef");

MonthlyPaymentObject paymentObj = TransController.getInstance().getMonthlyPayment(paymentRef);
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
				<form action="editRecurringPaymentHandler.jsp">
					<table class="table">
						<thead>
							<tr class="text-center">
								<th>Payment Reference</th>
								<th>Payment Day</th>
								<th>Category</th>
								<th>Description</th>
								<th>Amount</th>
							</tr>
						</thead>
						<tbody>
							<tr class="text-center">
								<td><%=paymentObj.getPaymentRef() %></td>
								<td><%=paymentObj.getDayNumber() %></td>
								<td><%=paymentObj.getCategory() %></td>
								<td><%=paymentObj.getPaymentDescription() %></td>
								<td><%=paymentObj.getAmount() %></td>
							</tr>
							<tr>
								<td><input class="form-control" id="paymentRef" name="paymentRef" type="number" value="<%=paymentObj.getPaymentRef() %>" disabled></td>
								<td><input class="form-control" id="paymentDay" name="paymentDay" type="number" value="<%=paymentObj.getDayNumber()%>"></td>
								<td>
									<select class="form-control" id="paymentCategory" name="paymentCategory" value="<%=paymentObj.getCategory()%>"><%=TransController.getInstance().getCategories() %></select>
								</td>
								<td><input class="form-control" id="paymentDescription" name="paymentDescription" type="text" value="<%=paymentObj.getPaymentDescription()%>"></td>
								<td><input class="form-control" id="paymentAmount" name="paymentAmount" type="number" step="0.01" value="<%=paymentObj.getAmount()%>"></td>
								<td><button class="btn btn-dark" type="submit">Save</button></td>
							</tr>
						</tbody>
					</table>
				</form>
				<form action="deleteRecurringPayment.jsp">
					<input name="paymentRef" id="paymentRef" value="<%=paymentObj.getPaymentRef() %>" hidden>
					<button class="btn btn-dark" type="submit">Delete Payment</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>