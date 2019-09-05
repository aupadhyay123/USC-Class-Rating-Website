package LogReg;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AcceptServlet")
public class AcceptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public AcceptServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DatabaseManager dm = new DatabaseManager();
		
		int id = Integer.parseInt(request.getParameter("requestingUserID"));
		User requestee = dm.getUser(id);
		
		boolean acceptedFriend = dm.addFriend(requestee.username, request.getParameter("receivingUser"), true);
		
		if(acceptedFriend == false) {
			response.getWriter().write(dm.error);
			return;
		}
		
		User curr = (User)request.getSession().getAttribute("loggedInUser");
		curr.pendingFriends = dm.pendingVec;
		curr.friends = dm.friendsVec;
		
		dm.close();
		response.getWriter().write("success");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
