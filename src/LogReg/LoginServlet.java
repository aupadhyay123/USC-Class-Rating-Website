package LogReg;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DatabaseManager dm = new DatabaseManager();
		boolean res = dm.validateUser(request.getParameter("loginUsername"), request.getParameter("loginPassword"));
		
		if(res == false) {
//			System.out.println(dm.error);
			request.setAttribute("loginError", dm.error);
			String temp = (String)request.getAttribute("loginError");
			response.sendRedirect("jspFiles/login.jsp?loginError=" + temp);
		}
		else {
			request.getSession().setAttribute("loggedInUser", dm.loggedInUser);		//set session user
			response.sendRedirect("jspFiles/profilePage.jsp");	
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}