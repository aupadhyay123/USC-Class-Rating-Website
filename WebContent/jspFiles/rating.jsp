<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "LogReg.User" %>
<%@ page import = "ReviewClass.*" %>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "com.google.gson.Gson" %>

<%
	User current = (User)session.getAttribute("loggedInUser");

	Gson gson = new Gson();
	
	SCholasticClass currClass = null;
	String coursecode = null; /* (request.getParameter("coursecode") != null) ? (String)(request.getParameter("coursecode")) : ""; */
	String teacher = null; /* (request.getParameter("teacher") != null) ? (String)(request.getParameter("teacher")) : ""; */
	String name = null; /* (request.getParameter("name") != null) ? (String)(request.getParameter("name")) : ""; */
	String term = (session.getAttribute("term") != null) ? (String)session.getAttribute("term") : "";
	
	
	System.out.println("Term: " + term);
	
	if(request.getParameter("class") != null){ 
		currClass = gson.fromJson(request.getParameter("class"), SCholasticClass.class);
		/* coursecode = currClass.coursecode;
		teacher = currClass. */
	}
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
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
		<link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet">
	
		<script type="text/javascript" src="terms.js"></script>
		<script type="text/javascript" src="departments.js"></script>

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
			 .btn-success{
			 	width:48%;
			 	height: 20%;
			 	display: inline-block;
			 	float:right;
			 	margin-left: 10px;
			 }
			 .btn-danger{
			 	width:48%;
			 	height: 20%;
			 	display: inline-block;
			 	float:right;
			 	margin-left: 10px;
			 }

		</style>
		
		<script type="text/javascript">
			
			function populateTermDropList(){
				let data = document.getElementById('termList');
				data.length = 0;
				let defaultOption = document.createElement('option');
				defaultOption.text = 'Choose Term';
				data.add(defaultOption);
				data.selectedIndex = 0;
				
	    		var x = JSON.stringify(terms);
				let userdata = JSON.parse(x);

				for(let i = 0; i < Object.keys(userdata.term).length; i++){
					  let option = document.createElement('option');
				      let text = userdata.term[i]; 
				      
				      let termYear = text.substr(0,4); 
				      let termT = text.substr(4,5);
	
				      option.value = text; 
				    
				      if(termT == 1){
				      	option.text =  " Spring " + termYear; 
				      }
				      if(termT == 2){
				      	option.text = " Summer " + termYear; 
				      }
				      if(termT == 3){
				      	option.text = " Fall " + termYear; 
				      }	 
				      data.add(option); 
				}	
			}
			
			function populateDepartments(){
				let data = document.getElementById('majorList');
				data.length = 0;
				let defaultOption = document.createElement('option');
				defaultOption.text = 'Choose Department';
				data.add(defaultOption);
				data.selectedIndex = 0;
        		var x = JSON.stringify(departments);
				let userdata = JSON.parse(x);
				
				for(let i = 0; i < Object.keys(userdata.departments).length; i++){
					let departmentData = userdata.departments[i].department; 
						if(Array.isArray(departmentData) == true) {
						  	for(let j = 0; j < Object.keys(departmentData).length; j++){
					      		let option = document.createElement('option');
					      		option.value = departmentData[j].code; 
					      		option.text = departmentData[j].name + "(" + departmentData[j].code + ")";
					      		data.add(option); 
						  	}
						}
						else if(departmentData != undefined){
							let option = document.createElement('option');
							option.value = departmentData.code;
							option.text = departmentData.name + "(" + departmentData.code + ")";
				      		data.add(option);
						}
					}	
			}
			
			window.onload = function () {
				//populateDepartments();
				//populateTermDropList();
				if(<%=currClass != null%>) {
					document.getElementById("code").value = '<%=currClass.coursecode%>' ;
					document.getElementById("teach").value = '<%=currClass.teacher%>';
					document.getElementById("course").value = '<%=currClass.name%>';
					console.log(document.getElementById("course").value );
					console.log(document.getElementById("teach").value );
					console.log(document.getElementById("code").value );
				}
			};
			
			function chosen(id1, id2){
				if(id1.value === "Choose Term" || id2.value === "Choose Department") {
					document.getElementById("revealmenu").style.display = "none";
					return;
				}
				console.log(id1);
				document.getElementById("revealmenu").style.display = "inline-block";
			}
			
			function validateRating(){
				var xhttp = new XMLHttpRequest();
				var temp = <%=term%>
				xhttp.open("GET","../SubmitReviewServlet?rating=" + document.getElementById("rate").value + "&teacher=" + document.getElementById("teach").value + "&coursecode=" 
						+ document.getElementById("code").value + "&term=" + temp + "&review=" + document.getElementById("review").value + "&name=" + document.getElementById("course").value, false);

				xhttp.send();
				
				
				if(xhttp.responseText.trim() != "success") {
					
					alert(xhttp.responseText);
					return false;
				}
				return true;
			
			}
			
		</script>
		
	</head>
	<body>
		<div class="container-fluid homeContainer">

			<div class="row header">
				<div class="logo">
					<% if(current == null) {%>
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
				<% } else {%>
				<div class="loginLink">
					<a href="login.jsp">Login</a>
				</div>
				<div class="regLink">
					<a href="register.jsp">Register</a>
				</div>
				<% } %>
			</div>
			<div class="row profile">
				<div class="profileStuff">
					<div class="col profileData">
							
              			<form action="profilePage.jsp" method="GET" onsubmit=" return validateRating();">
							<!-- <span class="input-group-btn" onchange="chosen(termList, majorList)">
							
								<button type="submit" class="btn btn-danger btn-block">Term</button>
								
								<select name="term" id="termList" class="btn btn-danger btn-block" >
								</select>
								
							</span>
							<span class="input-group-btn" onchange="chosen(termList, majorList)">
							
								<button type="submit" class="btn btn-danger btn-block">Department</button>

 								<select name="major" id="majorList" class="btn btn-danger btn-block">
								</select>
								
							</span> -->
							
							<span class="input-group-btn" id="revealmenu" style="display:block">
								<input type="text" id="code" name="coursecode" placeholder="Three Digit Course Code (Ex: 123)" required oninvalid="this.setCustomValidity('Course code cannot be left blank!')" oninput="this.setCustomValidity('')">
								<input type="text" id="teach" name="teacher" placeholder="Name of Instructor" required oninvalid="this.setCustomValidity('Instructor name cannot be left blank!')" oninput="this.setCustomValidity('')">
								<input type="text" id="course" name="name" placeholder="Name of Course" required oninvalid="this.setCustomValidity('Course name cannot be left blank!')" oninput="this.setCustomValidity('')">
								<input type="text" id="rate" name="rating" placeholder="Course Rating in range [0.0 --> [5.0]" required oninvalid="this.setCustomValidity('Course rating cannot be left blank!')" oninput="this.setCustomValidity('')"> 
								<input type="text" id="review" name="review" placeholder="Any comments about course and/or instructor">
								<input type="submit" id="sub" name="submit" value="Submit Rating">
							</span>
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>