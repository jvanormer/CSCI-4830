<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Delete Account</title>
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
				<span class="card-title"><h2>Delete Account</h2></span>	
				<h5 style="font-weight:bolder">WARNING: THIS ACTION CANNOT BE DONE</h5>	
				<form action="validateDeleteAccount.jsp" method="POST">
					<label for="password" >Enter Password to Confirm Deletion: </label>
					<input type="password" name="password" />							
					<button type="submit" value="Delete" class="waves-effect waves-light btn">Delete Account</button>
					<a href="home.jsp" class="waves-effect waves-light btn">Go Back</a>
				</form>											
			</div>		
		</div>			
	</div>
</body>
</html>