package web;

import javax.servlet.ServletException; 

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import dao.annonce_etudiant_dao;
import dao.annoncedao;
import model.compte;
import tools.DBInteraction;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;
 
/**
 * Servlet implementation class delajt
 */
@WebServlet("/delajt")
public class delajt extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public delajt() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int rows = Integer.parseInt(request.getParameter("rows"));
        String rowName = request.getParameter("rowname");
        HttpSession session = request.getSession();
        compte user = (compte) session.getAttribute("user");

        if (user != null) {
            // Construire l'URL avec les paramètres
            String endpoint = "http://localhost:8081/web_services/rest/webservice/addetudiantannonce";
            endpoint += "?rows=" + rows;
            endpoint += "&rowname=" + URLEncoder.encode(rowName, "UTF-8");
            endpoint += "&userId=" + user.getId();
            endpoint += "&userName=" + URLEncoder.encode(user.getName(), "UTF-8");

            // Créer le client et envoyer la requête GET
            Client client = ClientBuilder.newClient();
            Response serviceResponse = client.target(endpoint)
                                            .request(MediaType.APPLICATION_JSON)
                                            .get();

            client.close();
            response.sendRedirect("/Project/accueil.jsp");
        } else {
            response.sendRedirect("/Project/Bocor/Bocor/index.html");
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String rowId = request.getParameter("rowId1");
            String supp = request.getParameter("supp");
            HttpSession p = request.getSession();
            p.setAttribute("id", rowId);
            HttpSession session = request.getSession();
            compte user = (compte) session.getAttribute("user");
            
            if (user != null) {
                // Construire l'URL avec les paramètres
                String endpoint = "http://localhost:8081/web_services/rest/webservice/processPostRequest";
                endpoint += "?rowId1=" + rowId;
                endpoint += "&supp=" + supp;
                endpoint += "&userId=" + user.getId();
                endpoint += "&role=" + URLEncoder.encode(user.getRole(), "UTF-8");
                
                // Créer le client et envoyer la requête GET
                Client client = ClientBuilder.newClient();
                Response serviceResponse = client.target(endpoint)
                                                .request(MediaType.TEXT_PLAIN)
                                                .get();

                // Récupérer le contenu de la réponse
                String responseContent = serviceResponse.readEntity(String.class);
                
                client.close();
                
                // Effectuer la redirection en fonction de la réponse du service
                if ("delete".equals(responseContent) || "delete_etudiant".equals(responseContent)) {
                    response.sendRedirect("/Project/accueil.jsp?annonce=mes&currentPage1=1");
                } else if ("edit".equals(responseContent)) {
                    response.sendRedirect("/Project/editannonce.jsp");
                } else if ("absence".equals(responseContent)) {
                    response.sendRedirect("/Project/abs.jsp");
                } else {
                    // Rediriger vers une page d'erreur en cas de réponse inattendue
                    response.sendRedirect("/Project/error.jsp");
                }
            } else {
                // Rediriger vers la page de connexion si l'utilisateur n'est pas connecté
                response.sendRedirect("/Project/Bocor/Bocor/index.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/Project/error.jsp");
        }
    }

}
