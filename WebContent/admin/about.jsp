
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>About</title>
<script src="../js/jquery-3.4.1.js"></script>
<script src="../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="shortcut icon" href="../favicon.ico?" type="image/x-icon" />
</head>
<body style="background: grey; overflow-x: hidden;">
	<nav class="bg-dark">
		<div class="row">
			<div class="col-sm-9">
				<button class="btn btn-dark" onclick="window.location.href='../dashboard.jsp'"><img src="../img/budgy-1.png" width="30rem">Budgify</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href-'../dashboard.jsp'">Dashboard</button>
				<span class="text-white">|</span>
				<button class="btn btn-dark" onclick="window.location.href='admin.jsp'">Admin</button>
			</div>
			<div class="col-sm-3 text-right">
				<button class="justify-right btn btn-dark" onclick="window.location.href='admin.jsp'">Admin</button>
				<span class="text-white">|</span>
				<button class="justify-right btn btn-dark" onclick="window.location.href='../logoutHandler.jsp'">Log Out</button>
			</div>
		</div>
	</nav>
	<div class="container text-center">
		<div class="card" style="margin: 2rem;">
			<h3 class="card-title">
				Admin
			</h3>
			<div class="text-center">
				<p>
					Version: 2.2<br/>
					<br/>
					Release Date: 24/10/2020<br/>
					<br/>
					Recent Changes:
					<br/>
					- Introduction of regular monthly payments that can be set up and triggered from the Admin menu.<br/>
					- Introduction of Favicon to provide better icons.<br/>
					- Introduction of about section to show version information.<br/>
					- Reorganisation of internal file structure to better organise site.<br/>
					- All Java calls now run through a controller package/class to reduce exposure of actual methods.<br/>
				</p>
			</div>
		</div>
	</div>
</body>
</html>