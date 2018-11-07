package listr;
import java.sql.*;
import java.util.ArrayList;

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
	private ArrayList<ListrTask> getTasksForUser(String userName, int completed) {
		ArrayList<ListrTask> tasks = new ArrayList<ListrTask>();
		String selectSQL = "SELECT * FROM task ta JOIN user_task ut ON ta.ID = ut.TASK_ID JOIN users us ON ut.USER_ID = us.ID LEFT JOIN category_ref cr ON ta.CATEGORY_ID = cr.ID WHERE us.USER_NAME = ? AND ut.COMPLETED = ? ";
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
	
	//Public-facing method that gets active tasks by user
	public ArrayList<ListrTask> getActiveTasksForUser(String userName){
		return getTasksForUser(userName, 0);
	}
	
	//Public-facing method that gets completed tasks by user
	public ArrayList<ListrTask> getArchivedTasksForUser(String userName){
		return getTasksForUser(userName, 1);
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
		boolean success = false;
		String insertSQL = "INSERT INTO task (DUE_DATE, CREATE_DATE, CATEGORY_ID, DESCRIPTION, URGENCY, TASK_NAME) "
				+ "VALUES (CURDATE()+7, CURDATE(), 1, ?, 1, ?);";
		
		String insertSQL2 = "INSERT INTO user_task (TASK_ID, USER_ID, COMPLETED, STATUS) "
				+ "VALUES (LAST_INSERT_ID(), ?, 0, 1);";
		
		try {
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1, task.getDescription());
			ps.setString(2, task.getTaskName());
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
	
	//Converts a resultset to task object
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
