<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ReviewClass.*"%>
<%@ page import = "com.google.gson.Gson" %>

<%
	Gson gson = new Gson();
	RatedClass currClass = gson.fromJson(request.getParameter("class"), RatedClass.class);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SCHOLASTIC</title>
		<!--  -->
		<link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
		<!--  -->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
		<link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet">
		<style>
			html,body{
				margin: 0px;
			}
			 .navbar{
			 	height:90px;
			 	width:100%;
			 }
			 .homeContainer{
			 	display:flex;
			 	flex-wrap: nowrap;
			 	min-height: 100%;
    			height: 100vh;
			 	width:100%;
			 	flex-direction:column;
			 	padding-right:0px;
			 	padding-left: 0px;
			 	margin:0;	
			 	background-color:#D7D5D5;
			 }
			 .input-group{
			 	width:80%;
			 	top:40%;
			 	left:10%;
			 }
			 #buttonSearch{
			 	display:inline-block;
			 	color:red;
			 }
			 #search-id{
			 	display:inline-block;
			 }
			 .form{
			 	/*background-image: url("usc.jpg");*/
			 	height:800px;
			 	background-color: #F0F0F0;
			 	background-repeat:no-repeat;
			 	background-image: linear-gradient(0deg,white, red);
			 }
			 #logoImg{
			 	position: absolute;
			 	top:13%;
			 	left:38%;
			 	opacity: 3;
			 }
			 .header{
			 	background-color: #cc0000;
			 	height:80px;
			 	font-family: 'Amatic SC', cursive;
			 	font-size: 40px;
			 	text-decoration:none;
			 }
			 .logo{
			 	padding-left: 20px;
			 	padding-right: 10px;
			 	top:1%;
			 	
			 }
			 .loginLink{
			 	position: absolute;
			 	right:12%;
			 	top:1%;
			 }
			 .regLink{
			 	position: absolute;
			 	right:2%;
			 	top:1%;
			 }
			 a{
			 	color:white;
			 }
			 #termList.form-control{
			 	width: 10px; 
			 }
			 .classData{
			 	background-color:black; 
			 	text-align:center;
			 	color:white;
			 	justify-content:center;
			 }
			 #leftImg{
			 	position:absolute;
			 	left:10%;
			 	top:18%;
			 }
			 #rightImg{
			 	position:absolute;
			 	right:10%;
			 	top:18%;
			 }
			 .reviewData{
			 	background-color:grey;
			 }
			 
		</style>
</head>
<body>
		<div class="container-fluid homeContainer">
			<div class="row header">
				<div class="logo">
					<a href="homePage.jsp">SCholastic</a>
				</div>
				<div class="loginLink">
					<a href="login.jsp">Login</a>
				</div>
				<div class="regLink">
					<a href="register.jsp">Register</a>
				</div>
			</div>
			<div class="container-fluid ">
				<div class="row classData">
					<div class="col">
						<img src="http://pluspng.com/img-png/usc-png-about-ilios-287.png" height=100px width=100px id="leftImg">
						<h1 id="className"><%=currClass.name %></h1>
						<h2 id="professor"><%=currClass.teacher %></h2>
						<h2 id="totalRating"><%=currClass.score %></h2>
						<img src="http://pluspng.com/img-png/usc-png-about-ilios-287.png" height=100px width=100px id="rightImg">
						
					</div>
				</div>
				<div class="row reviewData">
					<table id="reviewTable" class="table table-hover">
						  <thead>
						    <tr>
						      <th scope="col">#</th>
						      <th scope="col">userID</th>
						      <th scope="col">Major</th>
						      <th scope="col">Rating</th>
						      <th scope="col">Review</th>
						    </tr>
						  </thead>
						  <tbody>
						  	<%for (int i = 0; i < currClass.reviews.size(); ++i) { %>
						    <tr>
						      <th scope="row"><%=i %></th>
						      <td><%=currClass.reviews.get(i).userid %></td>
						      <td><%=currClass.reviews.get(i).major %> </td>
						      <td><%=currClass.reviews.get(i).rating %>/5.0 </td>
						      <td><%=currClass.reviews.get(i).review %> </td>
						    </tr>
						   	<%}%>
						  </tbody>
						</table>
				</div>
			</div>
		</div>
			
		<script>
			
			function populateDepartment(results){
				var x = document.getElementById("reviewTable");
				for(var i = 0; i < results.reviews.length; i++){
					var row = document.createElement('tr');
					var className = document.createElement('td');
					className.innerHTML = results.reviews[i].userid;
					row.appendChild(className);
					
					var rating = document.createElement('td');
					rating.innerHTML = results.reviews[i].rating;
					row.appendChild(rating);
					
					var review = document.createElement('td');
					review.innerHTML = results.reviews[i].review;
					row.appendChild(review);
					x.appendChild(row);
				}
			}
			
			window.onload = function(){
			var results = JSON.parse(<%=request.getParameter("class")%>);
			console.log(results);
			document.getElementById('className').innerHTML = results.name; 
			document.getElementById('professor').innerHTML = results.professor;
			document.getElementById('totalRating').innerHTML = results.rating;	
			populateDepartment(results);
			};
			
			
			
		</script>
</body>
</html>