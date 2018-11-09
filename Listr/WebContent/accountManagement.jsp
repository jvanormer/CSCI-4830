<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Account Management</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body class="blue-grey darken-2">
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
%>

<div class="container">	
	<div class="card blue-grey darken-1 center-align">
		<div class="card-content white-text">
			<span class="card-title"><h2>Account Management</h2></span>														
		</div>		
		<div class="card-action">			
			<a href="changePassword.jsp" class="waves-effect waves-light btn">Change Password</a>											
			<a href="deleteAccount.jsp" class="waves-effect waves-light btn">Delete Account</a>		
			<a href="validateLogout.jsp" class="waves-effect waves-light btn">Logout</a>											
			<a href="home.jsp" class="waves-effect waves-light btn">Return Home</a>		
		</div>				
	</div>
</div>
<% 
	} else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>