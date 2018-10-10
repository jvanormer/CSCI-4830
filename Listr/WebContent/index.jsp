<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
</head>
<body>
<% 
	if (session.getAttribute("loggedIn") == null || session.getAttribute("loggedIn") == "") { 
%>
	<h1>Welcome to Listr</h1>
	<form action="login.jsp">
		<input type="submit" value="Log In" />
	</form>
	<br>
	<form action="register.jsp">
		<input type="submit" value="Register" />
	</form>
<% 
	} else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>