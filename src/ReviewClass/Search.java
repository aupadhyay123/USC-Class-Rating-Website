package ReviewClass;

import java.util.ArrayList;
import java.util.Collections;

import LogReg.User;
import LogReg.DatabaseManager;

public class Search {

	// Base search method for logged in users.
	public static ArrayList<SCholasticClass> search(String query, String term, String major, String searchtype,
			User user) {
		ArrayList<SCholasticClass> results = initialSearch(query, term, major, searchtype);		
		
		if (user == null) {
			populateScores(major, results);
		} else {
			populateScores(user, results);
		}		
		
		Collections.sort(results);
		return results;
	}

	public static ArrayList<SCholasticClass> initialSearch(String query, String term, String major, String searchtype) {
		ArrayList<SCholasticClass> results = new ArrayList<>();
		// Get the list of classes
		if (searchtype.contains("coursecode")) {
			System.out.println("Search.claass --> coursecode search");
			results = Search.coursecodeSearch(query, term, major);
		} else if (searchtype.equals("teacher")) {
			results = Search.teacherSearch(query, term, major);
		} else if (searchtype.equals("name")) {
			results = Search.nameSearch(query, term, major);
		}
		System.out.println("initialSearch results.size():" + results.size());
		return results;
	}

	public static void populateScores(User u, ArrayList<SCholasticClass> results) {
		// For all rated classes, populate them with scores
		for (SCholasticClass sc : results) {
			
			if (sc instanceof RatedClass) {
				RatedClass rc = (RatedClass) sc;
				DatabaseManager db = new DatabaseManager();
				rc.addReviews(db.getReviews(rc.id2));
				db.close();
				rc.calculateScore(u);
			}
		}
	}

	public static void populateScores(String major, ArrayList<SCholasticClass> results) {
		// For all rated classes, populate them with scores
		for (SCholasticClass sc : results) {
			if (sc instanceof RatedClass) {
				RatedClass rc = (RatedClass) sc;
				DatabaseManager db = new DatabaseManager();
				rc.addReviews(db.getReviews(rc.id2));
				db.close();
				rc.calculateScore(major);
			}
		}
	}

	public static ArrayList<SCholasticClass> coursecodeSearch(String query, String term, String major) {
		ArrayList<SCholasticClass> results = new ArrayList<>();
		DatabaseManager db = new DatabaseManager();
		db.coursecodeSearch(query, results);
		db.close();
		SoC.coursecodeSearch(query, term, results);
		return results;
	}

	public static ArrayList<SCholasticClass> teacherSearch(String query, String term, String major) {
		ArrayList<SCholasticClass> results = new ArrayList<>();
		DatabaseManager db = new DatabaseManager();
		db.teacherSearch(query, results);
		db.close();
		SoC.teacherSearch(query, term, results);
		return results;
	}

	public static ArrayList<SCholasticClass> nameSearch(String query, String term, String major) {
		ArrayList<SCholasticClass> results = new ArrayList<>();
		DatabaseManager db = new DatabaseManager();
		db.nameSearch(query, results);
		db.close();
		SoC.nameSearch(query, term, results);
		return results;
	}

}