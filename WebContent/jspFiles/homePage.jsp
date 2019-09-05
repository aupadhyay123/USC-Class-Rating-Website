<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Network.*" %>
    
<%
	/* session.setAttribute("currentPage", "homePage.jsp");
	if(session.getAttribute("client") == null){
		Client c = new Client("localhost",3456,session);
		session.setAttribute("client", c);
		c.sendMessage((String)session.getAttribute("currentPage"));
	} */
	
%>

<!DOCTYPE html>
<html>
	<head>
		<!-- Meta Tags -->
		<link href="https://fonts.googleapis.com/css?family=Cormorant+Garamond" rel="stylesheet">
    	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
		
		<script src="https://code.jquery.com/jquery-3.4.0.min.js" integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg=" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
		<link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Cinzel|Dosis" rel="stylesheet">
		
		<link href="homePage.css" rel="stylesheet">
	
		<script type="text/javascript" src="terms.js"></script>
		<script type="text/javascript" src="departments.js"></script>
		
		<title>SCholastic</title>

		<script type="text/javascript">
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
				data.length = 0;
				let defaultOption = document.createElement('option');
				defaultOption.text = 'Choose Term';
				defaultOption.value = null;
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
	</head>
	<body>
		<div class="container-fluid homeContainer">

			<div class="row  header">
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