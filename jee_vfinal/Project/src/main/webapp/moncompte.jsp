<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="tools.DBInteraction"%>
    <%@page import="model.compte"%>
        <%@page import="dao.*"%>
    
    
<!DOCTYPE html>
<html>

  <head>
  	<title>Mon Compte</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="/Project/Bocor/Bocor/assets/img/jkl.png" rel="icon">

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	<link href="/Project/login-form-20" rel="stylesheet">
	

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="/Project/login-form-20/css/style.css">

	</head>
	<body class="img js-fullheight" style="background-image: url(/Project/login-form-20/images/klo.jpg);">
	<header id="header">
<div class="logo">
<a href="accueil.jsp"><img src="/Project/Bocor/Bocor/assets/img/lo.png" alt=""  width="200px" ></a>
</div>
</header>
	
	<% 
HttpSession s=request.getSession();
compte c=(compte)s.getAttribute("user");
if(c==null){
	response.sendRedirect("/Project/authen.jsp");
	
}
%>
<%
if(c!=null){
	%>
	<section class="ftco-section" style="margin-left: 30%;">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">Mon Compte</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<h3 class="mb-4 text-center"></h3>
		      	<form action="moncmt" class="signin-form" method="post">
		      		<div class="form-group">
		      			<input type="text" class="form-control" placeholder="Username" name="nm" 
value="<%= c.getName() %>"
																								    required>
						  </div>
		      					      		<div class="form-group">
		      			<input type="text" class="form-control" placeholder="phone" name="pn" 
      value="<%= c.getPhone() %>"
  required></div>
		      		   		      		<div class="form-group">
		      		    <input type="text" class="form-control" placeholder="email" name="ml" 
      value="<%= c.getEmail() %>"
   required>
		      		</div>
	            <div class="form-group">
	              <input id="password-field" type="text" class="form-control" name="ps" placeholder="Password" 
      value="<%= c.getPassword() %>"
  required>
	            </div>
	            <div class="form-group">
	            <input type="hidden" name="role" value="etudiant" />
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
	<%} %>

	<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
</html>