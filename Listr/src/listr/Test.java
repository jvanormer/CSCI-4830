package listr;

public class Test {
	public static void main(String[] args) {
		DatabaseManager dm = new DatabaseManager();
		int id = dm.getUserIdFromName("James");
		System.out.println(id);
	}
}
