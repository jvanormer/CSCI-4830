<%@ page import="java.sql.*" %>
<%@ page import="listr.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Validate Login</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body>

<% 
	String userName = request.getParameter("username").toString();
	String password = request.getParameter("password").toString();
	DatabaseManager dm = new DatabaseManager();
			
	if (dm.validateUser(userName, password)) {
		session.setAttribute("loggedIn", true);
		session.setAttribute("user", userName);
		response.sendRedirect("home.jsp");
	}
	else { 
%>	
	<body>
		Error: Login Credentials incorrect
		<a href="login.jsp">Go Back</a>
	</body>	
<%
	}  
%>

</body>
</html>