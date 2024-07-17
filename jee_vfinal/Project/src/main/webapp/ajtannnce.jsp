<%@page import="java.sql.ResultSet"%>
<%@page import="tools.DBInteraction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@page import="model.*"%>
       <%@page import="web.*"%>
        
    
<!DOCTYPE html>
<html>
<head>
<title>Ajouter Annonce</title>
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
%>  
<section class="ftco-section" style="margin-left: 30%;">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">Ajouter Annonce</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<h3 class="mb-4 text-center"></h3>
		      	<form action="gg" method="post" class="signin-form">
		      		<div class="form-group">
		      			<label >Nom Cours:</label>
		      			<input type="text" class="form-control" placeholder="Name" name="nm"  required></div>
		      					      					      		<div class="form-group">
		      		
		      			<label >Prix:</label>
		      			<input type="number" class="form-control" placeholder="Prix" name="pr"  required></div>
		      					      				      		
		      					      		<div class="form-group">
		      		<label for="b">jour:</label>
					    <select id="b" class="form-control"   name="jr" required >
					        <option value="lundi">Lundi</option>
					        <option value="mardi">Mardi</option>
					        <option value="mercredi">Mercredi</option>
					        <option value="jeudi">Jeudi</option>
					        <option value="vendredi">Vendredi</option>
					        <option value="samedi">Samedi</option>
					        <option value="dimanche">Dimanche</option>
					    </select>		</div>      		   		      		
					    <div class="form-group">
				   <label >temp:</label>
	      		
				      <input type="time" class="form-control" placeholder="temps" name="tp" required>
		      		</div>
	            <div class="form-group">
	            <label for="a">durée:</label>
                         <select id="a" class="form-control"   name="duree" required >
					        <option value="1h">1h</option>
					        <option value="1h30">1h30</option>
					        <option value="2h">2h</option>
					        <option value="2h30">2h30</option>
					        <option value="3h">3h</option>
					        
					    </select>		</div> <div class="form-group">
					    <label >nombre etudiants max:</label>	
					  <input type="number" class="form-control" placeholder="nbmax" name="nb" value="" required>
					  </div>      		   		      		
					    <div class="form-group">
					    <label >Niveau:</label>	
					  <input type="text" class="form-control" placeholder="Niveau" name="nv" value="" required>
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