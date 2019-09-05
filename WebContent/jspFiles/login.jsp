<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	
	String temp = request.getParameter("loginError");
	String errorMessage = "";
	if(temp != null && temp.trim().length() != 0) {
		errorMessage = temp;
	} 
%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login Page</title>
		<link rel = "stylesheet" type = "text/css" href = "login.css">
		<link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Cinzel" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Cinzel|Dosis" rel="stylesheet">
	</head>
	<body>
		<div id="particles-js">
			<div class = "heading">
				<a href = "homePage.jsp">SCholastic</a>
			</div>
			<div class = "registerLink">
				<a href = "register.jsp">Register</a>
			</div>
			<div class = "loginContainer">
			</div>
			<div class = "accountPic">
				<img src = "http://pluspng.com/img-png/usc-png-about-ilios-287.png" height = 150 width = 150>
			</div>
			<form class = "submitLogin" action = "../LoginServlet" method = "GET">
				<input class = "loginUsername" id = "loginUsername" type = "text" name = "loginUsername">
				<input class = "loginPassword" id = "loginPassword" type = "password" name = "loginPassword">
				<input class = "loginButton" id = "loginButton" type = "submit" name = "loginButton" value = "Login">
			</form>
			<p class = "uDescription">Username</p>
			<p class = "pDescription">Password</p>
			<p id = "errorMessage"><%= errorMessage %></p> 
		</div>
		<script src="particles.js"></script>
		<script src="app.js"></script>
	
	</body>
</html>