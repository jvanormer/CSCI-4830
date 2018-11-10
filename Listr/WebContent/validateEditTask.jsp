<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="listr.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Listr - Validate Edit Task</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "" && request.getParameter("task-id") != null) { 
		DatabaseManager dm = new DatabaseManager();
				
		ListrTask task = new ListrTask();
		task.setTaskName(request.getParameter("taskname"));						// Task Name
		task.setDescription(request.getParameter("description"));				// Description
		String dueDateString = request.getParameter("duedate");
		Date dueDate = null;
		
		try {
			dueDate = new SimpleDateFormat("yyyy-MM-dd").parse(dueDateString);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		task.setDueDate(dueDate); 					// Due Date		
		
		
		task.setUrgency(Integer.parseInt(request.getParameter("urgency")));		// Urgency	
		task.setId(Integer.parseInt(request.getParameter("task-id")));			// Task ID			
		
		int completed = 0;
		if (request.getParameter("completed") != null) {
			completed = 1;	
		}
		task.setCompleted(completed);											// Completed
		
		String userName = session.getAttribute("user").toString();				// Username				
		int userId = dm.getUserIdFromName(userName);							// User ID
		
		dm.updateTaskForUser(task, userId);
		response.sendRedirect("home.jsp");
			
	}
	else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>