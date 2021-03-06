<%@ page import="java.sql.*" %>
<%@ page import="listr.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Listr - Change Password Validation</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body class="blue-grey darken-2">

<% 
	if (session.getAttribute("loggedIn") == null || session.getAttribute("loggedIn") == "") {
		response.sendRedirect("index.jsp");
	}

	String oldPassword = request.getParameter("oldPassword").toString();
	String password = request.getParameter("password").toString();
	String confirmPassword = request.getParameter("confirmPassword").toString();
	DatabaseManager dm = new DatabaseManager();
	
	
	if (password.length() > 10 || password.length() > 10) {
		%>
			<p>Error: Username / Password too long.<p>
			<a href="changePassword.jsp">Go Back</a>
		<% 
	} 
	else if (!(password.equals(confirmPassword))) {
		%>
			<p>Error: Password and Confirm Password o not match.<p>
			<a href="changePassword.jsp">Go Back</a>
		<%
	}
	
	else {
	
		if (dm.changePassword(session.getAttribute("user").toString(), oldPassword, password)) {
		%>
			<p>Password Change Successful.<p>
			<a href="home.jsp">Return Home</a>
		<%
		}
		else{
%>
			<p>Error: Password Change Failed.<p>
			<a href="changePassword.jsp">Go Back</a>
<%
		} 
	} 
%>

</body>
</html>