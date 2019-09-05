<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "LogReg.*" %>
<%@ page import = "Network.*" %>

<%
	User current = (User)session.getAttribute("loggedInUser");
	User friend = (User)session.getAttribute("foundFriend");
	
	int id = current.tableID;
	int idFriend = friend.tableID;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Friends Result Page</title>
        <link href="https://fonts.googleapis.com/css?family=Cormorant+Garamond" rel="stylesheet">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Cinzel|Dosis" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type = "text/css" href = "friendsList.css">
        
        <script>
        
	        function sendRequest() {
				var xhttp = new XMLHttpRequest();
				var sender = '<%=current.username%>';
				var temp = '<%=friend.username %>';
				console.log("../FriendRequestServlet?requestingUser=" + sender + "&receivingUser=" + temp);
				
				xhttp.open("GET","../FriendRequestServlet?requestingUser=" + sender + "&receivingUser=" + temp, false);
				xhttp.send();
				
				if(xhttp.responseText.trim() != "success") {
					
					alert(xhttp.responseText);
					return false;
				}
				
				sendMessage("request: " + '<%=idFriend%>');
				alert("Request sent to" + temp);
				return false;
	    	}
	        
		</script>
		
		<script>
       
			var socket;
			
			function connectToServer() {
				socket = new WebSocket("ws://localhost:8080/FinalProject_201/appEndpoint?id=" + <%=id%>);  //establishes connection with the server
				
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
			
			function sendMessage(message) {
				socket.send(message);	//sends the contents of my form to the WebSocket
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
                <!-- <div class="searchBar">
                    <form action="" method="GET" class="col-12" onsubmit = "return validateFriend();">
                        <div class="input-group">
                            <input type="text"  name="receivingUser" class="form-control" id="search-id" placeholder="Search for friends...">
                            <span class="input-group-btn">
                                <button type="submit" class="btn btn-danger btn-block">Search</button>
                            </span>
                        </div>
                    </form>
                </div> -->
                <div class = "profileRedirect">
                    <a href = "profilePage.jsp">Profile</a>
                </div>
                <div class="logOut">
                    <a href="logOut.jsp">Log Out</a>        <!--  take to logout JSP then to home page JSP-->
                </div>
            </div>
            <div class="row profile">
                <div class="profileStuff">
                    <div class="row">
                            <div class="col name">
                                <h1>You Found A Friend!</h1>
                            </div>
                    </div>
                    <div class="row">
                        <div class="col class">
                            <table class="table table-hover reviewTable">
                              <thead>
                                <tr>
                                  <th>Name</th>
                                  <th scope="col">Major</th>
                                  <th scope="col">Add?</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                  <td><%=friend.name %></td>
                                  <td><%=friend.major %></td>
                                  <td>
                                  	<form method="GET" onSubmit="return sendRequest();" onsubmit="return sendRequest();">
                                    <button class = "btn btn-success acceptFriend" type = "submit" onclick="submit"> Send Request</button>
                                    </form>
                                  </td>
                                  
                                </tr>
                              </tbody>
                            </table>
                    	</div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>