<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Validate Login</title>
</head>
<body>

<% 
	Connection connection = null;

	Class.forName("com.mysql.jdbc.Driver");
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/listr", "newremoteuser", "password");
	String selectSQL = "SELECT * FROM users WHERE USER_NAME = ? and PASSWORD = ?";
	String userName = request.getParameter("username").toString();
	String password = request.getParameter("password").toString();
	PreparedStatement ps = connection.prepareStatement(selectSQL);
	ps.setString(1, userName);
	ps.setString(2, password);
	ResultSet rs = ps.executeQuery();
	
	if (rs.next()) {
		session.setAttribute("loggedIn", true);
		session.setAttribute("user", userName);
		response.sendRedirect("home.jsp");
	}
	else { %>
	
	<body>
		Error: Login Credentials incorrect
		<a href="login.jsp">Go Back</a>
	</body>
	
<%	}  %>

</body>
</html>