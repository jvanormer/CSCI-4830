<%@ page import="java.sql.*" %>
<%@ page import="listr.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Listr - Share Task Validation</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body>

<% 
	if (session.getAttribute("loggedIn") == null || session.getAttribute("loggedIn") == "" || request.getParameter("task-id") == null) {
		response.sendRedirect("index.jsp");
	}

	String username = request.getParameter("username").toString();
	String taskID = request.getParameter("task-id").toString();
	DatabaseManager dm = new DatabaseManager();
	
		if (dm.shareTask(username, taskID)) {
		%>
			<p>Task Share Successful.<p>
			<a href="index.jsp">Return Home</a>
		<%
		}
		else{
%>
			<p>Error: Task Share Failed.<p>
			<a href="home.jsp">Return Home</a>
<%
		} 
%>

</body>
</html>