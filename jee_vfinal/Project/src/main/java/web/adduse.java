package web;

import javax.servlet.ServletException; 
import javax.servlet.ServletRequest;
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
import tools.DBInteraction;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.annoncedao;
import dao.comptedao;

/**
 * Servlet implementation class adduse
 */
@WebServlet("/aa")
public class adduse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public adduse() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
HttpSession sesi=request.getSession();
		annoncedao dao=new annoncedao();
		String suppParam = request.getParameter("supp");
		int rowId = Integer.parseInt(request.getParameter("rowId"));
		sesi.setAttribute("x",rowId);
		
		if("delete".equals(suppParam)) {
		    String serviceUrl = "http://localhost:8081/web_services/rest/webservice/removeannonce?id="+rowId ;
		    Client client = ClientBuilder.newClient();

		    Response serviceResponse = client.target(serviceUrl)
		                                    .request()
		                                    .delete();
		    client.close();

			response.sendRedirect("admin.jsp");	 
		 }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   
	}

	    

	}

	

