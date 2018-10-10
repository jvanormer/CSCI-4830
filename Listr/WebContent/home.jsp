<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listr - Home</title>
</head>
<body>

<h1>Home</h1>
<h3>Current Tasks:</h3>
<table>
<tr>
	<th>Task Name</th>
	<th>Due Date</th>
	<th>Description</th>
	<th>Urgency</th>
	<th>Category</th>
	<th></th>
	<th></th>
</tr>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
		
		// checks for any elements returned
		boolean check = false;
		
		Connection connection = null;
	
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/listr", "newremoteuser", "password");
		String selectSQL = "SELECT * FROM task ta JOIN user_task ut ON ta.ID = ut.TASK_ID JOIN users us ON ut.USER_ID = us.ID JOIN category_ref cr ON ta.CATEGORY_ID = cr.ID WHERE us.USER_NAME = ?";
		String userName = session.getAttribute("user").toString();
		PreparedStatement ps = connection.prepareStatement(selectSQL);
		ps.setString(1, userName);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			check = true;
			%>
			<tr>
				<td><%= rs.getObject("ta.TASK_NAME").toString() %></td>
				<td><%= rs.getObject("ta.DUE_DATE").toString() %></td>
				<td><%= rs.getObject("ta.DESCRIPTION").toString() %></td>
				<td><%= rs.getObject("ta.URGENCY").toString() %></td>
				<td><%= rs.getObject("cr.CATEGORY_DESCRIPTION").toString() %></td>
			</tr>
			<%
		
	} 
	if (check == false) {
		%>
			<h4>No tasks found!</h4>
		<%
	}
	} else { 
		response.sendRedirect("index.jsp");
	}
%>
</table>
</body>
</html>