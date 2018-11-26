<%@ page import="java.sql.*" %>
<%@ page import="listr.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Listr - Edit Task</title>
	<%@ include file="/WEB-INF/jspf/css.jspf" %>
	<script type = "text/javascript" src = "https://code.jquery.com/jquery-2.1.1.min.js"></script> 
	 <script src = "https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.3/js/materialize.min.js"></script>
	<script>
        $(document).ready(function() {
           $('select').material_select();
        });
	</script>
</head>
<body class="blue-grey darken-2">
<div class="container">
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "" && request.getParameter("task-id") != null) { 		
		int taskId = Integer.parseInt(request.getParameter("task-id"));
		DatabaseManager dm = new DatabaseManager();
		ListrTask task = dm.getTaskById(taskId);		
%>
		<div class="card blue-grey darken-1">
			<div class="card-content white-text">
				<span class="card-title"><h2>Edit Task</h2></span>
				<form action="validateEditTask.jsp" method="POST">
					<input type="hidden" name="task-id" value="<%= task.getId() %>">
					<label for="taskname">Task Name:</label>
					<input value="<%= task.getTaskName() %>" type="text" name="taskname" />
					<label for="description">Description:</label>
					<input value="<%= task.getDescription() %>" type="text" name="description" />				
					<label for="duedate">Due Date (yyyy-mm-dd):</label>
					<input value="<%= task.getDueDate() %>" type="text" name="duedate" />
					<label for="urgency">Urgency:</label>
					<div class="row">
						<% if ( task.getUrgency() == 1 ) { %>
							<label for="urgency">Urgency:</label>
							<select name="urgency">
		                  		<option value = "1" selected>High</option>
		                  		<option value = "2">Medium</option>
		                  		<option value = "3">Low</option>
		               		</select>
		               	<% } else if ( task.getUrgency() == 2 ) { %>
		               		<label for="urgency">Urgency:</label>
							<select name="urgency">
		                  		<option value = "1">High</option>
		                  		<option value = "2" selected>Medium</option>
		                  		<option value = "3">Low</option>
		               		</select>
		               	<% } else { %>
		               		<label for="urgency">Urgency:</label>
							<select name="urgency">
		                  		<option value = "1">High</option>
		                  		<option value = "2">Medium</option>
		                  		<option value = "3" selected>Low</option>
		               		</select>
		               	<% } %>
	            	</div>							
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
	else { 
		response.sendRedirect("index.jsp");
	}
%>
</div>
</body>
</html>