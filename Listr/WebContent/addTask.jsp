<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add Task</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body class="blue-grey darken-2">
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
%>
<div class="container">
	<div class="card blue-grey darken-1">
		<div class="card-content white-text">
			<span class="card-title"><h2>Add Task</h2></span>
			<form action="validateAddTask.jsp" method="POST">
				<label for="taskname">Task Name:</label>
				<input type="text" name="taskname" />				
				<label for="description">Description:</label>
				<input type="text" name="description" />				
				<label for="duedate">Due Date (DD/MM/YYYY):</label>
				<input type="text" name="duedate" />				
				<label for="urgency">Urgency (Currently Not Working):</label>
				<input type="text" name="urgency" />				
				<button type="submit" value="Add Task" class="waves-effect waves-light btn">Add Task</button>
				<a href="home.jsp" class="waves-effect waves-light btn">Home</a>
			</form>
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