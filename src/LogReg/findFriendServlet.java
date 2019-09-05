package LogReg;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/findFriendServlet")
public class findFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public findFriendServlet() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String user = request.getParameter("receivingUser");
		
		DatabaseManager dm = new DatabaseManager();
		int id = dm.userExists(user);
		
		if(id == -1) {
			response.getWriter().write(dm.error);
			return;
		}
		
		User friend = dm.getUser(id);
		 
		if(friend == null) {
			response.getWriter().write("User not found in database.");
			return;
		}
		request.getSession().setAttribute("foundFriend", friend);
		dm.close();
		
		response.getWriter().write("success");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
