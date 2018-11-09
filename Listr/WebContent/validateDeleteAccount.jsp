<%@ page import="java.sql.*" %>
<%@ page import="listr.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Listr - Account Deletion Validation</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body>

<% 
	if (session.getAttribute("loggedIn") == null || session.getAttribute("loggedIn") == "") {
		response.sendRedirect("index.jsp");
	}

	String password = request.getParameter("password").toString();
	DatabaseManager dm = new DatabaseManager();
	
		if (dm.deleteAccount(session.getAttribute("user").toString(), password)) {
			session.removeAttribute("loggedIn");
			session.removeAttribute("user");
			response.sendRedirect("index.jsp");
		%>
			<p>Account Deletion Successful.<p>
			<a href="index.jsp">Return Home</a>
		<%
		}
		else{
%>
			<p>Error: Delete Account Failed.<p>
			<a href="changePassword.jsp">Go Back</a>
<%
		} 
%>

</body>
</html>