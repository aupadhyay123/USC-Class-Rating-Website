<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "LogReg.User" %>
<%@ page import = "ReviewClass.*" %>
<%@ page import = "java.util.ArrayList"%>
    
<%
	User current = (User)session.getAttribute("loggedInUser");
	String searchby = (String) session.getAttribute("searchby");
	String query = (String) session.getAttribute("query");
%>

<!DOCTYPE html>
<html>
	<head>
		<!-- Meta Tags -->
		<link href="https://fonts.googleapis.com/css?family=Cormorant+Garamond" rel="stylesheet">
		<meta charset="utf-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
		<!--  -->
		<script src="https://code.jquery.com/jquery-3.4.0.min.js" integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg=" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
		<link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet">


		<title>SCholastic</title>
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
    			height: 100%;
			 	width:100%;
			 	flex-direction:column;
			 	padding-right:0px;
			 	padding-left: 0px;
			 	margin:0;	
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
			 .profile{
			 	height:800px;
			 	background-color: #F0F0F0;
			 	background-repeat:no-repeat;
			 	background-image: linear-gradient(0deg,red, white);
			 	flex-direction:column;
			 	display:flex;
			 }
			 #logoImg{
			 	position: absolute;
			 	top:13%;
			 	left:38%;
			 }
			 .header{
			 	background-color: #cc0000;
			 	height:80px;
			 	font-family: 'Amatic SC', cursive;
			 	font-size: 50px;
			 	text-decoration:none;
			 }
			 .logo{
			 	padding-left: 20px;
			 	padding-right: 10px;
			 	
			 }
			 a{
			 	color:white;
			 }
			 .searchBar{
			 	padding-top: 15px;
			 	width:1000px;
			 }
			 .profileStuff{
			 	width:90%;
			 	height:90%;
			 	margin: auto;
			 	border: 2px solid black;
			 	font-family: 'Quicksand', sans-serif;
			 }
			 .profileData{
			 	width:97%;
			 	float: left;
			 	padding-top:30px;
			 	border: 2px solid black;
			 	margin-left:15px;
			 	font-family: 'Quicksand', sans-serif;
			 	margin-top:15px;
			 	height: 95%;
			 }
			 table{
			 	border: 2px solid black;
			 	margin-bottom: 10px;
			 	font-family: 'Quicksand', sans-serif;
			 	width:100px;

			 }
			 th,td{
			 	font-size:30px;
			 	padding-left:30px;
			 	border:1px solid black;
			 }
			 tr{
			 	width:80px;
			 }
			 .class{
			 	padding-top: 40px;
			 }
			 .logOut{
			 	right:2%;
			 }


		</style>
	</head>
	<body>
		<div class="container-fluid homeContainer">

			<div class="row header">
				<div class="logo">
					<% if(current == null) { %>
					<a href="homePage.jsp">SCholastic</a>
					<% } else { %>
					<a href="loggedIn.jsp">SCholastic</a>
					<% } %>
				</div>
				<div class="searchBar">
					<form action="" method="GET" class="col-12">
						<div class="input-group">
							<input type="text"  name="" class="form-control" id="search-id" placeholder="Search...">
							<span class="input-group-btn">
								<button type="submit" class="btn btn-danger btn-block">Search</button>
							</span>
						</div>
				</form>
				</div>
				<% if(current != null) { %>
				<div class="logOut">
					
						<a href="profilePage.jsp">Profile</a>
				</div>
				<% } %>
			</div>
			<div class="row profile">
				<div class="profileStuff">
					<div class="col profileData">
						<div class="class">
							<h3><strong> Search By <%=searchby %>: </strong><%=query%> </h3>
							<h2><strong> Results </strong></h2>
							
							<form action="">
							<table style="width:100%" id="srcontainer">
								<tr>
									<th>Class</th>	<!-- ADD BUTTON LINKED TO PAGE SHOWING ALL REVIEWS FOR CLASS -->
									<th>Course Code</th>
									<th>Professor</th>
									<th>Rating</th>
									<th>New Review?</th>
								</tr>
									<tr id="searchRowTemplate" style="display:none;">
										<td class="className"></td>
										<td class="coursecode"></td>
										<td class="prof"></td>
										<td class="rating"></td>
										<td class="newreview"><a class="newreviewlink">Submit a Review</a></td>
									</tr>
							</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script>
		var results = <%=session.getAttribute("results")%>;	
		console.log(results);
		fillResults();
		
		
		function fillResults(){
			results.forEach(result=>{
				teacher = result.teacher.replace(/\s/g, '');
				teacher = teacher.replace(/,/g, '-');
			  	$("#searchRowTemplate").clone().appendTo("#srcontainer").attr("id", result.coursecode + "-" + teacher);
				$("#"+ result.coursecode + "-" + teacher).css("display", "table-row"); 
				if(result.rated)
					$("#"+ result.coursecode + "-" + teacher).find(".className").html("<a href='classData.jsp?class="+encodeURIComponent(JSON.stringify(result))+"'>"+result.name+"</a>");
				else
					$("#"+ result.coursecode + "-" + teacher).find(".className").html(result.name);
				$("#" + result.coursecode + "-" + teacher).find(".coursecode").html(result.coursecode);
				$("#"+ result.coursecode + "-" + teacher).find(".prof").html(result.teacher);
				$("#"+ result.coursecode + "-" + teacher).find(".rating").html(result.score);
				if('<%=current%>' !== 'null')
					$("#"+ result.coursecode + "-" + teacher).find(".newreviewlink").attr("href","rating.jsp?class="+encodeURIComponent(JSON.stringify(result)));
				else
					$("#"+ result.coursecode + "-" + teacher).find(".newreviewlink").html("Login/Register Required to make Rating");

			});
		}
				
	</script>
</html>