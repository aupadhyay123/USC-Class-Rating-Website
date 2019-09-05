package LogReg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//import java.sql.Statement;

import ReviewClass.RatedClass;
import ReviewClass.Review;
import ReviewClass.SCholasticClass;

public class DatabaseManager {
	
	public Connection conn;
	
	public ResultSet rs;
	public ResultSet friendSet;
	public ResultSet reviewSet;
	public String error;
	
	public User loggedInUser;
	public ArrayList<friend> friendsVec;
	public ArrayList<friend> pendingVec;
	public ArrayList<UserReview> reviewVec;
	public int id;
	
	public Statement st = null;
	//John's Prepared Statements
	public PreparedStatement check;
	public PreparedStatement adding;
	public PreparedStatement friendExists;
	public PreparedStatement requestFriend;
	public PreparedStatement addFriend;
	public PreparedStatement deleteFriend;
	public PreparedStatement getFriends;
	public PreparedStatement getUserReviews;
	public PreparedStatement getPending;
	
	
	//Sam's Prepared Statements
	private PreparedStatement checkClass;
	private PreparedStatement addClass;
	private PreparedStatement addReview;
	private PreparedStatement nameSearch;
	private PreparedStatement coursecodeSearch;
	private PreparedStatement teacherSearch;
	private PreparedStatement getReviews;
	private PreparedStatement getUser;
	
	//John's Strings
	public String addString;
	public String checkString;
	public String friendExistsString;
	public String requestFriendString;
	public String addFriendString;
	public String deleteFriendString;
	public String getFriendsString;
	public String getUserReviewsString;
	public String getPendingString;
	
	//Sam's Strings
	private final String checkClassString = "SELECT classID FROM Classes WHERE coursecode=? AND teacher=?";
	private final String addClassString = "INSERT INTO Classes(name, teacher, coursecode) VALUES(?, ?, ?)";
	private final String addReviewString = "INSERT INTO Ratings(classID, rating, review, userID) VALUES(?, ?, ?, ?)";
	private final String nameSearchString = "SELECT * FROM Classes WHERE name LIKE CONCAT('%', ?, '%')";
	private final String coursecodeSearchString = "SELECT * FROM Classes WHERE coursecode=?";
	private final String teacherSearchString = "SELECT * FROM Classes WHERE teacher LIKE CONCAT('%', ?, '%')";
	private final String getReviewsString = "SELECT r.*, u.major FROM Ratings r, Users u WHERE r.classID=? AND r.userID=u.userID";
	private final String getUserString = "SELECT * FROM Users WHERE userID=?";
	
	
	public DatabaseManager() {		//VERY IMPORTANT --> Make sure you always call a method of this class so that all connections are closed
		conn = null;
		rs = null;
		friendSet = null;
		error = null;
		
		loggedInUser= null;
		friendsVec = new ArrayList<friend>();
		pendingVec = new ArrayList<friend>();
		reviewVec = new ArrayList<UserReview>();
		
		check = null;		//Set All PreparedStatements to null before use
		adding = null;
		friendExists = null;
		requestFriend = null;
		addFriend = null;
		deleteFriend = null;
		getFriends = null;
		getPending = null;
		
		checkString = "SELECT * FROM Users WHERE username = ?";
		
		addString = "INSERT INTO Users(username, password, name, email, university, major) VALUES(?, ?, ?, ?, ?, ?) ";
		
		friendExistsString = "SELECT pending FROM Friends Where userID1=? AND userID2=?";
		
		requestFriendString = "INSERT INTO Friends(userID1, userID2, pending) VALUES(?,?,false), (?,?,false) ";	//CHANGE --> now 0 for all initial friendRequests
		
		addFriendString = "UPDATE Friends SET pending=true WHERE userID1=? AND userID2=? ";
		
		deleteFriendString = "DELETE FROM Friends WHERE userID1=? AND userID2=? ";
		
		getFriendsString = "SELECT u.userID, u.name FROM Users u, Friends f WHERE f.userID2=? AND f.pending=true AND f.userID1=u.userID ";
		
		getPendingString = "SELECT u.userID, u.name FROM Users u, Friends f WHERE f.userID2=? AND f.pending=false AND f.userID1=u.userID ";

		getUserReviewsString = "SELECT c.name, r.rating, r.review FROM Users u, Classes c, Ratings r WHERE u.userID=? AND r.userID=u.userID AND r.classID=c.classID ";
		
		this.open();
	}
	
