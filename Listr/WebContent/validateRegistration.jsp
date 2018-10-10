<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration Validation</title>
</head>
<body>

<% 
	String userName = request.getParameter("username").toString();
	String password = request.getParameter("password").toString();
	
	if (userName.length() > 10 || password.length() > 10) {
		%>
			<p>Error: Username / Password too long.<p>
			<a href="register.jsp">Go Back</a>
		<% 
	} else {
	
	Connection connection = null;

	Class.forName("com.mysql.jdbc.Driver");
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/listr", "newremoteuser", "password");
	String selectSQL = "SELECT * FROM users WHERE USER_NAME = ?";
	PreparedStatement ps = connection.prepareStatement(selectSQL);
	ps.setString(1, userName);
	ResultSet rs = ps.executeQuery();
	
	if (rs.next()) {
		%>
			<p>Error: User name taken.<p>
			<a href="register.jsp">Go Back</a>
		<% 
	}
	else { 
		String insertSQL = "INSERT INTO users(USER_NAME, PASSWORD) VALUES(?, ?)";
		PreparedStatement ps2 = connection.prepareStatement(insertSQL);
		ps2.setString(1, userName);
		ps2.setString(2, password);
		if (ps2.executeUpdate() != 0) {
			session.setAttribute("loggedIn", true);
			session.setAttribute("user", userName);
			response.sendRedirect("home.jsp");
		} else {
			%>
				<p>Error: User creation unsuccessful.<p>
				<a href="register.jsp">Go Back</a>
			<%
		}
	
	}  

} %>

</body>
</html>