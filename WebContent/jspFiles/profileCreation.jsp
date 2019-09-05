<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//String errorMessage = (request.getAttribute("profileError") != null) ? (String) request.getAttribute("profileError") : "";
	String temp = (String)request.getParameter("profileError");

	String errorMessage = ""; 
	if(temp != null && temp.trim().length() != 0){
		errorMessage = temp; 
	}
	System.out.println(errorMessage);
	//String errorMessage = "";
	//String temp = (String)request.getParameter("profileError");

	
	
	String username = (String) request.getAttribute("registerUsername");
	String password = (String) request.getAttribute("registerPassword");
	String confirm = (String) request.getAttribute("confirmPass");
	System.out.println("info from reg: " + username + ", " + password + ", and " + confirm);
	
	
	
	/* request.setAttribute("registerUsername",username);
	request.setAttribute("registerPassword",password);
	request.setAttribute("confirmPass",confirm); */
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Profile Creation Page</title>
		<link rel = "stylesheet" type = "text/css" href = "profileCreation.css">
		<link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Cinzel|Dosis" rel="stylesheet">
	</head>
	<body>
		<div class = "heading">
			<a href = "homePage.jsp">SCholastic</a>
		</div>
		<div class = "logOutLink">
			<a href = "homePage.jsp">Log Out</a>
		</div>
		<div id="particles-js">
		<div class = "credentialContainer">
		</div>
		<div class = "accountPic">
			<img src = "http://pluspng.com/img-png/usc-png-about-ilios-287.png" height = 150 width = 150>
		</div>
		<form class = "submitCredentials" action = "../ProfileCreation" method = "GET">
			<input type="text" name="registerUsername" value="<%=username %> " style="display: none"/>
			<input type="text" name="registerPassword" value="<%=password %> " style="display: none"/>
			<input type="text" name="confirmPass" value="<%=confirm %> " style="display: none"/>
			
			<input class = "credentialName" id = "credentialName" type = "text" name = "credentialName">
			<input class = "credentialEmail" id = "credentialEmail" type = "email" name = "credentialEmail">
			<input class = "credentialUniversity" id = "credentialUniversity" type = "text" name = "credentialUniversity">
			<input class = "enterMajor" id = "enterMajor" type = "text" name = "major">
			<input class = "submitButton" id = "submitButton" type = "submit" name = "submitButton" value = "Submit">
		</form>
		<p class = "uDescription">Full Name</p>
		<p class = "eDescription">Email Address</p>
		<p class = "univDescription">University</p>
		<p class = "majorDescription">Major</p>
		<p id = "errorMessage"><%= errorMessage %></p> 
		</div>
				
		<script src="particles.js"></script>
		<script src="app.js"></script>
	</body>
</html>