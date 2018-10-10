<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
</head>
<body>
	<h1>Register</h1>
	<form action="validateRegistration.jsp" method="GET">
		<label for="username" >Desired Username: </label>
		<input type="text" name="username" />
		<br>
		<br>
		<label for="password" >Desired Password: </label>
		<input type="text" name="password" />
		<br>
		<br>
		<input type="submit" value="Register" />
	</form>
	<br>
	<form action="index.jsp" >
		<input type="submit" value="Home" />
	</form>
</body>
</html>