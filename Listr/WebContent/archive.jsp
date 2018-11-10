<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="listr.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Listr - Archive</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
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
		DatabaseManager dm = new DatabaseManager();
		String userName = session.getAttribute("user").toString();
		ArrayList<ListrTask> tasks = dm.getArchivedTasksForUser(userName, "dueDate-asc");
		
		boolean empty = true;
		for (ListrTask task : tasks){
			empty = false;
%>				
			<!-- Task -->
			<div class="card blue-grey">
				<div class="card-content white-text">
					<span class="card-title"><h3><%= task.getTaskName() %></h3></span>
					<h6><%= task.getCategoryDescription() %></h6>
					<p><%= task.getDescription() %></p>
					<p>Due: <%= task.getDueDate() %></p>
					<p>Urgency: <%= task.getUrgency() %></p>
					<div class="card-action">
						<div class="row">
							<div class="col">
								<form action="deleteTask.jsp" method="POST"><input type="hidden" name="task-id" value="<%= task.getId() %>">
									<button type="submit" value="Delete" class="btn orange darken-4 waves-effect waves-orange">Delete</button>
								</form>	
							</div>
							<div class="col">
								<form action="unarchiveTask.jsp" method="POST"><input type="hidden" name="task-id" value="<%= task.getId() %>">
									<button type="submit" value="Unarchive" class="btn yellow darken-4 waves-effect waves-yellow">Unarchive</button>
								</form>	
							</div>
						</div>																
					</div>
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