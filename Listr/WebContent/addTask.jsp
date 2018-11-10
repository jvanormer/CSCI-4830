<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add Task</title>
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
<% 
	if (session.getAttribute("loggedIn") != null && session.getAttribute("loggedIn") != "") { 
%>
<div class="container">
	<div class="card blue-grey darken-1">
		<div class="card-content white-text">
			<span class="card-title"><h2>Add Task</h2></span>
			<form action="validateAddTask.jsp" method="POST">
				<label for="taskname">Task Name:</label>
				<input type="text" name="taskname" />				
				<label for="description">Description:</label>
				<input type="text" name="description" />				
				<label for="duedate">Due Date (yyyy-mm-dd):</label>
				<input type="text" name="duedate" />				
				<div class="row">
					<label for="urgency">Urgency:</label>
					<select name="urgency">
	                  <option value = "1">High</option>
	                  <option value = "2" selected>Medium</option>
	                  <option value = "3">Low</option>
	               </select>
	            </div>				
				<button type="submit" value="Add Task" class="waves-effect waves-light btn">Add Task</button>
				<a href="home.jsp" class="waves-effect waves-light btn">Home</a>
			</form>
		</div>
	</div>
</div>		
			
<%
	} else { 
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>