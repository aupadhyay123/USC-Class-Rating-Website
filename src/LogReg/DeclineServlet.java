package LogReg;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeclineServlet")
public class DeclineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeclineServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DatabaseManager dm = new DatabaseManager();
		
		int id = Integer.parseInt(request.getParameter("requestingUserID"));
		User requestee = dm.getUser(id);
		
		boolean deletedFriend = dm.deleteFriend(requestee.username, request.getParameter("receivingUser"));
		
		if(deletedFriend == false) {
			response.getWriter().write(dm.error);
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
