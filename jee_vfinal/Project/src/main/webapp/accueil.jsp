<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="model.*"%>
    <%@page import="web.*"%>
   
    <%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tools.DBInteraction"%>
<%@page import="com.mysql.cj.Session"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Accueil</title>
<link href="/Project/Bocor/Bocor/assets/img/jkl.png" rel="icon">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="/Project/startbootstrap-sb-admin-gh-pages/startbootstrap-sb-admin-gh-pages/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<style type="text/css">
.pagination {
    display: flex;
    justify-content: center;
    margin-top: 10px;
  }

  .pagination button {
    margin: 5px;
  }
    .btn-delete {
    background-color: blue;
    color: white;
    border: 2px solid darkred;
    border-radius: 5px;
        font-family: "Verdana", sans-serif; 
    
    
  }

  .btn-edit {
    background-color: yellow;
    color: black;
    border: 2px solid darkorange;
    border-radius: 5px;
    font-family: "Verdana", sans-serif; 
    
    
  }
  .btn-previous[disabled] {
    background-color: gray;
    color: white;
    border: 2px solid darkgray;
    cursor: not-allowed;
  }

  .btn-next[disabled] {
    background-color: gray;
    color: white;
    border: 2px solid darkgray;
    cursor: not-allowed;
  }

  .btn-previous:not([disabled]) {
    background-color: blue;
    color: white;
    border: 2px solid darkblue;
    cursor: pointer;
  }

  .btn-next:not([disabled]) {
    background-color: blue;
    color: white;
    border: 2px solid darkblue;
    cursor: pointer;
  }
  .btn-add {
    background-color: orange;
    color: black;
    border: 2px solid darkorange;
    border-radius: 5px;
    font-family: "Verdana", sans-serif; 
    
    
  }
 button{
 border-radius: 5px;
    font-family: "Verdana", sans-serif;
 }
 body {
  overflow: hidden; /* Masque le défilement vertical */
}

.btn.btn-primary {
    position: relative; /* Permet de positionner le texte absolument */
}

.btn.btn-primary:hover span {
    display: block; /* Affiche le texte lorsque le bouton est survolé */
    position: absolute;
    top: 50%; /* Positionne le texte verticalement */
    left: 50%; /* Positionne le texte horizontalement */
    transform: translate(-50%, -50%); /* Centre le texte dans le bouton */
    background-color: rgba(0, 0, 0, 0.7); /* Couleur de fond semi-transparente */
    color: white; /* Couleur du texte */
    padding: 5px 10px; /* Espacement intérieur */
    border-radius: 5px; /* Coins arrondis */
    z-index: 1; /* S'assure que le texte est au-dessus de l'image */
}
</style>

</head>
<body >
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
	

 <nav class="sb-topnav navbar navbar-expand navbar-dark " style="background-color:rgba(32,66,94,255);">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="accueil.jsp"><img src="/Project/Bocor/Bocor/assets/img/lo.png" alt=""  width="200px" ></a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!" style="border:2px;border-style:solid;border-radius:5px;"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
           
            <!-- Navbar-->
            
    <form  action="accueil" method="get" style="margin-left:1000px;">
    <button style="margin-left:-400px;border-style:none;background-color:rgba(32,66,94,255) ;">
    <img src="/Project/login-form-20/images/aa.png" alt="disconnect" style="width: 30px; height: 30px;" />
    </button>
