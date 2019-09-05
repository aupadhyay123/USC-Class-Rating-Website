package LogReg;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProfileCreation")
public class ProfileCreation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProfileCreation() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DatabaseManager dm = new DatabaseManager();
		String user = (String) request.getParameter("registerUsername");
		String pass = (String) request.getParameter("registerPassword");
		String conf = (String) request.getParameter("confirmPass");
		String name = (String)request.getParameter("credentialName");
		String email = (String) request.getParameter("credentialEmail");
		String university = (String) request.getParameter("credentialUniversity");
		String major = (String) request.getParameter("major");
//		if(name.trim().length() == 0) {
//			
//			System.out.println("FUCK YOU");
//		}
		//System.out.println("FUCK: " + request.getParameter("credentialName") + " "  + request.getParameter("credentialEmail")+ " " +  request.getParameter("credentialUniversity")+ " " + request.getParameter("major"));
		if((name.trim().length() == 0) || (email.trim().length() == 0) || (university.trim().length() == 0) || (major.trim().length() == 0)) {
			//System.out.println("FUCK YOU ASS");

			//request.setAttribute("profileError","Please fill in all of the fields");
			String temp = "Please fill in all of the fields";
			response.sendRedirect("jspFiles/profileCreation.jsp?profileError=" + temp);
			return;
		}
		
		dm.addUser(user, pass, conf,request.getParameter("credentialName"), 
				request.getParameter("credentialEmail"), request.getParameter("credentialUniversity"), request.getParameter("major"));
		
		if(dm.error != null && dm.error != "") {
			System.out.println(dm.error);
			request.setAttribute("profileError",dm.error);
			String temp = (String) request.getAttribute("profileError");
			response.sendRedirect("jspFiles/profileCreation.jsp?profileError=" + temp);
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