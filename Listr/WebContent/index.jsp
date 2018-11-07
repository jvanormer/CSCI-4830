<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Home</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body class="blue-grey darken-2">
<% 
	if (session.getAttribute("loggedIn") == null || session.getAttribute("loggedIn") == "") { 
%>

<div class="container">	
	<div class="card blue-grey darken-1 center-align">
		<div class="card-content white-text">
			<span class="card-title"><h2>Welcome to Listr</h2></span>														
		</div>		
		<div class="card-action">			
			<a href="login.jsp" class="waves-effect waves-light btn">Log In</a>											
			<a href="register.jsp" class="waves-effect waves-light btn">Register</a>				
		</div>				
	</div>
</div>
<% 
	} else { 
		response.sendRedirect("home.jsp");
	}
%>
</body>
</html>