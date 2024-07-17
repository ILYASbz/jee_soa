<%@page import="java.sql.ResultSet"%>
<%@page import="tools.DBInteraction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@page import="model.*"%>
    
<!DOCTYPE html>
<html>
<head>
<title>edit annonce</title>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="/Project/Bocor/Bocor/assets/img/jkl.png" rel="icon">

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	<link href="/Project/login-form-20" rel="stylesheet">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="/Project/login-form-20/css/style.css">
<style type="text/css">
.form-control option {
  background-color: #0E5D6A;
  color: white; 
}
</style>
</head>
<body class="img js-fullheight" style="background-image: url(/Project/login-form-20/images/klo.jpg);">
<header id="header">
<div class="logo">
<a href="accueil.jsp"><img src="/Project/Bocor/Bocor/assets/img/lo.png" alt=""  width="200px" ></a>
</div>
</header>

<%HttpSession s=request.getSession();
compte c=(compte)s.getAttribute("user");
if(c==null){
	response.sendRedirect("/Project/authen.jsp");
	
}
HttpSession p=request.getSession();
String i=(String)p.getAttribute("id");
int id=0;
if(i!=null){
id=Integer.parseInt(i);}

DBInteraction.connect();
ResultSet rs=DBInteraction.Select("select * from annonces where ID="+id);
annonce an=new annonce();
if(rs.next()){
	an=new annonce(rs.getString(2),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(8),rs.getString(10));
	
}

DBInteraction.disconnect();
String ch=an.getDate();
String[] parties = ch.split(" "); 
String jour = parties[0]; 
String temp = parties[1];
String prix = an.getPrix().split("\\s+")[0];
%>  
<section class="ftco-section" style="margin-left: 30%;">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">Éditer Annonce</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<h3 class="mb-4 text-center"></h3>
		      	<form action="moncmt" method="get" class="signin-form">
		      		<div class="form-group">
		      			<label >Nom Cours:</label>
		      			<input type="text" class="form-control" placeholder="Name" name="nm" value="<%=an.getName() %>"  required></div>
		      					      					      		<div class="form-group">
		      		
		      			<label >Prix:</label>
		      			<input type="number" class="form-control" placeholder="Prix" name="pr" value="<%=prix %>"  required></div>
		      					      				      		
		      					      		<div class="form-group">
		      		<label for="b">jour:</label>
					    <select id="b" class="form-control"   name="jr" required >
					        <option value="lundi" <%=(jour.equals("lundi")) ? "selected" : "" %> >Lundi</option>
					        <option value="mardi"  <%=(jour.equals("mardi")) ? "selected" : "" %> >Mardi</option>
					        <option value="mercredi"  <%=(jour.equals("mercredi")) ? "selected" : "" %> >Mercredi</option>
					        <option value="jeudi"  <%=(jour.equals("jeudi")) ? "selected" : "" %>  >Jeudi</option>
					        <option value="vendredi"  <%=(jour.equals("vendredi")) ? "selected" : "" %>>Vendredi</option>
					        <option value="samedi"  <%=(jour.equals("samedi")) ? "selected" : "" %>  >Samedi</option>
					        <option value="dimanche"  <%=(jour.equals("dimanche")) ? "selected" : "" %>  >Dimanche</option>
					    </select>		</div>      		   		      		
					    <div class="form-group">
				   <label >temp:</label>
	      		
				      <input type="time" class="form-control" placeholder="temps" name="tp" value="<%=temp %>" required>
		      		</div>
	            <div class="form-group">
	            <label for="a">durée:</label>
                         <select id="a" class="form-control"   name="duree" required >
					        <option value="1h" <%=(an.getDuree().equals("1h")) ? "selected" : ""%>>1h</option>
					        <option value="1h30" <%=(an.getDuree().equals("1h30")) ? "selected" : ""%>>1h30</option>
					        <option value="2h" <%=(an.getDuree().equals("2h")) ? "selected" : ""%>>2h</option>
					        <option value="2h30" <%=(an.getDuree().equals("2h30")) ? "selected" : ""%>>2h30</option>
					        <option value="3h" <%=(an.getDuree().equals("3h")) ? "selected" : ""%>>3h</option>
					        
					    </select>		</div> <div class="form-group">
					    <label >nombre etudiants max:</label>	
					  <input type="number" class="form-control" placeholder="nbmax" name="nb" value="<%=an.getNombre_etudiants_max() %>" required>
					  </div>      		   		      		
					    <div class="form-group">
					    <label >Niveau:</label>	
					  <input type="text" class="form-control" placeholder="Niveau" name="nv" value="<%=an.getNiveau() %>" required>
					  </div>
	            <div class="form-group">
	            	<button type="submit" class="form-control btn btn-primary submit px-3">Confirm</button>
	            </div>
	           
	          </form>
	        
		      </div>
				</div>
			</div>
		</div>
	</section>





<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
</body>
</html>