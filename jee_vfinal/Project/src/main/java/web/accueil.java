package web;

import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import model.compte;

import java.io.IOException;

import dao.comptedao;

/**
 * Servlet implementation class accueil
 */
@WebServlet("/accueil")
public class accueil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public accueil() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession s=request.getSession();
        s.invalidate();
        response.sendRedirect("/Project/authen.jsp");
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String name = request.getParameter("nm");
	    String password = request.getParameter("ps");
	    String phone = request.getParameter("pn");
	    String role = request.getParameter("role");
	    String email = request.getParameter("ml");
	    int id = Integer.parseInt(request.getParameter("id"));

	    compte c = new compte(id, name, email, password, phone, role);

	    Client client = ClientBuilder.newClient();

	    Response serviceResponse = client.target("http://localhost:8081/web_services/rest/webservice/updateuser")
	                                     .request(MediaType.APPLICATION_JSON)
	                                     .put(Entity.json(c));

	    client.close();

	    response.sendRedirect("accueil.jsp");
	}

}
