package web;

import javax.json.bind.Jsonb;
import javax.json.bind.JsonbBuilder;
import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Form;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;



import dao.absence_dao;
import tools.DBInteraction;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

/**
 * Servlet implementation class abs
 */
@WebServlet("/abs")
public class abs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public abs() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name=request.getParameter("rowId");
		String date=request.getParameter("rowId2");
	    String encodedName = URLEncoder.encode(name, StandardCharsets.UTF_8.toString());
	    String encodedDate = URLEncoder.encode(date, StandardCharsets.UTF_8.toString());
	    
	    String serviceUrl = "http://localhost:8081/web_services/rest/webservice/removeabs?name=" + encodedName + "&date=" + encodedDate;

	    Client client = ClientBuilder.newClient();

	    Response serviceResponse = client.target(serviceUrl)
	                                    .request()
	                                    .delete();
	    
		response.sendRedirect("admin.jsp");
	    client.close();

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */

	// Client (Servlet)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String elements [] =request.getParameterValues("ele");
        String date=request.getParameter("date");
        HttpSession p = request.getSession();
        	String a=(String)p.getAttribute("id");
        	int b=Integer.parseInt(a);
        	absence_dao dao=new absence_dao();
        	dao.add_absence(b, elements, date);
        
        response.sendRedirect("/Project/accueil.jsp");
	}




}
