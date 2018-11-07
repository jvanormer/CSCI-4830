<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
</head>
<body  class="blue-grey darken-2">

<div class="container">
	<div class="card blue-grey darken-1">
		<div class="card-content white-text">
			<span class="card-title"><h2>Login</h2></span>
			<form action="validateLogin.jsp" method="POST">
				<label for="username" >Username: </label>
				<input type="text" name="username" />				
				<label for="password" >Password: </label>
				<input type="password" name="password" />
				<button type="submit" value="Login" class="waves-effect waves-light btn">Login</button>
				<a href="index.jsp" class="waves-effect waves-light btn">Home</a>
			</form>		
		</div>
	</div>
</div>
</body>
</html>