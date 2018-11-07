<%@ page import="java.sql.*" %>
<%@ page import="listr.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Listr - Validate Add Task</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
		
		DatabaseManager dm = new DatabaseManager();
		
		ListrTask task = new ListrTask();
		task.setTaskName(request.getParameter("taskname"));						// Task Name
		task.setDescription(request.getParameter("description")); 				// Description				
		//String duedate = request.getParameter("duedate"); 					// Due Date		
		task.setUrgency(Integer.parseInt(request.getParameter("urgency")));		// Urgency		
		
		String userName = session.getAttribute("user").toString(); 				// User Name of submitting user							
		int userId = dm.getUserIdFromName(userName);							// User ID of submitting user
		if (dm.addTaskForUser(task, userId)){
			response.sendRedirect("home.jsp");			
		}					
		else {
			%>
				<p style="color: red">ERROR: Add Task Failed. Please Try Again.</p>
				<form action="home.jsp">
					<input type="submit" value="Return Home" />
				</form>
			<%
		}
	
	} else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>