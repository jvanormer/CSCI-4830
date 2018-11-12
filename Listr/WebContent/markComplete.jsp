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
	<title>Listr - Mark Complete</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "" && request.getParameter("task-id") != null) { 
		DatabaseManager dm = new DatabaseManager();
		
		Date dueDate = null;
		
		try {
			dm.markComplete(request.getParameter("task-id"), session.getAttribute("user").toString());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("home.jsp");
			
	}
	else { 
		
		// Add some sort of error handling here
		response.sendRedirect("home.jsp");
	}
%>
</body>
</html>