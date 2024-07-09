<%@ page import="sql.SqlConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="sql.SqlQueries" %>
<%@ page import="controller.TransController"%>
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

String category = (String) request.getParameter("category");
String budget = SqlQueries.getInstance().getBudget(category);
int savings = TransController.getInstance().getIsSavings(category);
int archive = TransController.getInstance().getIsArchived(category);
System.out.println("Savings: " + savings);
System.out.println("Archive: " + archive);
String message = (String) request.getParameter("message");

String savingsAns = "";

if (savings == 1) {
	savingsAns = "true";
}
else if (savings == 0) {
	savingsAns = "false";
}
else {
	message = "Unable to determine if this is a savings account";
}

String archiveAns = "";
if (archive == 1) {
	archiveAns = "true";
}
else if (archive == 0) {
	archiveAns = "false";
}
else {
	message = "Unable to determine if this account is archived";
}


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
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='budget.jsp'">Budget</button>
			</div>
			<div class="col-sm-3 text-right">
				<button class="justify-right btn btn-dark" onclick="window.location.href='../admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="justify-right btn btn-dark" onclick="window.location.href='../../logoutHandler.jsp'">Log Out</button>
			</div>
		</div>
	</nav>
	<div class="container text-center">
		<div class="card" style="margin: 2rem;">
			<h3 class="card-title">
				Change Category
			</h3>
			<div class="card-body">
				<form action="changeBudgetHandler.jsp">
				<h5 class="text-danger"><%=message %></h5>
					<table>
						<tr>
							<td>Category</td>
							<td>Current Budget</td>
							<td>New Budget</td>
							<td>Savings</td>
							<td>Archived</td>
							
							<td></td>
						</tr>
						<tr>
							<td><span class="form-control"><%=category%></span><input name="category" id="category" value="<%=category%>" hidden="true"></td>
							<td><span class="form-control"><%=budget%></span><input name="budget" id="budget" value="<%=budget%>" hidden="true"></td>
							<td><input class="form-control" type="number" step="0.01" name="amount" id="amount"></td>
							<td><input class="form-control" type="checkbox" id="savings" value="savings" name="savings">
							<td><input class="form-control" type="checkbox" id="archive" value="archive" name="archive">
							<td><button class="btn btn-dark" type="submit">Save</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<script>
	var savings = <%=savings%>
	console.log("savings: " + savings);
	var archive = <%=archive%>
	console.log("archive: " + archive);
	
	document.getElementById('savings').checked = <%=savingsAns%>;
	document.getElementById('archive').checked = <%=archiveAns%>;
	
</script>
</body>
</html>