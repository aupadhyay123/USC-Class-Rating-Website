package ReviewClass;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import LogReg.User;


/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check if the parameters are filled out. If not, send an appropriate error
		// message to the response and return.
		
		System.out.println("In servlet");
		
		HttpSession ses = request.getSession();
		User user = null;

		if (ses != null && ses.getAttribute("loggedInUser") != null && ses.getAttribute("loggedInUser") instanceof User) {
			user = (User) ses.getAttribute("loggedInUser");
		}
		
		if (request.getParameter("query") == null || request.getParameter("query").trim().equals("")) {
			response.getWriter().write("!Query can not be empty");
			return;
		} else if (request.getParameter("term") == "Choose Term") {
			response.getWriter().write("!Term must be selected");
			return;
		} else if (request.getParameter("major") == "Choose Major") {
			response.getWriter().write("!Major must be selected");
			return;
		} else if (request.getParameter("searchby") == null || request.getParameter("searchby").trim().equals("")) {
			response.getWriter().write("!Search must specify a search type");
			return;
		}

		String query = request.getParameter("query");
		String term = request.getParameter("term");
		String major = request.getParameter("major");
		String searchtype = request.getParameter("searchby");
		
		
		
		System.out.println("In serv:" + query + " " + term + " " + major + " " + searchtype + " " + user);
		
		
		
		ArrayList<SCholasticClass> results = Search.search(query, term, major, searchtype, user);
		
		if(searchtype.equals("coursecode")) {
			searchtype = "Course Code";
		} else if(searchtype.equals("Teacher")) {
			searchtype = "Course Instructor";
		} else {
			searchtype = "Course Name";
		}
		Gson gson = new Gson();
		ses.setAttribute("query", query);
		ses.setAttribute("searchby", searchtype);
		ses.setAttribute("results", gson.toJson(results));
		ses.setAttribute("term", term);
		
		String temp = (String)ses.getAttribute("results");
		System.out.println("results:" + temp);
		
		//response.sendRedirect("jspFiles/searchResults.jsp");
//		RequestDispatcher dis = getServletContext().getRequestDispatcher("/jspFiles/searchResults.jsp");
//		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}