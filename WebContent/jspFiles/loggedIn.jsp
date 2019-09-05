<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "LogReg.User" %>
<%@ page import = "LogReg.UserReview" %>
<%
	User current = (User)session.getAttribute("loggedInUser");
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
		<link href="https://fonts.googleapis.com/css?family=Cinzel|Dosis" rel="stylesheet">
		
		<script type="text/javascript" src="terms.js"></script>
		<script type="text/javascript" src="departments.js"></script>
		
		<link href="homePage.css" rel="stylesheet">
		

		<title>SCholastic</title>
		<script>
			jQuery.ajaxSetup({async:false});
			function submitForm(){
				 $.get("../SearchServlet", $("#search-form").serialize(), function (responseText) {
	                   if(responseText.substr(0,1)=="!"){
	                       alert(responseText.substr(1));
	             			return false;
	                   }
	                   else{
	                   	   console.log("hello");
	                       /* var newDoc = document.open("text/html", "success");
	                       newDoc.write(responseText);
	                       console.log(newDoc);
	                       newDoc.close(); */
	                       return true
						 }
	                       
	          });
				
				//return false;
			}
			
			function populateTermDropList(){
				let data = document.getElementById('termList');
				console.log("hello");
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
				defaultOption.value = null;
	
				data.add(defaultOption);
				data.selectedIndex = 0;
	    		var x = JSON.stringify(departments);
				let userdata = JSON.parse(x);
				
				for(let i = 0; i < Object.keys(userdata.departments).length; i++){
					let departmentData = userdata.departments[i].department; 
						if(Array.isArray(departmentData) == true) {
						  	for(let j = 0; j < Object.keys(departmentData).length; j++){
					      		let option = document.createElement('option');
					      		if('<%=current.major%>' == departmentData[j].code){
					      			option.selected = true; 
					      			console.log("hello");
					      		}
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
				populateDepartments();
				populateTermDropList();
			};
			
			function check(id){
				if(id.checked){
					document.getElementById("searchby").value = id.value;
					
					if(id.name == "searchByCode"){
						document.getElementById("courseName").checked = false; 
						document.getElementById("teacherName").checked = false; 
					}
					if(id.name == "searchByName"){
						document.getElementById("courseCode").checked = false; 
						document.getElementById("teacherName").checked = false; 
					}
					if(id.name == "searchByTeacher"){
						document.getElementById("courseCode").checked = false; 
						document.getElementById("courseName").checked = false; 
					}
				}
			}
		</script>
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
			 .form{
			 	/*background-image: url("usc.jpg");*/
			 	height:800px;
			 	background-color: #F0F0F0;
			 	background-repeat:no-repeat;
			 	background-image: linear-gradient(0deg,red, white);
			 }
			 #logoImg{
			 	position: absolute;
			 	top:13%;
			 	left:38%;
			 }
			 .header{
			 	background-color: #cc0000;
			 	height:80px;
				font-family: 'Dosis', sans-serif;
			 	font-size: 40px;
			 	text-decoration:none;
			 }
			 .logo{
			 	padding-left: 20px;
			 	padding-right: 10px;
			 	
			 }
			 .profileLink{
			 	position: absolute;
			 	right:2%;
			 }
/*			 .regLink{
			 	position: absolute;
			 	right:2%;
			 }*/
			 a{
			 	color:white;
			 }

		</style>
	</head>
	<body>
		<div class="container-fluid homeContainer">

			<div class="row header">

				<div class="logo">
					<a href="loggedIn.jsp">SCholastic</a>
				</div>
				<div class="profileLink">
					<a href="profilePage.jsp">Profile</a>
				</div>
			</div>

			<div class="row form">
				<img src="http://pluspng.com/img-png/usc-png-about-ilios-287.png" height=300px width=300px id="logoImg">
				<form action="searchResults.jsp" class="col-12" id="search-form" onSubmit="return submitForm();">
					<div class="input-group">
						<input type="text"  name="query" class="form-control" id="search-id" placeholder="Search...">
                   		<select name="term" id="termList" class="form-control">
						</select>
                   		<select name="major" id="majorList" class="form-control">
						</select>
						<input type="submit" name="button" value="Submit"/>
						<input type="hidden" id="searchby" name="searchby" value=“coursecode”>
					</div>
					
					<div id="radioButton" style="top:48%; left:10%;">
						<input type="radio" id="courseCode" name="searchByCode" value="coursecode" checked="checked" onclick='check(courseCode);'>Course Code
						<input type="radio" id="courseName" name="searchByName" value="name" onclick='check(courseName);'>Course Name
						<input type="radio" id="teacherName" name="searchByTeacher" value="teacher" onclick='check(teacherName);'>Teacher Name
			                
					</div>
				</form>
			</div>
		</div>
	</body>
</html>