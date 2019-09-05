<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "LogReg.User" %>

<%
	User curr = (User)session.getAttribute("loggedInUser");
	System.out.println(curr.toString());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> User Check </title>
</head>
<body>

	<form action="LoginServlet" method="GET">
		Username <input type="text" name="logUser" style="width: 50%" /> <br/>
		
		Password <input type="text" name="logPw" style="width: 50%"/> <br/>
		
		<input type="submit" value="Submit" style="width:50%"/>
	</form>
	<br/>
	<br/>
	<br/>
	<br/>
	<form action="RegisterServlet" method="GET">
		Username <input type="text" name="regUser" style="width: 50%" /> <br/>
		
		Password <input type="text" name="regPw" style="width: 50%"/> <br/>
		
		Re-Enter Password <input type="text" name="regPw2" style="width: 50%"/> <br/>
		
		Full Name <input type="text" name="regFullName" style="width: 50%" /> <br/>
		
		Email <input type="text" name="regEmail" style="width:50%" /> <br/>
		
		University <input type="text" name="regUni" style="width:50%"/> <br/>
		
		Major <input type="text" name="regMaj" style="width:50%" /> <br/>
				
		<input type="submit" value="Submit" style="width:50%"/>
	</form>
	<br/>
	<br/>
	<br/>
	<br/>
	<form action="FriendRequestServlet" method="GET">
		Requesting User <input type="text" name="requestingUser" style="width: 50%" /> <br/>
		
		Receiving User <input type="text" name="receivingUser" style="width: 50%" /> <br/>
		
		<input type="submit" value="Submit" style="width:50%"/>
	</form>
	<br/>
	<br/>
	<br/>
	<br/>
	<form action="AcceptServlet" method="GET">
		Requesting User <input type="text" name="requestingUser" style="width: 50%" /> <br/>
		
		Accepting User <input type="text" name="receivingUser" style="width: 50%" /> <br/>
		
		<input type="submit" value="Submit" style="width:50%"/>
	</form>
	<br/>
	<br/>
	<br/>
	<br/>
	<form action="DeclineServlet" method="GET">
		Requesting User <input type="text" name="requestingUser" style="width: 50%" /> <br/>
		
		Declining User <input type="text" name="receivingUser" style="width: 50%" /> <br/>
		
		<input type="submit" value="Submit" style="width:50%"/>
	</form>

</body>
</html>