</form>
<h2 style="color:#ACACAC;margin-left:-300px;" ><%=c.getName() %></h2>

        </nav>
        <div id="layoutSidenav" >
            <div id="layoutSidenav_nav" >
                <nav class="sb-sidenav accordion " style="background-color:rgba(55,114,162,255);" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <form action="accueil.jsp">
                          <input type="hidden" name="annonce" value="mes" />
                            <input type="submit" value="Mes Annonces" class="nav-link"  style="border-style:none;background-color:rgba(55,114,162,255);font-family: 'Verdana', sans-serif;color:#ACACAC;margin-top:50px;margin-bottom:30px;">  
                          </form>
                           <form action="moncompte.jsp">
                            <input type="submit" value="Mon Compte" class="nav-link"  style="border-style:none;background-color:rgba(55,114,162,255);font-family: 'Verdana', sans-serif;color:#ACACAC;margin-top:50px;margin-bottom:30px;">  
                          </form>
                           

                        </div>
                    </div>
                    
                </nav>
            </div>
            <div id="layoutSidenav_content" ></div>
            <%
	String g=(String)request.getParameter("annonce");
	if(g==null){
	%>

<%
String selectedNiveau = request.getParameter("niveau");
String query = "SELECT * FROM annonces WHERE `nombre étudiants` != `nombre étudiants max` AND ID NOT IN (SELECT id_annonce FROM etudiant_annonce WHERE id_etudiant=" + c.getId() + ")";
if ((c.getRole()).equals("professeur")){
	 query = "SELECT * FROM annonces where id_professeur != '"+c.getId()+"'";

}
if (selectedNiveau != null && !selectedNiveau.isEmpty()) {
    query = "SELECT * FROM annonces WHERE Niveau = '" + selectedNiveau + "' and  `nombre étudiants` != `nombre étudiants max` and  ID not in (select id_annonce from etudiant_annonce where id_etudiant="+c.getId()+" )";
    if ((c.getRole()).equals("professeur")){
        query = "SELECT * FROM annonces WHERE Niveau = '" + selectedNiveau + "' and  ID not in (select ID from annonces where id_professeur="+c.getId()+")";

    }
}

DBInteraction.connect();
ResultSet rs = DBInteraction.Select(query);

ResultSetMetaData m = rs.getMetaData();
int n = m.getColumnCount();
int currentPage = 1;


if (request.getParameter("currentPage") != null) {
    currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
int recordsPerPage = 5; 

ArrayList<ArrayList<String>> data = new ArrayList<>();
while (rs.next()) {
    ArrayList<String> row = new ArrayList<>();
    for (int j = 1; j <= n; j++) {
        row.add(rs.getString(j));
    }
    data.add(row);
}

int start = (currentPage - 1) * recordsPerPage;
int end = Math.min(start + recordsPerPage, data.size());

%>


<div class="container" style="margin-top: 10px;">
<h1 style="text-align: center; margin: 30px; font-family: 'Verdana', sans-serif;">Liste des Annonces</h1>

  <div class="row" >
  
    <div class="col-12" style="border-style:none; align-content: center;" 
    >
    <div  style="margin-left: 950px;">            
<form action="accueil.jsp" method="post" style="margin-left:-300px;">
<select name="niveau" class="btn btn-primary" name="search" style="background-color:white;color:black;" >
    <option value="">-Sélectionnez un niveau -</option>
    <%
        DBInteraction.connect();
        ResultSet niveauxRS = DBInteraction.Select("SELECT DISTINCT Niveau FROM annonces");
        while (niveauxRS.next()) {
            String niveau = niveauxRS.getString("Niveau");
    %>
    <option value="<%= niveau %>"><%= niveau %></option>
    <%
        }
        DBInteraction.disconnect();
    %>
</select>
    <!-- Vos autres champs de formulaire, y compris la balise <select> -->
  <button class="btn btn-primary" name="search" id="btnNavbarSearch" type="submit"><i class="fas fa-search"></i></button>
</form>
</div>
      <div class="card" style="border-style:none; "
      >
        
       
        <div class="table-responsive" style="margin-left: 50px;" >
      
          <table class="table"  style="border-style:none;">
            <thead class="thead-light">
              <tr>
                <%
                  for (int i = 1; i <= n; i++) {
                	  if(i==1 || i==9){
                		  continue;
                	  }
                %>
                
                <th scope="col" style="color: rgba(32,66,94,255);"><b><%= m.getColumnName(i) %></b></th>
                <%
                  }
                %>
                <td></td>
              </tr>
            </thead>
            <tbody class="customtable">
              <%
                for (int i = start; i < end; i++) {
                    ArrayList<String> row = data.get(i);
              %>
              <tr>
                <%
                  for (int j = 1; j < n; j++) {
                	  if(j==8){
                		  continue;
                	  }
                %>
                <td><strong><%= row.get(j) %></strong></td>
                <%
                  }
                %>
                <%    
                if (!(c.getRole()).equals("professeur")){ %>
                <td>
                  <form action="delajt" method="get">
                    <input type="hidden" name="rows" value="<%= row.get(0) %>" />
                    <input type="hidden" name="rowname" value="<%= row.get(1) %>" />
  <button type="submit"  value="inscrire" class="btn btn-primary" style="background-color: blue; color: white;">
        <img src="/Project/Bocor/Bocor/assets/img/fli.png" style="height:30px;width:40px;padding-left:10px;" alt="inscrire" />
            <span style="display: none;">Inscrire</span> <!-- Texte masqué -->
    
    </button>                  </form>
                </td>
                <%} %>
              </tr>
              <%
                }
              %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  <div class="pagination">
    <form action="accueil.jsp" >
      <button name="currentPage" value="<%= currentPage - 1 %>" <% if (currentPage <= 1) out.print("disabled"); %> class="btn-previous">Précédent</button>
      <button name="currentPage" value="<%= currentPage + 1 %>" <% if (end >= data.size()) out.print("disabled"); %> class="btn-next">Suivant</button>
    </form>
  </div>
</div> 
<%}else{%>

<%
String query="select * from annonces where ID in (select id_annonce from etudiant_annonce where id_etudiant="+c.getId()+") ";
if((c.getRole()).equals("professeur")){
	
	query="select * from annonces where id_professeur='"+c.getId()+"'";
}

DBInteraction.connect();
ResultSet rs1 = DBInteraction.Select(query);
ResultSetMetaData m1 = rs1.getMetaData();
int n1 = m1.getColumnCount();
int currentPage1 = 1;


if (request.getParameter("currentPage1") != null) {
    currentPage1 = Integer.parseInt(request.getParameter("currentPage1"));
}
int recordsPerPage1 = 5; 

ArrayList<ArrayList<String>> data1 = new ArrayList<>();
while (rs1.next()) {
    ArrayList<String> row1 = new ArrayList<>();
    for (int j = 1; j <= n1; j++) {
        row1.add(rs1.getString(j));
    }
    data1.add(row1);
}

int start1 = (currentPage1 - 1) * recordsPerPage1;
int end1 = Math.min(start1 + recordsPerPage1, data1.size());

%>

<div class="container" style="margin-top: 10px;">
<%if((c.getRole()).equals("professeur")){ %>
<form action="ajtannnce.jsp" >
      <button class="btn-add"><strong>+Add Annonce</strong></button>
			</form>
<%} %>
<h1 style="text-align: center; margin: 30px; font-family: 'Verdana', sans-serif;">Liste Mes Annonces</h1>

  <div class="row" >
  
    <div class="col-12" style="border-style:none; align-content: center;" 
    >
 
      <div class="card" style="border-style:none; "
      >
        
       
        <div class="table-responsive" style="margin-left: 50px;" >
      
          <table class="table"  style="border-style:none;">
            <thead class="thead-light">
              <tr>
                <%
                  for (int i = 1; i <= n1; i++) {
                	  if(i==1 || i==9){
                		  continue;
                	  }
                %>
                
                <th scope="col" style="color: rgba(32,66,94,255);"><b><%= m1.getColumnName(i) %></b></th>
                <%
                  }
                %>
                <td></td>
              </tr>
            </thead>
            <tbody class="customtable">
              <%
                for (int i = start1; i < end1; i++) {
                    ArrayList<String> row1 = data1.get(i);
              %>
              <tr>
                <%
                  for (int j = 1; j < n1; j++) {
                	  if(j==8){
                		  continue;
                	  }
                %>
                <td><strong><%= row1.get(j) %></strong></td>
                <%
                  }
                %>
                <td>
                  <form action="delajt" method="post">
    <input type="hidden" name="rowId1" value="<%= row1.get(0) %>" />
    
    <!-- Bouton Suppression avec icône -->
    <button type="submit" name="supp" value="delete" class="btn btn-primary" style="background-color: darkred; color: black;">
        <img src="/Project/Bocor/Bocor/assets/img/ss.png" style="height:30px;width:40px;padding-left:10px" alt="delete" />
    </button>

    <!-- Bouton Édition avec icône -->
    <% if (!c.getRole().equals("etudiant")) { %>
        <button type="submit" name="supp" value="edit" class="btn btn-primary" style="background-color: lightgreen; color: black;">
            <img src="/Project/Bocor/Bocor/assets/img/dd.png" style="height:30px;width:40px;padding-left:10px" alt="edit" />
        </button>
    <% } %>

    <!-- Bouton Absence avec icône -->
    <% if (!c.getRole().equals("etudiant")) { %>
        <button type="submit" name="supp" value="absence" class="btn btn-primary" style="background-color: yellow; color: black;">
            <img src="/Project/Bocor/Bocor/assets/img/absence.png" style="height:30px;width:40px;padding-left:10px" alt="absence" />
        </button>
    <% } %>
</form>

                </td>
              </tr>
              <%
                }
              %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  <div class="pagination">
    <form action="accueil.jsp" >
    <input type="hidden" name="annonce" value="mes" />
      <button name="currentPage1" value="<%= currentPage1 - 1 %>" <% if (currentPage1 <= 1) out.print("disabled"); %> class="btn-previous">Précédent</button>
      <button name="currentPage1" value="<%= currentPage1 + 1 %>" <% if (end1 >= data1.size()) out.print("disabled"); %> class="btn-next">Suivant</button>
    </form>
  </div>
</div> 

<%}}%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" ></script>
        <script src="/Project/startbootstrap-sb-admin-gh-pages/startbootstrap-sb-admin-gh-pages/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" ></script>
        <script src="/Project/startbootstrap-sb-admin-gh-pages/startbootstrap-sb-admin-gh-pages/assets/demo/chart-area-demo.js"></script>
        <script src="/Project/startbootstrap-sb-admin-gh-pages/startbootstrap-sb-admin-gh-pages/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" ></script>
        <script src="/Project/startbootstrap-sb-admin-gh-pages/startbootstrap-sb-admin-gh-pages/js/datatables-simple-demo.js"></script>
</body>
</html>