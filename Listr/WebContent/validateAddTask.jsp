<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
		
		String taskname = request.getParameter("taskname");
		String description = request.getParameter("description");
		
		Connection connection = null;
	
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/listr", "newremoteuser", "password");
		String selectSQL = "INSERT INTO task (DUE_DATE, CREATE_DATE, CATEGORY_ID, DESCRIPTION, URGENCY, TASK_NAME) VALUE (CURDATE()+7, CURDATE(), 1, ?, 1, ?)";
		String userName = session.getAttribute("user").toString();
		PreparedStatement ps = connection.prepareStatement(selectSQL);
		ps.setString(1, description);
		ps.setString(2, taskname);
		ps.executeUpdate();
	
	} else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>