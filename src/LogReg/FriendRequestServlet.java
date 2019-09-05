package LogReg;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FriendRequestServlet")
public class FriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public FriendRequestServlet() {
        super();
 
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DatabaseManager dm = new DatabaseManager();
		
		
		System.out.println("In Servlet with: " + request.getParameter("requestingUser") + " " + request.getParameter("receivingUser"));
		
		boolean addedFriend = dm.addFriend(request.getParameter("requestingUser"), request.getParameter("receivingUser"), false);
		
		
		if(addedFriend == false) {
			response.getWriter().write(dm.error);
			return;
		}
		
		dm.close();
		
		
		response.getWriter().write("success");
		
//		request.getRequestDispatcher("/NewFile.jsp").forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
