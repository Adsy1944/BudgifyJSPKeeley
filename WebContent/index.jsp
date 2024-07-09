<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="Author" content="Adam Crofts">
<script src="js/jquery-3.4.1.js"></script>
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="favicon.ico?" type="image/x-icon" />
<title>Budgify - Login</title>
<%
String message = (String) request.getParameter("message");
if (message == null) {
	message = "";
}
else if (message.equals("fail")) {
	message = "Incorrect Login";
}
else if (message.equals("logout")) {
	message = "Logged Out";
}
%>
</head>
<body style="background-color: grey; overflow-x: hidden;">
<nav class="bg-dark">
	<button class="btn btn-dark" onclick="window.location.href='index.jsp'">Budgify</button>
	<span class="text-white">|</span>
</nav>
	<br/>
	<div class="container">
		<div class="row text-center">
			<img src="img/budgy-1.png" alt="logo" class="img-fluid mx-auto">
		</div>
		<div class="row justify-content-center">
			<form action="loginHandler.jsp">
				<table>
					<tr>
						<td>
							<input type="text" name="username" id="username" placeholder="Username" class="form-control">
						</td>
					</tr>
					<tr>
						<td>
							<input type="password" name="password" id="password" placeholder="Password" class="form-control">
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center">
						<br/>
							<button class="btn btn-lg btn-dark" type="submit" style="width: 100%;">Login</button>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center">
							<h5 class="text-center text-danger bold"><%=message%></h5>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>