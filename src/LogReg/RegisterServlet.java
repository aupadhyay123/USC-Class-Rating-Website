package LogReg;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RegisterServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		if (nullCheck.isEmpty(request.getParameter("registerUsername"))) {
			request.setAttribute("registerError","Username field is empty");
			System.out.println(request.getAttribute("registerError"));
			//String temp = URLEncoder.encode("Username field is empty");
			String temp = (String) request.getAttribute("registerError");
			response.sendRedirect("jspFiles/register.jsp?registerError=" + temp);
			return;
		}
		
		if ((nullCheck.isEmpty(request.getParameter("registerPassword"))) || (nullCheck.isEmpty(request.getParameter("confirmPass"))) ) {
			
			request.setAttribute("registerError","Password fields must be filled");
			String temp = (String) request.getAttribute("registerError");
			response.sendRedirect("jspFiles/register.jsp?registerError=" + temp);

			//response.sendRedirect("jspFiles/register.jsp");
			return;
		}
		
		DatabaseManager dm = new DatabaseManager();
		
		boolean exists = dm.regCheck(request.getParameter("registerUsername"), request.getParameter("registerPassword"), request.getParameter("confirmPass"));
		
		if(exists == true) {
			request.setAttribute("registerError", dm.error);
			String temp = (String)dm.error;
			response.sendRedirect("jspFiles/register.jsp?registerError=" + temp);

			//response.sendRedirect("jspFiles/register.jsp");
			

			return;
		}
		else {
			request.setAttribute("registerUsername",request.getParameter("registerUsername"));
			request.setAttribute("registerPassword",request.getParameter("registerPassword"));
			request.setAttribute("confirmPass",request.getParameter("confirmPass"));
			
			response.sendRedirect("jspFiles/profileCreation.jsp");

			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}