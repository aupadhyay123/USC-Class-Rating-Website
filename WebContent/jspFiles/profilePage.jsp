<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "LogReg.*" %>
    
<%
    User current = (User)session.getAttribute("loggedInUser");
	int id = current.tableID;
	
	DatabaseManager dm = new DatabaseManager();
	current.friends = dm.getFriends(id);
	current.pendingFriends = dm.getPending(id);
	dm.close();
	
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
        <link href="https://fonts.googleapis.com/css?family=Cinzel|Dosis" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="profilePage.css" rel="stylesheet">
        <title>SCholastic</title>
        <script>
        	function showPending() {
        		if(document.getElementById("displayPending").style.display = "none") {
        			document.getElementById("displayPending").style.display = "block";
        		} 
        	}
        	
        	function hidePending() {
        		if (document.getElementById("displayPending").style.display = "block") {
        			document.getElementById("displayPending").style.display = "none";
        		}
        	}
        	
        	//call this func when trying to validate friend
        	function validateFriend() {
   				var xhttp = new XMLHttpRequest();
   				var temp = document.getElementById("search-id").value;
   				xhttp.open("GET","../findFriendServlet?receivingUser=" + temp, false);
   				xhttp.send();
   				
   				if(xhttp.responseText.trim() != "success") {
   					
   					alert(xhttp.responseText);
   					return false;
   				}
   				return true;
        	}
        	
        	function acceptRequest(idFriend) {
				var xhttp = new XMLHttpRequest();
				var sender = '<%=current.username%>';
				xhttp.open("GET","../AcceptServlet?requestingUserID=" + idFriend + "&receivingUser=" + sender, false);
				xhttp.send();
				
				if(xhttp.responseText.trim() != "success") {
					
					alert(xhttp.responseText);
					return false;
				}
				
				alert("Friend request accepted.");
				return true;
	    	}
        	
        	function declineRequest(idFriend) {
        		var xhttp = new XMLHttpRequest();
				var sender = '<%=current.username%>';
				xhttp.open("GET","../DeclineServlet?requestingUserID=" + idFriend + "&receivingUser=" + sender, false);
				xhttp.send();
				
				if(xhttp.responseText.trim() != "success") {
					
					alert(xhttp.responseText);
					return false;
				}
				
				alert("Friend request declined.");
				return true;
	    	}
        	
        </script>
        
        <script>
			var socket;
			
			function connectToServer() {
				socket = new WebSocket("ws://localhost:8080/FinalProject_201/appEndpoint?id=" +<%=id%>);  //establishes connection with the server
				console.log(<%=id%>);
				socket.onopen = function(event) {	//overriding functions in JavaScript
					//document.getElementById("mychat").innerHTML += "Connected!<br />";
					
				}
				socket.onmessage = function(event) {
					console.log(event.data);
					alert(event.data);
					//document.getElementById("mychat").innerHTML += event.data + "<br />";
					
				}
				socket.onclose = function(event) {
					//document.getElementById("mychat").innerHTML += "Disconnected!<br />";
					
				}
			}
			
			function sendMessage() {
				socket.send(document.friendForm.request.value);	//sends the contents of my form to the WebSocket
				return false;	//makes the form not submit to the server --> no page refresh
				
								//sends data to the WebSocket without submitting the form
			}
		</script>
        
    </head>
    <body onload="connectToServer()">
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
            <div id = "displayPending" onclick = "hidePending()">
            	<table class = "table table-hover pendingFriends">
            		<thead>
                       <tr>
	                        <th>Pending Friends</th>
	                        <th>Accept</th>
	                        <th>Decline</th>
                        </tr>
                    </thead>
                    	<tbody>
                    	<% if(current.pendingFriends!=null) {
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
                        <% }
                        } %>
                     </tbody>
            	</table></div>
            <div class="row profile">
                <div class="profileStuff">
                    <div class="row">
<%--                             --<h1> <strong><%= current.name %></strong></h1>
                            <h2> <strong>Major: </strong><%= current.major %></h2> --%>
                            <div class="col name">
                                <h1><%=current.name%></h1>
                                <h2><%=current.major%></h2>
                            </div>
                    </div>
                    <div class="row">
                        <div class="col class">
                        <h2><strong>Your Reviewed Classes</strong></h2>
	                        <table style="width:100%">
	                        	<thead>
	                            	<tr>
	                                   <th>Class</th>
	                                   <th>Rating</th>
	                                   <th>Review</th>
	                              	</tr>
	                         	</thead>
	                            <tbody>
	                           <%for (UserReview j : current.reviews) { %>
	                               <tr>
	                                   <td><%= j.className%></td>
	                                   <td><%= j.rating%></td>
	                                   <td><%= j.reviewString%></td>
	                               </tr>
	                           <% } %>
	                           </tbody>
                        	</table>
                   		</div>
                    <div class="col friends">
                        <h2><strong>Your Friend's List</strong></h2>
                        	<table style="width:100%">
								<thead>
		                            <tr>
		                                <th>Friend Name</th>
		                            </tr>
                            	</thead>
                            	<tbody>
                            	<%-- <%if(current.friends != null) {%> --%>
		                       <%for(friend i : current.friends) { %>
		                      <%--  <%if(!current.username.equals("test1")) { %> --%>
		                            <tr>
		                                <td> <a href="../ProfileServlet?userID=<%=i.friendID%>"><%=i.name %></a> </td>
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