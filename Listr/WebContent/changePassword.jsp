<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Change Password</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>

<% 
	if (session.getAttribute("loggedIn") == null || session.getAttribute("loggedIn") == "") {
		response.sendRedirect("index.jsp");
	}
%>

<body class="blue-grey darken-2">
	<div class="container">
		<div class="card blue-grey darken-1">
			<div class="card-content white-text">
				<span class="card-title"><h2>Change Password</h2></span>			
				<form action="validateChangePassword.jsp" method="POST">
					<label for="oldPassword" >Old Password: </label>
					<input type="text" name="oldPassword" />				
					<label for="password" >Desired Password: </label>
					<input type="password" name="password" />	
					<label for="confirmPassword" >Confirm Desired Password: </label>
					<input type="password" name="confirmPassword" />								
					<button type="submit" value="change-password" class="waves-effect waves-light btn">Change Password</button>
					<a href="home.jsp" class="waves-effect waves-light btn">Home</a>
				</form>											
			</div>		
		</div>			
	</div>
</body>
</html>