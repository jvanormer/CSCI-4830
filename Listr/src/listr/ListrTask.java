package listr;
import java.util.Date;

public class ListrTask {
	
	int id;
	String taskName;
	int urgency;
	String description;
	int categoryId;
	Date createDate;
	Date dueDate;
	int userId;
	int completed;	//boolean?
	int status; 	//boolean? Also, what is this for?
	String categoryDescription;
	public ListrTask() {
		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	public int getUrgency() {
		return urgency;
	}
	
	public String getUrgencyString() {
		switch (urgency) {
			case 1:
				return "High";
			case 2:
				return "Medium";
			case 3:
				return "Low";
			default:
				return "Medium";
		}
	}
	
	public void setUrgency(int urgency) {
		this.urgency = urgency;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getDueDate() {
		return dueDate;
	}
	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getCompleted() {
		return completed;
	}
	public void setCompleted(int completed) {
		this.completed = completed;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getCategoryDescription() {
		return categoryDescription;
	}
	public void setCategoryDescription(String categoryDescription) {
		this.categoryDescription = categoryDescription;
	}

	@Override
	public String toString() {
		return "ListrTask [id=" + id + ", taskName=" + taskName + ", urgency=" + urgency + ", description="
				+ description + ", categoryId=" + categoryId + ", createDate=" + createDate + ", dueDate=" + dueDate
				+ ", userId=" + userId + ", completed=" + completed + ", status=" + status + ", categoryDescription="
				+ categoryDescription + "]";
	}
	
}
