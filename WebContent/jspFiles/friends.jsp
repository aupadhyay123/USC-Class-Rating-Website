<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "LogReg.User" %>
<%@ page import = "LogReg.UserReview" %>
<%@ page import = "LogReg.ProfileServlet" %>
<%@ page import = "com.google.gson.Gson" %>
<%
	Gson gson = new Gson();
	User user = gson.fromJson(request.getParameter("profile"), User.class);
	System.out.println(request.getParameter("profile"));
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
			 	font-family: 'Quicksand', sans-serif;

			 }
			 .friends{
			 	width: 40%;
			 	padding-top: 80px;
			 	float:right;
			 	border: 2px solid black;
			 	margin-right:15px;
			 	font-family: 'Quicksand', sans-serif;
			 	height: 90%;
			 	margin-top:15px;
			 }
			 .profileData{
			 	width:40%;
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
			 .name{
			 	text-align:center;
			 	
			 }


		</style>
		<script>
			function getName(results){
				var x = document.getElementById('userName');
				x.innerHTML = results.name; 
				console.log(results.name); 
				var y = document.getElementById('userMajor');
				y.innerHTML = results.major;
			}
			function populateTable(results){
				var x = document.getElementById('ratingTable');
				for(let i = 0; i < results.reviews.length; i++){
				   	var row  = document.createElement('tr');   
					var className = document.createElement('td');
					className.innerHTML = results.reviews[i].className; 
					row.appendChild(className);
					var classRating = document.createElement('td');
					classRating.innerHTML = results.reviews[i].rating;
					row.appendChild(classRating);
					var classReview = document.createElement('td');
					classReview.innerHTML = results.reviews[i].reviewString; 
					row.appendChild(classReview);
					x.appendChild(row);
				}
			}
			window.onload = function () {
				var results = <%=request.getParameter("profile")%>;
				console.log(results);
				getName(results);
				//populateTable(results); 
			};
			
		</script>
	</head>
	<body>
		<div class="container-fluid homeContainer">
<%-- 
			<div class="row header">
				<div class="logo">
					<a href="loggedIn.jsp">SCholastic</a>
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
				<div class="logOut">
					<a href="profilePage.jsp">Profile</a>		<!--  take to logout JSP then to home page JSP-->
				</div>
			</div>
			<div class="row profile">
				<div class="profileStuff">
					<div class="col profileData">
						<div class="name">
						<h1 id="userName"> <strong></strong></h1>
							<h2 id="userMajor"> <strong>Major: </strong></h2> 
						</div>
						<div class="class">
							<h2><strong>Your Reviewed Classes</strong></h2>
							<table id="ratingTable" style="width:100%">
								<thead>
	                            	<tr>
	                                   <th>Class</th>
	                                   <th>Rating</th>
	                                   <th>Review</th>
	                              	</tr>
	                         	</thead>
	                            <tbody>
	                           <%for (UserReview j : user.reviews) { %>
	                               <tr>
	                                   <td><%= j.className%></td>
	                                   <td><%= j.rating%></td>
	                                   <td><%= j.reviewString%></td>
	                               </tr>
	                           <% } %>
	                           </tbody>
							
							</table>
						</div>
					</div>
				</div>
			</div>
		</div> --%>
		<div class="container-fluid homeContainer">
            <div class="row header">
                <div class="logo">
                    <a href="loggedIn.jsp">SCholastic</a>
                    
                </div>
                
                <div class="searchBar">
                    <form action="friendsList.jsp" method="GET" class="col-12" onsubmit = "return validateFriend();">
                        <div class="input-group">
                            <input type="text"  name="receivingUser" class="form-control" id="search-id" placeholder="Search for friends..." required oninvalid="this.setCustomValidity('Future friend cannot be left blank!')" oninput="this.setCustomValidity('')">
                            <span class="input-group-btn">
                                <button type="submit" class="btn btn-danger btn-block">Search</button>
                            </span>
                        </div>
                	</form>
                </div>
                    <button type="button" class="btn btn-default btn-lg friendBtn" onclick = "showPending()">
                      <i class="glyphicon glyphicon-user" aria-hidden="true"></i>
                       <span class="badge">3</span>
                      </button>
                <div class="logOut">
                    <a href="logOut.jsp">Log Out</a>        <!--  take to logout JSP then to home page JSP-->
                </div>
            </div>
<%--             <div id = "displayPending" onclick = "hidePending()">
            	<table class = "table table-hover pendingFriends">
            		<thead>
                       <tr>
	                        <th>Pending Friends</th>
	                        <th>Accept</th>
	                        <th>Decline</th>
                        </tr>
                    </thead>
                    	<tbody>
                    	<% if(current.pendingFriends!=null)
                    	for(friend i : current.pendingFriends) {%>
	                        <tr>
	                           <td><%=i.name%></td>
	                           <form action="profilePage.jsp" method="GET" onsubmit="return acceptRequest(<%=i.friendID %>);">
	                           <td><button class = "btn btn-success acceptFriend" type = "button" onclick="Submit">Accept</button> </td>
	                           </form>
	                           <form action="profilePage.jsp" method="GET" onsubmit="return declineRequest(<%=i.friendID %>);">
	                           <td><button class = "btn btn-danger rejectFriend" type = "button" onclick="Submit">Deny</button> </td>
	                           </form>
	                        </tr>
                        <%} %>
                     </tbody>
            	</table></div> --%>
            <div class="row profile">
                <div class="profileStuff">
                    <div class="row">
<%--                             --<h1> <strong><%= current.name %></strong></h1>
                            <h2> <strong>Major: </strong><%= current.major %></h2> --%>
                            <div class="col name">
                                <h1><%=user.name%></h1>
                                <h2><%=user.major%></h2>
                            </div>
                    </div>
                    <div class="row">
                        <div class="col class">
                        <h2><strong>Your Reviewed Classes</strong></h2>
	                        <table style="width:100%" class="table table-hover table-bordered">
	                        	<thead>
	                            	<tr>
	                                   <th>Class</th>
	                                   <th>Rating</th>
	                                   <th>Review</th>
	                              	</tr>
	                         	</thead>
	                            <tbody>
	                           <%for (UserReview j : user.reviews) { %>
	                               <tr>
	                                   <td><%= j.className%></td>
	                                   <td><%= j.rating%></td>
	                                   <td><%= j.reviewString%></td>
	                               </tr>
	                           <% } %>
	                           </tbody>
                        	</table>
                   		</div>
                    </div>
                </div>
            </div>
        </div>
	</body>
</html>