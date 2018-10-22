<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listr - Delete Task</title>
</head>
<body>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
		
		// Task Name
		String taskID = request.getParameter("task-id");
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
			userId = rs.getString("ID");
			connection.setAutoCommit(true);
			
			String deleteSQL = "DELETE FROM user_task WHERE USER_ID = ? AND TASK_ID = ?";
			PreparedStatement ps2 = connection.prepareStatement(deleteSQL);
			ps2.setString(1, userId);
			ps2.setString(2, taskID);
			
			ps2.executeUpdate();
			
			response.sendRedirect("archive.jsp");
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