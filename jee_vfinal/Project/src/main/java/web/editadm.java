package web;

import javax.servlet.ServletException; 
import tools.*;
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
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.comptedao;


/**
 * Servlet implementation class editadm
 */
@WebServlet("/ff")
public class editadm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editadm() {
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
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("x");
        
        // Construire l'URL avec les paramètres de requête
        String endpoint = "http://localhost:8081/web_services/rest/webservice/updatecompte";
        endpoint += "?id=" + id;
        endpoint += "&name=" + URLEncoder.encode(name, "UTF-8");
        endpoint += "&email=" + URLEncoder.encode(email, "UTF-8");
        endpoint += "&password=" + URLEncoder.encode(password, "UTF-8");
        endpoint += "&phone=" + URLEncoder.encode(phone, "UTF-8");
        endpoint += "&role=" + URLEncoder.encode(role, "UTF-8");
        
        // Créer le client et envoyer la requête GET
        Client client = ClientBuilder.newClient();
        Response serviceResponse = client.target(endpoint)
                                        .request(MediaType.APPLICATION_JSON)
                                        .get();

        // Lire la réponse de service
        String nextPage = serviceResponse.readEntity(String.class);
        client.close();

        // Effectuer la redirection en fonction de la réponse du service
        if (nextPage.equals("admin")) {
            response.sendRedirect("/Project/admin.jsp");
        } else if (nextPage.equals("editcmt")) {
            response.sendRedirect("/Project/editcmt.jsp");
        } else {
            // Rediriger vers une page d'erreur en cas de réponse inattendue
            response.sendRedirect("/Project/error.jsp");
        }
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int rowId = Integer.parseInt(request.getParameter("rowId"));
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            session.setAttribute("x", rowId);

            String serviceUrl = "http://localhost:8081/web_services/rest/webservice/deleteEditService";
            serviceUrl += "?rowId=" + rowId;
            
            if ("delete".equals(action)) {
                serviceUrl += "&supp=delete";
            } else if ("edit".equals(action)) {
                serviceUrl += "&edi=edit";
            }

            Client client = ClientBuilder.newClient();
            Response serviceResponse = client.target(serviceUrl)
                                             .request(MediaType.APPLICATION_JSON)
                                             .get();

            if (serviceResponse.getStatus() == 200) {
                String nextPage = serviceResponse.readEntity(String.class);
                client.close();

                if ("delete".equals(nextPage)) {
                    response.sendRedirect("/Project/admin.jsp");
                } else if ("edit".equals(nextPage)) {
                    response.sendRedirect("/Project/editcmt.jsp");
                } else {
                    response.sendRedirect("/Project/error.jsp");
                }
            } else {
                response.sendRedirect("/Project/error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/Project/error.jsp");
        }
    }


}
