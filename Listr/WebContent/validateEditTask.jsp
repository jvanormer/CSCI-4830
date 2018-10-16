<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listr - Validate Edit Task</title>
</head>
<body>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "" && request.getParameter("task-id") != null) { 
		
		// Task Name
		String taskName = request.getParameter("taskname");
		// Description
		String description = request.getParameter("description");
		// Due Date
		String duedate = request.getParameter("duedate");
		// Urgency
		String urgency = request.getParameter("urgency");
		// Task ID
		String taskID = request.getParameter("task-id");
		
		// Completed
		String completed = "0";
		if (request.getParameter("completed") != null) {
			completed = "1";	
		}
		
		Connection connection = null;
	
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/listr", "newremoteuser", "password");
		
		String selectSQL = "UPDATE task SET TASK_NAME = ?, DESCRIPTION = ? WHERE ID = ?";
		PreparedStatement ps = connection.prepareStatement(selectSQL);
		ps.setString(1, taskName);
		ps.setString(2, description);
		ps.setString(3, taskID);
		ps.executeUpdate();
		
		String userId;
		
		String selectSQL2 = "SELECT ID FROM users WHERE USER_NAME = ?";
		PreparedStatement ps2 = connection.prepareStatement(selectSQL2);
		ps2.setString(1, session.getAttribute("user").toString());
		ResultSet rs = ps2.executeQuery();
		
		if (rs.next()) {
			userId = rs.getString("ID");
			
			String insertSQL = "UPDATE user_task SET COMPLETED = ? WHERE TASK_ID = ? AND USER_ID = ?";
			PreparedStatement ps3 = connection.prepareStatement(insertSQL);
			ps3.setString(1, completed);
			ps3.setString(2, taskID);
			ps3.setString(3, userId);
			
			ps3.executeUpdate();
		}
		
		response.sendRedirect("home.jsp");	
	}
	else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>