	public void open() {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SCholastic?user=root&password=root&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
						
			st = conn.createStatement();
			check = conn.prepareStatement(checkString);			//Initialize all PreparedStatements
			adding = conn.prepareStatement(addString);
			friendExists = conn.prepareStatement(friendExistsString);
			requestFriend = conn.prepareStatement(requestFriendString);
			addFriend = conn.prepareStatement(addFriendString);
			deleteFriend = conn.prepareStatement(deleteFriendString);
			getFriends = conn.prepareStatement(getFriendsString);
			getUserReviews = conn.prepareStatement(getUserReviewsString);
			getPending = conn.prepareStatement(getPendingString);
			
			//Sam's
			String generatedColumns[] = { "ID" };
			checkClass = conn.prepareStatement(checkClassString, generatedColumns);
			addClass = conn.prepareStatement(addClassString, generatedColumns);
			addReview = conn.prepareStatement(addReviewString);
			nameSearch = conn.prepareStatement(nameSearchString);
			coursecodeSearch = conn.prepareStatement(coursecodeSearchString);
			teacherSearch = conn.prepareStatement(teacherSearchString);
			getReviews = conn.prepareStatement(getReviewsString);
			getUser = conn.prepareStatement(getUserString);
		}
		catch(ClassNotFoundException cnfe) {
			System.out.println(cnfe.getMessage());
			close();
		}
		catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
			close();
		}
		catch(Exception e) {	//To catch NullPointerException
			System.out.println(e.getMessage());
			close();
		}
	}

	public void close() {
		try {
			if(rs != null) {
				rs.close();
			}
			if(friendSet != null) {
				friendSet.close();
			}
			if(st != null) {
				st.close();
			}
			if(reviewSet != null) {
				reviewSet.close();
			}
			if(conn != null) {
				conn.close();
			}
			if(check != null) {
				check.close();
			}
			if(adding != null) {
				adding.close();
			}
			if(friendExists != null) {
				friendExists.close();
			}
			if(requestFriend != null) {
				requestFriend.close();
			}
			if(addFriend != null) {
				addFriend.close();
			}
			if(deleteFriend != null) {
				deleteFriend.close();
			}
			if(getFriends != null) {
				getFriends.close();
			}
			if(getUser != null) {
				getUser.close();
			}
			if(getPending != null) {
				getPending.close();
			}
		}
		catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public boolean regCheck(String user, String pw, String pw2) {
		
		int exists = this.userExists(user);
		
		close();
		
		if(exists != -1) {
			this.error = "Username already taken.";
			return true;
		}
		
		if(!pw.equals(pw2)) {
			this.error = "Passwords do not match.";
			return true;
		}
		
		return false;
		
		
	}
	
	public int userExists(String user) {		//helper function --> never call it
		try {
			check.setString(1, user);
			rs = check.executeQuery();
			
			if(!rs.next()) {
				this.error = "Username was not found.";
				close();
				return -1;
			}
			
			this.id = rs.getInt(rs.findColumn("userID"));	//saves the userID index for the current User

								
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return this.id;
	}
	
	public boolean validateUser(String user, String pw) {
		
		try {
			
			check.setString(1, user);
			rs = check.executeQuery();
			
			if(!rs.next()) {
				this.error = "Username was not found.";
				close();
				return false;
			}
			
			this.id = rs.getInt(rs.findColumn("userID"));
						
			if(this.error == null && !(rs.getString("password").equals(pw))) {
				this.error = "Incorrect password for: " + user + ".";
				close();
				return false;
			}
			
			this.friendsVec = this.getFriends(this.id);
			this.reviewVec = this.getUserReviews(this.id);
			this.pendingVec = this.getPending(this.id);
			
			loggedInUser = new User(this.id, user, pw, rs.getString("name"), rs.getString("email"), rs.getString("university"), rs.getString("major"), this.friendsVec, this.reviewVec, this.pendingVec);
			
		}
		catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
			close();
			return false;
		}
		finally {
			close();
		}
		
		return true;
	}
	
	public void addUser(String user, String pw, String pwConfirm, String name, String email, String uni, String maj) {
		try {
			this.error = null;	//to reset error message from non-existent user 
				
			adding.setString(1, user);
			adding.setString(2, pw);
			adding.setString(3, name);
			adding.setString(4, email);
			adding.setString(5, uni);
			adding.setString(6, maj);
			
			int i = adding.executeUpdate();
			
			if(i == 0) 
				System.out.println("Problem adding" + user + " to database --> check prepared statement");
			
			this.id = this.userExists(user);	//to add the new id of the user to the user instantiation
			this.error = null;
			
			this.friendsVec = this.getFriends(this.id);
			this.reviewVec = this.getUserReviews(this.id);
			this.pendingVec = this.getPending(this.id);
			
			loggedInUser = new User(this.id, user, pw, name, email, uni, maj, this.friendsVec, this.reviewVec, this.pendingVec);

		}
		catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		finally {
			close();
		}
	}
	
	public boolean friendshipExists(int userID, int friendID) {
		try {
			friendExists.setInt(1, userID);
			friendExists.setInt(2, friendID);
			rs = friendExists.executeQuery();
			
			if(rs.next()) {
				this.error = (rs.getInt("pending") == 0) ? "Friendship is still pending." : "Friendship already exists.";
				return true;
			}
		}catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		
		return false;
	}
	
	public boolean addFriend(String user, String friend, boolean requestAccepted) {
		try {
			
			int friendExists = this.userExists(friend);
			
			if(friendExists == -1) {
				this.error = friend + " is not a valid username.";
				close();
				return false;
			}
			
			int userExists = this.userExists(user);
			
			if(userExists == -1) {
				System.out.println(user + "is not a valid username.");
			}
			
			if(requestAccepted == false) {
				
				if(this.friendshipExists(userExists, friendExists) == true) {
					this.error = "Friendship already exists.";
					close();
					return false;
				}
				
				requestFriend.setInt(1, userExists);
				requestFriend.setInt(2, friendExists);
				requestFriend.setInt(3, friendExists);
				requestFriend.setInt(4, userExists);
								
				boolean res = requestFriend.execute();
				
				if(res == true) 
					System.out.println("Problem adding pending friendship between " + friend + " and" + user);
			}
			
			else {
				addFriend.setInt(1, userExists);
				addFriend.setInt(2, friendExists);
				boolean success = addFriend.execute();
				
				if(success == true) 
					System.out.println("Problem adding friendship between " + user + " and" + friend);
				
				addFriend.clearParameters();
				
				addFriend.setInt(1, friendExists);
				addFriend.setInt(2, userExists);
				success = addFriend.execute();
				
				if(success == true) 
					System.out.println("Problem adding pending friendship between " + friend + " and" + user);
			}
			
			this.friendsVec = this.getFriends(this.id);
			this.pendingVec = this.getPending(this.id);
			
		}
		catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			//close();
		}
		
		return true;
	}
	
	public boolean deleteFriend(String user, String friend) {
		
		try {
			
			int friendExists = this.userExists(friend);
			
			if(friendExists == -1) {
				this.error = friend + " is not a valid username.";
				close();
				return false;
			}
			
			int userExists = this.userExists(user);
			
			if(userExists == -1) {
				System.out.println(user + "is not a valid username.");
			}
			
			if(this.friendshipExists(userExists, friendExists) == false) {
				this.error = "Friendship does not exist. Cannot delete.";
				close();
				return false;
			}
			
			deleteFriend.setInt(1, userExists);
			deleteFriend.setInt(2, friendExists);
			boolean deleted = deleteFriend.execute();
			
			
			if(deleted == true)
				System.out.println("Problem deleting pending friendship between " + user + " and" + friend);
			
			deleteFriend.clearParameters();
			
			deleteFriend.setInt(1, friendExists);
			deleteFriend.setInt(2, userExists);
			deleted = deleteFriend.execute();
			
			if(deleted == true)
				System.out.println("Problem deleting pending friendship between " + friend + " and" + user);
			
			this.friendsVec = this.getFriends(this.id);
			this.pendingVec = this.getPending(this.id);
			
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			//close();
		}
		
		return true;
	}
	
	public ArrayList<friend> getFriends(int currentID) {
		
		ArrayList<friend> friendsList = new ArrayList<friend>();
		try {
			getFriends.setInt(1, currentID);
			friendSet = getFriends.executeQuery();
			
			while(friendSet.next()) {
				friendsList.add(new friend(friendSet.getString("name"), friendSet.getInt("userID")));
			}
			
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return friendsList;
	}
	
	public ArrayList<friend> getPending(int currentID) {
			
			ArrayList<friend> friendsList = new ArrayList<friend>();
			try {
				getFriends.setInt(1, currentID);
				friendSet = getFriends.executeQuery();
				
				while(friendSet.next()) {
					friendsList.add(new friend(friendSet.getString("name"), friendSet.getInt("userID")));
				}
				
			} catch(SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
			return friendsList;
		}
	
	
	public ArrayList<UserReview> getUserReviews(int currentID){
		ArrayList<UserReview> reviewList = new ArrayList<UserReview>();
		
		try {
			getUserReviews.setInt(1, currentID);
			reviewSet = getUserReviews.executeQuery();
			
			while(reviewSet.next()) {
				reviewList.add(new UserReview(reviewSet.getString("name"), reviewSet.getDouble("rating"), reviewSet.getString("review")));
			}
			
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return reviewList;
	}
	
	public int getClassID(String coursecode, String teacher) {
		int classID = -1;
		try {
			System.out.println("In getClassID --> t=" + teacher + ", cc=" + coursecode);
			checkClass.setString(1, coursecode);
			checkClass.setString(2, teacher);
			rs = checkClass.executeQuery();
			if(rs.next()) {
				classID = rs.getInt("classID");
			}
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return classID;
	}
	/*
	private final String addClassString = "INSERT INTO Classes(name, coursecode, teacher) VALUES(?, ?, ?)";
	private final String addReviewString = "INSERT INTO Reviews(classID, rating, review, userID) VALUES(?, ?, ?, ?)";
	private final String nameSearchString = "SELECT classID, name, coursecode, teacher FROM Classes WHERE name LIKE CONCAT('%', ?, '%')";
	private final String coursecodeSearchString = "SELECT classID, name, coursecode, teacher FROM Classes WHERE coursecode=?";
	private final String teacherSearchString = "SELECT classID, name, coursecode, teacher FROM Classes WHERE teacher LIKE CONCAT('%', ?, '%')";
	*/
	
	public int addClass(RatedClass c) {
		try {
			System.out.println("In addClass --> name=" + c.name + ", t="+ c.teacher + ", cc=" + c.coursecode);
			System.out.println(c.name.getClass());
			addClass.setString(1, c.name);
			addClass.setString(2, c.teacher);
			addClass.setString(3, c.coursecode);
			addClass.executeUpdate();
			rs = addClass.getGeneratedKeys();
			if(rs.next()) {
				
				int index = (int)rs.getInt(1);
				System.out.println(index);
				return index;
			}
//			return getClassID(c.coursecode, c.teacher);

		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return -1;
	}

	public void addReview(int classID, Review r) {
		try {
			addReview.setInt(1, classID);
			addReview.setDouble(2, r.rating);
			addReview.setString(3, r.review);
			addReview.setInt(4, r.userid);
			addReview.executeUpdate();
			loggedInUser.reviews = this.getUserReviews(loggedInUser.tableID);
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public void nameSearch(String query, ArrayList<SCholasticClass> classes) {
		try {
			System.out.println("Before name SEARCH");

			nameSearch.setString(1, query);
			rs = nameSearch.executeQuery();
			System.out.println("After name SEARCH");

			while (rs.next()) {
				int id = rs.getInt(rs.findColumn("classID"));
				RatedClass rc = new RatedClass(rs.getString("name"), rs.getString("coursecode"), rs.getString("teacher"));
				rc.id2 = id;
				classes.add(rc);
			}

		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public void coursecodeSearch(String query, ArrayList<SCholasticClass> classes) {
		try {
			System.out.println("Before COURSE CODE SEARCH");

			coursecodeSearch.setString(1, query);
			rs = coursecodeSearch.executeQuery();
			System.out.println("AFTER COURSE CODE SEARCH");
			while (rs.next()) {
				int id = rs.getInt(rs.findColumn("classID"));
				RatedClass rc = new RatedClass(rs.getString("name"), rs.getString("coursecode"), rs.getString("teacher"));
				rc.id2 = id;
				classes.add(rc);
			}

		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public void teacherSearch(String query, ArrayList<SCholasticClass> classes) {
		try {
			teacherSearch.setString(1, query);
			rs = teacherSearch.executeQuery();

			while (rs.next()) {
				int id = rs.getInt(rs.findColumn("classID"));		
				RatedClass rc = new RatedClass(rs.getString("name"), rs.getString("coursecode"), rs.getString("teacher"));
				rc.id2 = id;
				classes.add(rc);
			}

		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public ArrayList<Integer> getFriendsList(int uid) {
		ArrayList<Integer> results = new ArrayList<Integer>();
		try {
			getFriends.setInt(1, uid);
			rs = getFriends.executeQuery();

			while (rs.next()) {
				results.add(rs.getInt("userID"));
			}

		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return results;
	}
	
	public ArrayList<Review> getReviews(int classID){
		ArrayList<Review> results = new ArrayList<>();
		try {
			getReviews.setInt(1, classID);
			rs = getReviews.executeQuery();

			while (rs.next()) {
				results.add(new Review(classID, rs.getInt("userID"), rs.getDouble("rating"),rs.getString("review"), rs.getString("major")));
				System.out.println("Rating is: " + results.get(results.size()-1).rating);
			}

		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return results;
	}
	public User getUser(int userID) {
		User u = null; 
		try {
			getUser.setInt(1, userID);
			rs = getUser.executeQuery();
			if(rs.next()) {
				String name =  rs.getString("name");
				int tableID = userID;
				String username= rs.getString("username");
				String password = "";
				String email = rs.getString("email");
				String uni = rs.getString("university");
				String major = rs.getString("major");
				ArrayList<friend> friends = this.getFriends(userID);	//full names of all friends
				ArrayList<friend> pend = this.getPending(userID);
				//KEEP THIS BLANK PLZ
				ArrayList<UserReview> reviews = getUserReviews(userID); 
				u = new User(tableID,username, password, name, email,uni, major, friends ,reviews, pend);
			}
			
		}
		catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return u;
	}
}