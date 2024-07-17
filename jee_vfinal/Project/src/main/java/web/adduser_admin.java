package web;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * Servlet implementation class adduser_admin
 */
@WebServlet("/ad")
public class adduser_admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public adduser_admin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("nm");
        String password = request.getParameter("ps");
        String phone = request.getParameter("pn");
        String role = request.getParameter("role");
        String email = request.getParameter("ml");

        // Construire l'URL avec les paramètres
        String endpoint = "http://localhost:8081/web_services/rest/webservice/adduser";
        endpoint += "?name=" + URLEncoder.encode(name, "UTF-8");
        endpoint += "&email=" + URLEncoder.encode(email, "UTF-8");
        endpoint += "&password=" + URLEncoder.encode(password, "UTF-8");
        endpoint += "&phone=" + URLEncoder.encode(phone, "UTF-8");
        endpoint += "&role=" + URLEncoder.encode(role, "UTF-8");

        // Créer le client et envoyer la requête GET
        Client client = ClientBuilder.newClient();
        Response serviceResponse = client.target(endpoint)
                                        .request(MediaType.APPLICATION_JSON)
                                        .get();

        client.close();
        response.sendRedirect("/Project/admin.jsp");
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
