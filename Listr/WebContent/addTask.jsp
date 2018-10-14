<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Task</title>
</head>
<body>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
%>
	
	<form action="validateAddTask.jsp" method="POST">
		<label for="taskname">Task Name:</label>
		<input type="text" name="taskname" />
		<br><br>
		<label for="description">Description:</label>
		<input type="text" name="description" />
		<br><br>
		<label for="duedate">Due Date (Currently Not Working):</label>
		<input type="text" name="duedate" />
		<br><br>
		<label for="urgency">Urgency (Currently Not Working):</label>
		<input type="text" name="urgency" />
		<br><br>
		<input type="submit" value="Add Task" />
	</form>
	<br>
	<form action="home.jsp">
		<input type="submit" value="Back to Home" />
	</form>
			
<%
	} else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>