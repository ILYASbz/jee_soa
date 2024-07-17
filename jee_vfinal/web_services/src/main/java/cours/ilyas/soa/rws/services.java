package cours.ilyas.soa.rws;
import java.sql.ResultSet;    
import java.sql.SQLException;
import javax.ws.rs.*;
import javax.ws.rs.core.*;

import dao.absence_dao;
import dao.annoncedao;
import dao.comptedao;
import model.Data;
import model.compte;
import tools.DBInteraction;

import javax.json.bind.*;




@Path("/webservice")
public class services {
	 @GET
	 @Path("/authen/{email}/{pass}")
	 @Produces(MediaType.APPLICATION_JSON)
	    public Response check(@PathParam("email") String name, @PathParam("pass") String pass) {
	     DBInteraction.connect();
	  comptedao d = new comptedao();
	  
	  Jsonb jsonb = JsonbBuilder.create();

	  String json="non compte";
	    if (d.check(name, pass)) {
	        compte c = d.findbyEmail(name,pass);
	         json = jsonb.toJson(c);

	        if ((c.getRole()).equals("admin")) {
                return Response.ok(json).build();
	        } else {
                return Response.ok(json).build();
	        }
	    } else {
            return Response.ok(json).build();
	    }
	 }
	 
	 @POST
	    @Produces(MediaType.APPLICATION_JSON)
	    @Path("/adduser")
	    public Response add(
	        @FormParam("nm") String name,
	        @FormParam("ps") String password,
	        @FormParam("pn") String phone,
	        @FormParam("ml") String email,
	        @FormParam("rl") String role){
		 Jsonb jsonb = JsonbBuilder.create();
		 DBInteraction.connect();
		    ResultSet rs= DBInteraction.Select("select * from comptes where Email='"+email+"' and password='"+password+"' ");
		    try {
				if(rs.next()) {
					int a=0;
				      String json = jsonb.toJson(a);

	                return Response.ok(json).build();


				}else {
		    compte h=new compte( name, email, password, phone, role);
	        comptedao ra=new comptedao();
	         ra.adduser(h);
	         int a=1;
		      String json = jsonb.toJson(a);
                return Response.ok(json).build();

}
		    } catch (SQLException e) {
				e.printStackTrace();
			}
			return null;
	    }
	
	 
	 @DELETE
	    @Path("/removeabs")
	    public Response deleteUser(@QueryParam("name") String name, @QueryParam("date") String date) {
	       
		 absence_dao dao=new absence_dao();
			dao.delete_absence(name,date);
	        return Response.ok().build();
	    }
	 @Path("/addabs")
	 public class AddAbsenceEndpoint {

	     @POST
	     @Consumes(MediaType.APPLICATION_JSON)
	     public Response processPostRequest(String requestBody) {
	         Jsonb jsonb = JsonbBuilder.create();

	         // Désérialisation du corps de la requête JSON
	         Data requestData = jsonb.fromJson(requestBody, Data.class);

	         absence_dao dao = new absence_dao();
	         dao.add_absence(Integer.parseInt(requestData.getUserId()), requestData.getElements(), requestData.getDate());

	         return Response.ok().build();
	     }}


	 @PUT
	 @Path("/updateuser")
	 @Consumes(MediaType.APPLICATION_JSON)
	 public Response updateUser(compte c) {
		 comptedao r = new comptedao();
		    r.updatecompte(c);
	     return Response.ok().build();
	 }
	 @DELETE
	    @Path("/removeannonce")
	    public Response deleteUser(@QueryParam("id") int id) {
	       annoncedao dao=new annoncedao();
			dao.deleteannonce(id);
	        return Response.ok().build();
	    }
	 @POST
	 @Path("/adduser")
	 @Produces(MediaType.APPLICATION_JSON)
	 public Response addUser(compte c) {
	     DBInteraction.connect();
	     ResultSet rs = DBInteraction.Select("select * from comptes where Email='" + c.getEmail() + "' and password='" + c.getPassword() + "' ");
	     try {
	         if (rs.next()) {
	           
	             return Response.ok().build();
	         } else {
	             comptedao ra = new comptedao();
	             ra.adduser(c);
	            
	             return Response.ok().build();
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }

	     return Response.ok().build();
	 }

}
