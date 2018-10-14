<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listr - Edit Task</title>
</head>
<body>
<h1>Edit Task</h1>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "" && request.getParameter("task-id") != null) { 
		Connection connection = null;
		
		String taskID = request.getParameter("task-id");
		
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/listr", "newremoteuser", "password");
		connection.setAutoCommit(true);
		String selectSQL = "SELECT * FROM task ta WHERE ID = ?";
		PreparedStatement ps = connection.prepareStatement(selectSQL);
		ps.setString(1, taskID);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			// Executes only once if resultset has rows (tasks)
			%>
			<form action="validateEditTask.jsp" method="GET">
				<input type="hidden" name="task-id" value="<%= request.getParameter("task-id").toString() %>">
				<label for="taskname">Task Name:</label>
				<input value="<%= rs.getObject("TASK_NAME").toString() %>" type="text" name="taskname" />
				<br><br>
				<label for="description">Description:</label>
				<input value="<%= rs.getObject("DESCRIPTION").toString() %>" type="text" name="description" />
				<br><br>
				<label for="duedate">Due Date (Currently Not Working):</label>
				<input value="<%= rs.getObject("DUE_DATE").toString() %>" type="text" name="duedate" />
				<br><br>
				<label for="urgency">Urgency (Currently Not Working):</label>
				<input value="<%= rs.getObject("URGENCY").toString() %>" type="text" name="urgency" />
				<br><br>
				<label for="completed">Completed</label>
				<input type="checkbox" name="completed" value="1" />
				<br><br>
				<input type="submit" value="Save Changes" />
			</form>
			<%
		}
	} 
	else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>