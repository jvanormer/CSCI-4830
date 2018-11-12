package listr;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

public class DatabaseManager {
	String SQLUSER = "newremoteuser";
	String SQLPASSWORD = "password";
	String SQLDBURL = "jdbc:mysql://teagon.ddns.net:3306/listr";
	Connection connection = null;
	
	//Constructor
	public DatabaseManager() {
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection(SQLDBURL, SQLUSER, SQLPASSWORD);
			connection.setAutoCommit(true);
		} catch (Exception e) {
			e.printStackTrace();
		}				
	}
	
	//Generic method that gets tasks by username and completion status
	private ArrayList<ListrTask> getTasksForUser(String userName, int completed, String sortOrder) {
		String sort;
		
		switch(sortOrder) {
			case "task-asc":
				sort = "ta.TASK_NAME asc";
				break;
			case "task-desc":
				sort = "ta.TASK_NAME desc";
				break;
			case "createDate-asc":
				sort = "ta.CREATE_DATE asc";
				break;
			case "createDate-desc":
				sort = "ta.CREATE_DATE desc";
				break;
			case "dueDate-asc":
				sort = "ta.DUE_DATE asc";
				break;
			case "dueDate-desc":
				sort = "ta.DUE_DATE desc";
				break;
			case "urgency-asc":
				sort = "ta.URGENCY asc";
				break;
			case "urgency-desc":
				sort = "ta.URGENCY desc";
				break;
			default:
				sort = "ta.DUE_DATE asc";
				break;
		}
		
		ArrayList<ListrTask> tasks = new ArrayList<ListrTask>();
		String selectSQL = "SELECT * FROM task ta JOIN user_task ut ON ta.ID = ut.TASK_ID JOIN users us ON ut.USER_ID = us.ID LEFT JOIN category_ref cr ON ta.CATEGORY_ID = cr.ID WHERE us.USER_NAME = ? AND ut.COMPLETED = ? ORDER BY " + sort;
		try {
			PreparedStatement ps = connection.prepareStatement(selectSQL);
			ps.setString(1, userName);
			ps.setInt(2, completed);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {				
				//Add to list				 
				tasks.add(queryTask(rs));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return tasks;			
	}
	
	// Public-facing method that gets active tasks by user
	public ArrayList<ListrTask> getActiveTasksForUser(String userName, String sort){
		return getTasksForUser(userName, 0, sort);
	}
	
	// Public-facing method that gets completed tasks by user
	public ArrayList<ListrTask> getArchivedTasksForUser(String userName, String sort){
		return getTasksForUser(userName, 1, sort);
	}
	
	//TODO: Might be worth taking a look at the SQL in this one, Teagon
	public ListrTask getTaskById(int taskId) {
		ListrTask task = new ListrTask();
		String selectSQL = "SELECT * FROM task ta JOIN user_task ut ON ta.ID = ut.TASK_ID JOIN users us ON ut.USER_ID = us.ID LEFT JOIN category_ref cr ON ta.CATEGORY_ID = cr.ID WHERE TASK_ID = ? ";		
		try {
			PreparedStatement ps = connection.prepareStatement(selectSQL);
			ps.setInt(1, taskId);
			ResultSet rs = ps.executeQuery();			
			if (rs.next()) {
				task = queryTask(rs);				
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return task;
	}
	
	//Deletes a task 
	public boolean deleteTaskForUser(String userName, int taskId) {
		boolean success = false;
		String selectSQL = "SELECT ID FROM users WHERE USER_NAME = ?";
		try {
			PreparedStatement ps = connection.prepareStatement(selectSQL);
			ps.setString(1, userName);
			ResultSet rs = ps.executeQuery();
			if (success = rs.next()) {
				String userId = rs.getString("ID");				
				
				String deleteSQL = "DELETE FROM user_task WHERE USER_ID = ? AND TASK_ID = ?";
				PreparedStatement ps2 = connection.prepareStatement(deleteSQL);
				ps2.setString(1, userId);
				ps2.setInt(2, taskId);				
				ps2.executeUpdate();							
			}			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return success;
	}
	
	//Registers a user, returns true on success
	public boolean registerUser(String userName, String password) {
		boolean success = false;
		String selectSQL = "SELECT * FROM users WHERE USER_NAME = ?";
		try {
			PreparedStatement ps = connection.prepareStatement(selectSQL);
			ps.setString(1, userName);
			ResultSet rs = ps.executeQuery();
			success = !rs.next();		//If a row appears, the username already exists
			if (success) {
				String insertSQL = "INSERT INTO users(USER_NAME, PASSWORD) VALUES(?, ?)";
				PreparedStatement ps2 = connection.prepareStatement(insertSQL);
				ps2.setString(1, userName);
				ps2.setString(2, password);
				if (ps2.executeUpdate() == 0) {
					success = false;	//Failed to enter into database
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return success;
		
	}
	
	public Date parseDate(java.util.Date d) {
	    try {
	    	Date myDate = new java.sql.Date(d.getTime());
	    	return myDate;
	    } catch (Exception e) {
			e.printStackTrace();
		}
	    
	    return null;
	}
	
	//Returns true if a username and password pair exist for the parameters
	public boolean validateUser(String userName, String password) {
		boolean success = false;
		String selectSQL = "SELECT * FROM users WHERE USER_NAME = ? and PASSWORD = ?";		
		try {
			PreparedStatement ps = connection.prepareStatement(selectSQL);
			ps.setString(1, userName);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			success = rs.next();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return success;
	}
		
	//Allows adding a new task to a user
	//TODO: THIS WILL NEED CHANGES TO REFLECT ADDITION OF DATE FUNCTIONALITY
	public boolean addTaskForUser(ListrTask task, int userId) {
		Date dateFormatted = parseDate(task.dueDate);
		boolean success = false;
		String insertSQL = "INSERT INTO task (DUE_DATE, CREATE_DATE, CATEGORY_ID, DESCRIPTION, URGENCY, TASK_NAME) "
				+ "VALUES (?, CURDATE(), 1, ?, ?, ?);";
		
		String insertSQL2 = "INSERT INTO user_task (TASK_ID, USER_ID, COMPLETED, STATUS) "
				+ "VALUES (LAST_INSERT_ID(), ?, 0, 1);";
		
		try {
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setDate(1, dateFormatted);
			ps.setString(2, task.getDescription());
			ps.setInt(3, task.getUrgency());
			ps.setString(4, task.getTaskName());
			PreparedStatement ps2 = connection.prepareStatement(insertSQL2);
			ps2.setInt(1, userId);
			ps.executeUpdate();
			ps2.executeUpdate();			
			success = true;			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return success;
	}
	
	
	//TODO: Needs to account for dates/urgency
	public boolean updateTaskForUser(ListrTask task, int userId) {
		boolean success = false;
		String updateSQL = "UPDATE task SET TASK_NAME = ?, DESCRIPTION = ? WHERE ID = ?";
		String updateSQL2 = "UPDATE user_task SET COMPLETED = ? WHERE TASK_ID = ? AND USER_ID = ?";
		try {
			PreparedStatement ps = connection.prepareStatement(updateSQL);
			ps.setString(1, task.getTaskName());
			ps.setString(2, task.getDescription());
			ps.setInt(3, task.getId());
						
			PreparedStatement ps2 = connection.prepareStatement(updateSQL2);
			ps2.setInt(1, task.getCompleted());
			ps2.setInt(2, task.getId());
			ps2.setInt(3, userId);
			
			ps.executeUpdate();			
			ps2.executeUpdate();
			success = true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
					
		return success;
	}
	
	//Retrieves a given user's ID
	//TODO: Might be a good use of our energy just to store the ID into the session, but I'm not sure if that will be hard
	public int getUserIdFromName(String userName) {
		int userId = -1;
		String selectSQL = "SELECT ID FROM users WHERE USER_NAME = ?";
		try {
			PreparedStatement ps = connection.prepareStatement(selectSQL);
			ps.setString(1,  userName);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				userId = rs.getInt("ID");
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}
	
	// Checks to make sure the correct previous passw0rd was given and once confirmed changes the user's password.
	public boolean changePassword(String userName, String oldPassword, String password) {
		String selectSQL = "SELECT USER_NAME FROM users WHERE USER_NAME = ? AND PASSWORD = ?";
		
		try {
			PreparedStatement ps = connection.prepareStatement(selectSQL);
			ps.setString(1, userName);
			ps.setString(2, oldPassword);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				String updateSQL = "UPDATE users SET PASSWORD = ? WHERE USER_NAME = ?";
				
				PreparedStatement ps2 = connection.prepareStatement(updateSQL);
				ps2.setString(1, password);
				ps2.setString(2, userName);
				
				ps2.executeUpdate();
				
				return true;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean markComplete(String taskID, String userName) {
		try {
			String userID = String.valueOf(getUserIdFromName(userName));
			
			String insertSQL = "UPDATE user_task SET COMPLETED = 1 WHERE TASK_ID = ? AND USER_ID = ?;";
			
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1, taskID);
			ps.setString(2, userID);
			
			ps.executeUpdate();
			
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean shareTask(String userName, String taskID) {
		try {
			String userID = String.valueOf(getUserIdFromName(userName));
			
			String insertSQL = "INSERT INTO user_task (TASK_ID, USER_ID, COMPLETED, STATUS) "
					+ "VALUES (?, ?, 0, 1);";
			
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1, taskID);
			ps.setString(2, userID);
			
			ps.executeUpdate();
			
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteAccount(String userName, String password) {
		String selectSQL = "SELECT USER_NAME FROM users WHERE ID = ? AND PASSWORD = ?";
		String userID = String.valueOf(getUserIdFromName(userName));
		
		try {
			PreparedStatement ps = connection.prepareStatement(selectSQL);
			ps.setString(1, userID);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				String updateSQL = "DELETE FROM users WHERE ID = ?";
				
				PreparedStatement ps2 = connection.prepareStatement(updateSQL);
				ps2.setString(1, userID);
				
				ps2.executeUpdate();
				
				String updateSQL2 = "DELETE FROM user_task WHERE USER_ID = ?";
				
				PreparedStatement ps3 = connection.prepareStatement(updateSQL2);
				ps3.setString(1, userID);
				
				ps3.executeUpdate();
				
				return true;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Converts a resultset to task object
	private ListrTask queryTask(ResultSet rs) throws Exception {
		ListrTask task = new ListrTask();
		//task
		task.setId(rs.getInt("ta.ID"));
		task.setTaskName(rs.getString("ta.TASK_NAME"));
		task.setUrgency(rs.getInt("ta.URGENCY"));
		task.setDescription(rs.getString("ta.DESCRIPTION"));
		task.setCategoryId(rs.getInt("ta.CATEGORY_ID"));	
		task.setDueDate(rs.getDate("ta.CREATE_DATE"));
		task.setDueDate(rs.getDate("ta.DUE_DATE"));				
		
		//category_ref
		task.setCategoryDescription(rs.getString("cr.CATEGORY_DESCRIPTION"));							
		
		//user_task						
		task.setUserId(rs.getInt("ut.USER_ID"));
		task.setCompleted(rs.getInt("ut.COMPLETED"));
		task.setStatus(rs.getInt("ut.STATUS"));
		return task;
	}
}
