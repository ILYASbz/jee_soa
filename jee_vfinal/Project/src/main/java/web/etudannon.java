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
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class etudannon
 */
@WebServlet("/gg")
public class etudannon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public etudannon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
		
		String suppParam = request.getParameter("supp");
		int rowIdan = Integer.parseInt(request.getParameter("rowIdan"));
		int rowIdet = Integer.parseInt(request.getParameter("rowIdet"));
		
		 String serviceUrl = "http://localhost:8081/web_services/rest/webservice/deleteEtudannon";
	        serviceUrl += "?suppParam=" + suppParam;
	        serviceUrl += "&rowIdan=" + rowIdan;
	        serviceUrl += "&rowIdet=" + rowIdet;
	        
	        Client client = ClientBuilder.newClient();
	        Response serviceResponse = client.target(serviceUrl)
	                                        .request(MediaType.APPLICATION_JSON)
	                                        .get();
	        
	        String nextPage = serviceResponse.readEntity(String.class);
	        client.close();
	        
	        
		if(nextPage.equals("edit")) {
			response.sendRedirect("admin.jsp");
			 
		 }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String name = request.getParameter("nm");
	    String prix = request.getParameter("pr");
	    String jour = request.getParameter("jr");
	    String temp = request.getParameter("tp");
	    String duree = request.getParameter("duree");
	    String nbmax = request.getParameter("nb");
	    String niveau = request.getParameter("nv");
	    HttpSession s=request.getSession();
        compte c=(compte)s.getAttribute("user");
        String d = String.valueOf(c.getId());
        
	    HttpSession session = request.getSession();
	    String serviceUrl = "http://localhost:8081/web_services/rest/webservice/addAnnounceService";

	    // Construire les paramètres de formulaire pour le service REST
	     serviceUrl += "?nm=" + URLEncoder.encode(name, "UTF-8");
	    serviceUrl += "&pr=" + URLEncoder.encode(prix, "UTF-8");
	    serviceUrl += "&jr=" + URLEncoder.encode(jour, "UTF-8");
	    serviceUrl += "&tp=" + URLEncoder.encode(temp, "UTF-8");
	    serviceUrl += "&duree=" + URLEncoder.encode(duree, "UTF-8");
	    serviceUrl += "&nb=" + URLEncoder.encode(nbmax, "UTF-8");
	    serviceUrl += "&nv=" + URLEncoder.encode(niveau, "UTF-8");
	    serviceUrl += "&id=" + URLEncoder.encode(d, "UTF-8");
	    serviceUrl += "&nom=" + URLEncoder.encode(c.getName(), "UTF-8");



	    // Récupérer l'URL du service REST

	    Client client = ClientBuilder.newClient();
        Response serviceResponse = client.target(serviceUrl)
                                        .request(MediaType.APPLICATION_JSON)
                                        .get();
        
        
	    // Écrire les paramètres dans le corps de la requête
        response.sendRedirect("/Project/accueil.jsp?annonce=mes");
	}

}
