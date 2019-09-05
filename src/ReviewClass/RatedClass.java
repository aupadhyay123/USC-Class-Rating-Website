package ReviewClass;

import java.util.ArrayList;

import LogReg.DatabaseManager;
import LogReg.User;

public class RatedClass extends SCholasticClass {
	
	static final long serialVersionUID = 1L;
	public ArrayList<Review> reviews;
	public double score;
	public int id2;

	public RatedClass(String name, String coursecode, String teacher) {
		super(name, coursecode, teacher);
		this.rated = true;
	}

	public void addReviews(ArrayList<Review> reviews) {
		this.reviews = reviews;
	}
	
	public boolean isFriend(int uid, ArrayList<Integer> friendsList) {
		for(Integer i: friendsList) {
			if(((int)i)==uid) {
				return true;
			}
		}
		return false;
	}

	public void calculateScore(User u) {
		DatabaseManager db = new DatabaseManager();
		ArrayList<Integer> friends = db.getFriendsList(u.tableID);
		double friendsRating, majRating, rating;
		if(reviews!=null) {
			double friendnum=0, frienddenom=0;
			double majnum=0, majdenom=0;
			double num=0, denom = 0;
			for(Review r: reviews) {
				num+=r.rating;
				denom++;
				if(isFriend(r.userid, friends)) {
					friendnum+=r.rating;
					frienddenom++;
				}
				if(r.major.equals(u.major)) {
					majnum+=r.rating;
					majdenom++;
				}
			}
			rating = (num != 0) ? num/denom : 0;
			friendsRating = (friendnum != 0) ? friendnum/frienddenom : 0;
			majRating = (majnum != 0) ? majnum/majdenom: 0;
			if(friendsRating==0 && majRating==0)
				this.score = rating;
			else if(friendsRating==0)
				this.score = .6*majRating + .4*rating;
			else if(majRating==0)
				this.score = .6*friendsRating + .4*rating;
			this.score = .4*friendsRating + .4*majRating + .2*rating;
			
		}
	}

	public void calculateScore(String major) {
		double majRating, rating;
		if(reviews!=null) {
			double majnum=0, majdenom=0;
			double num=0, denom = 0;
			for(Review r: reviews) {
				num+=r.rating;
				denom++;
				if(r.major.equals(major)) {
					majnum+=r.rating;
					majdenom++;
				}
			}
			rating = (num != 0) ? num/denom : 0;
			majRating = (majnum != 0) ? majnum/majdenom : 0;
			if(majRating==0)
				this.score = rating;
			else
				this.score = .6*majRating + .4*rating;
		}
	}
}