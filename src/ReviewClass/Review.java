package ReviewClass;

import java.io.Serializable;

public class Review implements Serializable {
	
	private static final long serialVersionUID = 1L;
	public int id, classid, userid;
	public double rating;
	public String review, major;
	public boolean valid;

	public Review(int classid, int userid, double rating, String review, String major) {
		this.classid = classid;
		this.userid = userid;
		this.rating = rating;
		this.review = review;
		this.major = major;
	}

}
