<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Share Task</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>

<% 
	if (session.getAttribute("loggedIn") == null || session.getAttribute("loggedIn") == "" || request.getParameter("task-id") == null) {
		response.sendRedirect( "index.jsp" );
	}

	String taskID = request.getParameter("task-id");
%>

<body class="blue-grey darken-2">
	<div class="container">
		<div class="card blue-grey darken-1">
			<div class="card-content white-text">
				<span class="card-title"><h2>Share Task</h2></span>
				<form action="validateShareTask.jsp" method="POST">
					<label for="password" >Enter User to Share Task With: </label>
					<input type="text" name="username" />	
					<input type="hidden" name="task-id" value="<%= taskID %>"/>					
					<button type="submit" value="Share" class="waves-effect waves-light btn">Share Task</button>
					<a href="home.jsp" class="waves-effect waves-light btn">Return Home</a>
				</form>											
			</div>		
		</div>			
	</div>
</body>
</html>