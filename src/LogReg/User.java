package LogReg;

import java.util.ArrayList;
import java.util.Vector;

import ReviewClass.Review;

public class User {	
	
	public int tableID;
	public String username;
	public String password;
	public String name;
	public String email;
	public String uni;
	public String major;
	public ArrayList<friend> friends;	//full names of all friends
	public ArrayList<UserReview> reviews;	//reviews made by user
	public ArrayList<friend> pendingFriends;
	
	
	public User(int i, String un, String pw, String n, String e, String u, String m, ArrayList<friend> f, ArrayList<UserReview> r, ArrayList<friend> p) {
		this.tableID = i;
		this.username = un;
		this.password = pw;
		this.name = n;
		this.email = e;
		this.uni = u;
		this.major = m;
		this.friends = f;
		this.reviews = r;
		this.pendingFriends = p;
	}
	
	public String toString() {
		return this.name + " " + this.email + " " + this.uni + " " + this.major;
	}
	
//	public void printFriends() {
//		for(int j = 0; j < this.friends.size(); ++j) {
//			System.out.println("Friend " + j + ": " + this.friends.get(j).toString());
//		}
//	}

}