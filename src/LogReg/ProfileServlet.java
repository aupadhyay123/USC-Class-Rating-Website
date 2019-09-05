package LogReg;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		if(request.getParameter("userID") == null || request.getParameter("userID").trim().length() == 0) {
			//This is a request dispatcher method, look how John did it
			response.sendRedirect("jspFiles/profile.jsp");
		}
		int uid = 0;
		try{
			uid = Integer.parseInt(request.getParameter("userID"));
		}
		catch(NumberFormatException e) {
			response.sendRedirect("jspFiles/profile.jsp");
		}
		
		DatabaseManager db = new DatabaseManager();
		User u = db.getUser(uid);
		Gson gson = new Gson();
		String temp = URLEncoder.encode(gson.toJson(u));
		
		response.sendRedirect("jspFiles/friends.jsp?profile=" + temp);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
