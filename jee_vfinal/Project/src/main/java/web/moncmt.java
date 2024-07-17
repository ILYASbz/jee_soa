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

import model.compte;
import tools.DBInteraction;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.annoncedao;
import dao.comptedao;

/**
 * Servlet implementation class moncmt
 */
@WebServlet("/moncmt")
public class moncmt extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public moncmt() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name=(String)request.getParameter("nm");
		String prix=(String)request.getParameter("pr");
		String jour=(String)request.getParameter("jr");
		String temp=(String)request.getParameter("tp");
		String duree=(String)request.getParameter("duree");
		String nbmax=(String)request.getParameter("nb");
		String niveau=(String)request.getParameter("nv");
         HttpSession s=request.getSession();
         compte c=(compte)s.getAttribute("user");
         HttpSession p=request.getSession();
         String i=(String)p.getAttribute("id");
         int id=Integer.parseInt(i);
         
         HttpSession session = request.getSession();
 	    String serviceUrl = "http://localhost:8081/web_services/rest/webservice/editAnnounceService";

 	    // Construire les paramètres de formulaire pour le service REST
 	     serviceUrl += "?nm=" + URLEncoder.encode(name, "UTF-8");
 	    serviceUrl += "&pr=" + URLEncoder.encode(prix, "UTF-8");
 	    serviceUrl += "&jr=" + URLEncoder.encode(jour, "UTF-8");
 	    serviceUrl += "&tp=" + URLEncoder.encode(temp, "UTF-8");
 	    serviceUrl += "&duree=" + URLEncoder.encode(duree, "UTF-8");
 	    serviceUrl += "&nb=" + URLEncoder.encode(nbmax, "UTF-8");
 	    serviceUrl += "&nv=" + URLEncoder.encode(niveau, "UTF-8");
 	    serviceUrl += "&id=" + URLEncoder.encode(i, "UTF-8");



 	    // Récupérer l'URL du service REST

 	    Client client = ClientBuilder.newClient();
         Response serviceResponse = client.target(serviceUrl)
                                         .request(MediaType.APPLICATION_JSON)
                                         .get();
         
		response.sendRedirect("/Project/accueil.jsp?annonce=mes");

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String name=request.getParameter("nm");
	    String password=request.getParameter("ps");
	    String phone=request.getParameter("pn");
	    String role=request.getParameter("role");
	    String email=request.getParameter("ml");
        comptedao r=new comptedao();
        HttpSession s=request.getSession();
        compte c=(compte)s.getAttribute("user");
        if(c!=null){
        	String endpoint = "http://localhost:8081/web_services/rest/webservice/updateusercmp";
            endpoint += "?id=" + c.getId();
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
            if (nextPage.equals("moncompte")) {
                response.sendRedirect("/Project/moncompte.jsp");
            } else  {
   	         compte a=new compte(c.getId(), name, email, password, phone, role);
   	         s.setAttribute("user", a);

                response.sendRedirect("/Project/accueil.jsp");
            
            }
        
        
        }else {	response.sendRedirect("/Project/Bocor/Bocor/index.html");
}
	
	}

}
