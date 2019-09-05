<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SCholastic</title>
</head>
<body>
	<%
		session.setAttribute("loggedInUser", null);
		session.setAttribute("results", null);
		response.sendRedirect("homePage.jsp");
	%>
</body>
</html>