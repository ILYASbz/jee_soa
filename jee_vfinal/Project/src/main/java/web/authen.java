package web;
import javax.json.bind.*;  

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Form;

import javax.ws.rs.client.Client; 
import javax.ws.rs.client.WebTarget;
import javax.json.bind.Jsonb;
import javax.json.bind.JsonbBuilder;
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.WebTarget;

import model.compte;
import tools.DBInteraction;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.comptedao;

@WebServlet("/authen")
public class authen extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 
     * @see HttpServlet#HttpServlet()
     */
	comptedao d;
	
    public authen() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("nm");
        String password = request.getParameter("ps");
        String phone = request.getParameter("pn");
        String email = request.getParameter("ml");

        Client client = javax.ws.rs.client.ClientBuilder.newClient(); 

        // Définition du rôle (je suppose que c'est un étudiant)
        String role = "etudiant";
        compte compte = new compte(name, email, password, phone, role); // Assuming Compte class constructor exists

        // Envoi d'une requête GET avec les paramètres à l'URL d'ajout d'utilisateur
        Response serviceResponse = client.target("http://localhost:8081/web_services/rest/webservice/addusers")
                                         .queryParam("name", name)
                                         .queryParam("email", email)
                                         .queryParam("password", password)
                                         .queryParam("phone", phone)
                                         .request(MediaType.APPLICATION_JSON)
                                         .get();
        
        // Vérification de la réponse JSON pour décider de la redirection
        if (serviceResponse.getStatus() == 200) {
            String jsonResponse = serviceResponse.readEntity(String.class);
            if ("0".equals(jsonResponse)) {
                response.sendRedirect("sign.jsp");
            } else {
                response.sendRedirect("authen.jsp");
            }
        } else {
            // En cas d'erreur de communication avec le service, redirection vers une page d'erreur
            response.sendRedirect("index.html");
        }

        // Fermeture du client
        client.close();
    }



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("psw");
        
        // Utilisation de la classe ClientBuilder pour créer un client JAX-RS
        Client client = ClientBuilder.newClient(); 
        
        // Construction de l'URL avec les paramètres d'authentification
        String url = "http://localhost:8081/web_services/rest/webservice/authen/" + email + "/" + password;

        // Envoi d'une requête GET pour récupérer les informations d'authentification
        Response serviceResponse = client.target(url)
                                        .request(MediaType.APPLICATION_JSON)
                                        .get();
        
        // Vérification du code de statut de la réponse
        if (serviceResponse.getStatus() == 200) {
            String json = serviceResponse.readEntity(String.class);
            
            // Conversion du JSON en objet Java (compte)
            Jsonb jsonb = JsonbBuilder.create();
            compte user = jsonb.fromJson(json, compte.class);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Redirection en fonction du rôle de l'utilisateur
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("admin.jsp");
                    return;
                } else if ("etudiant".equals(user.getRole()) || "professeur".equals(user.getRole())) {
                    response.sendRedirect("accueil.jsp");
                    return;
                }
            }
        }
        
        // Redirection vers la page d'authentification en cas d'échec
        response.sendRedirect("authen.jsp");
    }
}



