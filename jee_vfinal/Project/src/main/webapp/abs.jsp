<%@page import="java.sql.ResultSet"%>
<%@page import="tools.DBInteraction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@page import="model.*"%>
         <%@page import="web.*"%>
        
    
<!DOCTYPE html>
<html>
<head>
<title>Absence</title>
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
HttpSession p = request.getSession();
String a=(String)p.getAttribute("id");
int b=Integer.parseInt(a);
DBInteraction.connect();
String query="select Name from annonces where ID="+b;
ResultSet rs=DBInteraction.Select(query);
String name="";
if(rs!=null && rs.next() ){
	name=rs.getString("Name");
}
query="select name_etudiant from etudiant_annonce where name_annonce='"+name+"'";
rs=DBInteraction.Select(query);

if(c==null){
	response.sendRedirect("/Project/authen.jsp");	
}
%>  
<section class="ftco-section" style="margin-left: 30%;">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">Absence</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<h3 class="mb-4 text-center"></h3>
		      	<form action="abs" method=post class="signin-form">
		      		<div class="form-group">
		      			<label >Date:</label>
		      			<input type="date" class="form-control" name="date"  required></div>
		  		  		  <label >Etudiant [absences]:</label>
		  
<%
String st; 
while(rs.next()) { 
st=rs.getString("name_etudiant");
%>

    <div class="form-group">
        <input type="checkbox" name="ele"  value="<%=st%>"  /><label><%= st%></label>
    </div>
<% } %>

		      		
		      <div class="form-group">
		      <button type="submit" class="form-control btn btn-primary submit px-3">Save</button>
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