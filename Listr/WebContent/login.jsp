<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<h1>Login</h1>
	<form action="validateLogin.jsp" method="POST">
		<label for="username" >Username: </label>
		<input type="text" name="username" />
		<br>
		<br>
		<label for="password" >Password: </label>
		<input type="text" name="password" />
		<br>
		<br>
		<input type="submit" value="Login" />
	</form>
	<br>
	<form action="index.jsp" >
		<input type="submit" value="Home" />
	</form>
</body>
</html>