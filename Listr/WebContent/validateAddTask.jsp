<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Validate Add Task</title>
</head>
<body>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
		
		// Task Name
		String taskname = request.getParameter("taskname");
		// Description
		String description = request.getParameter("description");
		// Due Date
		String duedate = request.getParameter("duedate");
		// Urgency
		String urgency = request.getParameter("urgency");
		// User Name of submitting user
		String userName = session.getAttribute("user").toString();
		
		Connection connection = null;
	
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/listr", "newremoteuser", "password");
		
		String userId;
		
		String selectSQL = "SELECT ID FROM users WHERE USER_NAME = ?";
		PreparedStatement ps = connection.prepareStatement(selectSQL);
		ps.setString(1, userName);
		ResultSet rs = ps.executeQuery();
		
		if (rs.next()) {
			userId = rs.getString(1);
			
			String selectSQL2 = "INSERT INTO task (DUE_DATE, CREATE_DATE, CATEGORY_ID, DESCRIPTION, URGENCY, TASK_NAME) "
					+ "VALUES (CURDATE()+7, CURDATE(), 1, ?, 1, ?);"
					+ "INSERT INTO user_task (TASK_ID, USER_ID, COMPLETED, STATUS) "
					+ "VALUES (LAST_INSERT_ID(), ?, FALSE, 1);";
			PreparedStatement ps2 = connection.prepareStatement(selectSQL2);
			ps2.setString(1, description);
			ps2.setString(2, taskname);
			ps2.setString(3, userId);
			// Checks if insert was successful
			if (ps2.executeUpdate() > 0) {
				response.sendRedirect("home.jsp");
			}
		}
		else {
			%>
				<p style="color: red">ERROR: Add Task Failed. Please Try Again.</p>
				<form action="home.jsp">
					<input type="submit" value="Return Home" />
				</form>
			<%
		}
	
	} else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>