<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listr - Archive</title>
	<!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    
	<!--Material icons-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">  
</head>
<body class="blue-grey darken-2">
<div class="container">
	<div class="card blue-grey darken-1">
		<div class="card-content white-text">
			<span class="card-title"><h2>Archive</h2></span>
			<a title="Current Tasks" href="home.jsp" class="btn-floating btn-large waves-effect waves-light btn"><i class="material-icons">arrow_back</i></a>
			<a title="Logout" href="validateLogout.jsp" class="btn-floating btn-large waves-effect waves-light btn"><i class="material-icons">logout</i></a>
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
		
		//Boolean seeing if no data was returned
		boolean empty = true;
				
		Connection connection = null;		
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/listr", "newremoteuser", "password");
		connection.setAutoCommit(true);
		String selectSQL = "SELECT * FROM task ta JOIN user_task ut ON ta.ID = ut.TASK_ID JOIN users us ON ut.USER_ID = us.ID LEFT JOIN category_ref cr ON ta.CATEGORY_ID = cr.ID WHERE us.USER_NAME = ? AND ut.COMPLETED = 1";
		String userName = session.getAttribute("user").toString();
		PreparedStatement ps = connection.prepareStatement(selectSQL);
		ps.setString(1, userName);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			empty = false;
			// Executes only once if resultset has rows (tasks)
%>				
			<!-- Task -->
			<div class="card blue-grey">
				<div class="card-content white-text">
					<span class="card-title"><h3><%= rs.getObject("ta.TASK_NAME").toString() %></h3></span>
					<h6><%= rs.getObject("cr.CATEGORY_DESCRIPTION").toString() %></h6>
					<p><%= rs.getObject("ta.DESCRIPTION").toString() %></p>
					<p>Due: <%= rs.getObject("ta.DUE_DATE").toString() %></p>
					<p>Urgency: <%= rs.getObject("ta.URGENCY").toString() %></p>
				</div>
			</div>
			<!-- Task -->	
<%
		}
		if (empty) {
%>			
			<div class="card blue-grey">
				<div class="card-content white-text">
					<span class="card-title"><h3>No Tasks Found!</h3></span>					
				</div>
			</div>					
<%
		}	
	//If not logged in
	} else { 
		response.sendRedirect("index.jsp");
	}
%>
		</div>
	</div>
</div>
</body>
</html>