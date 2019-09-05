<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String temp = (String)request.getParameter("registerError");
    System.out.println("suck peen: " + temp);
    String errorMessage = ""; 
    if(temp != null && temp.trim().length() != 0){
        errorMessage = temp; 
    }
    System.out.println(errorMessage);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Register Page</title>
        <link href="https://fonts.googleapis.com/css?family=Cinzel|Dosis" rel="stylesheet">
        
        <link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
        <link href="register.css" rel="stylesheet">
        
    </head>
    <body>
        <div id="particles-js">
            <div class = heading>
                <a href = "homePage.jsp">SCholastic</a>
            </div>
            <div class = "loginLink">
                <a href = "login.jsp">Login</a>
            </div>
            <div class = "registerContainer">
            </div>
            <div class = "accountPic">
                <img src = "http://pluspng.com/img-png/usc-png-about-ilios-287.png" height = 150 width = 150>
            </div>
            <form class = "submitRegister" action = "../RegisterServlet" method = "GET">
                <input class = "registerUsername" id = "registerUsername" type = "text" name = "registerUsername">
                <input class = "registerPassword" id = "registerPassword" type = "password" name = "registerPassword">
                <input class = "confirmPass" id = "confirmPass" type = "password" name = "confirmPass">
                <input class = "registerButton" id = "registerButton" type = "submit" name = "registerButton" value = "Register">
            </form>
            <p class = "uDescription">Username</p>
            <p class = "pDescription">Password</p>
            
            <p class = "confirmDescription">Confirm Password</p>
             <p id = "errorMessage" style="font-size:25px;color:black;"><%= errorMessage %></p>
        </div>
        
        <script src="particles.js"></script>
        <script src="app.js"></script>
        
    </body>
</html>
