<%@ page import="java.sql.*" %>
<%@ page import="listr.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Listr - Delete Task</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body>

<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 		
		int taskId = Integer.parseInt(request.getParameter("task-id"));
		String userName = session.getAttribute("user").toString();		
		DatabaseManager dm = new DatabaseManager();
		if (dm.deleteTaskForUser(userName, taskId)){
			response.sendRedirect("archive.jsp");
		}
		else{		
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