<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listr - Edit Task</title>
	<!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</head>
<body class="blue-grey darken-2">
<div class="container">
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
	<div class="card blue-grey darken-1">
		<div class="card-content white-text">
			<span class="card-title"><h2>Edit Task</h2></span>
			<form action="validateEditTask.jsp" method="GET">
				<input type="hidden" name="task-id" value="<%= request.getParameter("task-id").toString() %>">
				<label for="taskname">Task Name:</label>
				<input value="<%= rs.getObject("TASK_NAME").toString() %>" type="text" name="taskname" />
				<label for="description">Description:</label>
				<input value="<%= rs.getObject("DESCRIPTION").toString() %>" type="text" name="description" />				
				<label for="duedate">Due Date (Currently Not Working):</label>
				<input value="<%= rs.getObject("DUE_DATE").toString() %>" type="text" name="duedate" />
				<label for="urgency">Urgency (Currently Not Working):</label>
				<input value="<%= rs.getObject("URGENCY").toString() %>" type="text" name="urgency" />							
				<p>
					<label>
						<input type="checkbox" name="completed" value="1" />
						<span>Completed</span>
					</label>
				</p>
				<br>
				<button type="submit" value="Save Changes" class="waves-effect waves-light btn">Save Changes</button>
				<a href="home.jsp" class="waves-effect waves-light btn">Home</a>
			</form>
		</div>
	</div>					
<%
		}
	} 
	else { 
		response.sendRedirect("index.jsp");
	}
%>
</div>
</body>
</html>