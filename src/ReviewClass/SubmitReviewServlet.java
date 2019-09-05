package ReviewClass;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import LogReg.DatabaseManager;
import LogReg.User;


@WebServlet("/SubmitReviewServlet")
public class SubmitReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession ses = request.getSession();
		User u = null;

		if (ses != null && ses.getAttribute("loggedInUser") != null && ses.getAttribute("loggedInUser") instanceof User) {
			u = (User) ses.getAttribute("loggedInUser");
		} else {
			response.getWriter().write("Must be a Register User to rate a class.");
			return;
		}

		int uid = u.tableID;

		// Check if the parameters are filled out. If not, send an appropriate error
		// message to the response and return.
		
		System.out.println(request.getParameter("rating"));
		System.out.println(request.getParameter("coursecode"));
		System.out.println(request.getParameter("teacher"));
		System.out.println(request.getParameter("term"));
		System.out.println(request.getParameter("name"));
		

		
		if (request.getParameter("rating") == null || request.getParameter("rating").trim().equals("")) {
			response.getWriter().write("Rating can not be empty");
			return;
		} else if (request.getParameter("coursecode") == null || request.getParameter("coursecode").trim().equals("")) {
			response.getWriter().write("Course Code can not be empty");
			return;
		} else if (request.getParameter("teacher") == null || request.getParameter("teacher").trim().equals("")) {
			response.getWriter().write("Teacher can not be empty");
			return;
		} 
//		else if (request.getParameter("term") == null || request.getParameter("term").trim().equals("")) {
//			response.getWriter().write("Term can not be empty");
//			return;
//		}

		// If all of the parameters are filled, load them into variables
		double rating = -1;
		
		String coursecode = request.getParameter("coursecode");
		String teacher = request.getParameter("teacher");
		String term = request.getParameter("term");
		String review = "";
		
		String name = request.getParameter("name");

		// Non-required parameter review should be loaded in if it exists
		if (request.getParameter("review") != null && !request.getParameter("review").trim().equals("")) {
			review = request.getParameter("review");
		}

		// If the rating can not be parsed to a double, send an appropriate error
		// message to the response and return.
		try {
			rating = Double.parseDouble(request.getParameter("rating"));
		} catch (NumberFormatException e) {
			response.getWriter().write("Rating must be a number");
			return;
		}
		
		
		if(rating < 0 || rating > 5) {
			response.getWriter().write("Rating must be in range [0.0 --> 5.0]");
			return;
		}
		// Check if class exists in the database
		DatabaseManager db = new DatabaseManager();
		db.loggedInUser = u;
		int classID = db.getClassID(coursecode, teacher);
		// If not, create a class in the database
		
		System.out.println("before classID check --> classID = " + classID);
		if (classID == -1) {
			RatedClass c = new RatedClass(name, coursecode, teacher);
			System.out.println(c.name + " : " + c.coursecode);
			classID = db.addClass(c);
		}
		Review r = new Review(classID, uid, rating, review, u.major);

		// Add the review to the database
		System.out.println("AFTERRRRF*CK classID check --> classID = " + classID);

		db.addReview(classID, r);
		
		// Close the connection
		db.close();
		
		System.out.println("Got Here");
		response.getWriter().write("success");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}