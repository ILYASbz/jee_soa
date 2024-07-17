<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tools.DBInteraction"%>
<%@page import="model.*"%>
<%@page import="dao.*"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin page</title>
<link href="/Project/test.css" rel="stylesheet">
<link href="/Project/Bocor/Bocor/assets/img/jkl.png" rel="icon">
 <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="/Project/startbootstrap-sb-admin-gh-pages/startbootstrap-sb-admin-gh-pages/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<style>
  .pagination {
    display: flex;
    justify-content: center;
    margin-top: 10px;
  }

  .pagination button {
    margin: 5px;
  }
    .btn-delete {
    background-color: red;
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
  
</style>
<script>
        function storeScrollPosition() {
            sessionStorage.setItem("scrollPosition", window.scrollY || window.scrollTop || document.getElementsByTagName("html")[0].scrollTop);
        }

        function restoreScrollPosition() {
            var scrollPosition = sessionStorage.getItem("scrollPosition");
            if (scrollPosition !== null) {
                window.scrollTo(0, parseInt(scrollPosition));
            }
        }
    </script>
</head>
<body onload="restoreScrollPosition()" onunload="storeScrollPosition()" style="background-color:rgba(32,66,94,255) ;">
<header id="header">
<div class="logo">
<a href="admin.jsp"><img src="/Project/Bocor/Bocor/assets/img/lo.png" alt=""  width="200px" ></a>
</div>
<form  action="accueil" method="get" style="margin-left:1000px;">
    <button name="image" style="border-style:none;background-color:rgba(32,66,94,255) ;">
<img src="/Project/Bocor/Bocor/assets/img/ziza.png" alt=""  width="200px" style="position: absolute; top: 0; right: 0;">
    </button>
</form>
</header>
<% 
HttpSession s=request.getSession();
compte c=(compte)s.getAttribute("user");
if(c==null || !(c.getRole()).equals("admin")){
	response.sendRedirect("/Project/authen.jsp");
	
}
%>
<%
DBInteraction.connect();
ResultSet rs = DBInteraction.Select("select * from comptes where Role!='admin'");
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

<div class="container" >
  <div class="row" >
  
    <div class="col-12" style="background-color: #ACACAC; border-radius: 15px;align-content: center;" 
    >
    
      <div class="card" style="background-color: #ACACAC; border-radius: 15px;"
      >
        
        <div class="card-body text-center">
        <form action="adduser.jsp" style="position: absolute; top: 0; right: 0;">
      <button class="btn-add"><strong>+Add User</strong></button>
			</form>
          <h5 class="card-title m-b-0" style="text-align: center; font-size: 24px; color: #333;margin-bottom: 50px;"><b>Tableau des comptes</b></h5>
        </div>
        <div class="table-responsive" style="margin-left: 150px;" >
      
          <table class="table" >
            <thead class="thead-light">
              <tr>
                <%
                  for (int i = 1; i <= n; i++) {
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
                <td><strong><%= row.get(0) %></strong></td>
                <%
                  for (int j = 1; j < n; j++) {
                %>
                <td><strong><%= row.get(j) %></strong></td>
                <%
                  }
                %>
                <td>
            <form action="ff" method="post">
    <input type="hidden" name="rowId" value="<%= row.get(0) %>" />
    <button type="submit" name="action" value="delete" class="btn-delete" onclick="storeScrollPosition()">
        <img src="/Project/Bocor/Bocor/assets/img/delete.ico" style="height:30px;width:50px;padding-left:15px" alt="delete" />
    </button>
    <button type="submit" name="action" value="edit" class="btn-edit" onclick="storeScrollPosition()">
        <img src="/Project/Bocor/Bocor/assets/img/dd.png" style="height:30px;width:50px;padding-left:15px" alt="edit" />
    </button>
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
    <form action="admin.jsp" >
      <button name="currentPage" value="<%= currentPage - 1 %>" <% if (currentPage <= 1) out.print("disabled"); %> class="btn-previous" onclick="storeScrollPosition()">Précédent</button>
      <button name="currentPage" value="<%= currentPage + 1 %>" <% if (end >= data.size()) out.print("disabled"); %> class="btn-next" onclick="storeScrollPosition()">Suivant</button>
    </form>
  </div>
</div>
<hr>
<%
annoncedao ed=new annoncedao();

ResultSet rs1 =ed.listAnnonce(); 
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

<div class="container">
  <div class="row">
  
    <div class="col-12" style="background-color: #ACACAC; border-radius: 15px;">
    
      <div class="card" style="background-color: #ACACAC; border-radius: 15px;">
        
        <div class="card-body text-center">
       
          <h5 class="card-title m-b-0" style="text-align: center; font-size: 24px; color: #333;margin-bottom: 50px;">Tableau des annonces</h5>
        </div>
        <div class="table-responsive" style="margin-left: 150px;">
      
          <table class="table">
            <thead class="thead-light">
              <tr>
                <%
                  for (int i = 1; i <= n1; i++) {
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
                <td><b><%= row1.get(0) %></b></td>
                <%
                  for (int j = 1; j < n1; j++) {
                %>
                <td><b><%= row1.get(j) %></b></td>
                <%
                  }
                %>
                <td>
                  <form action="aa" method="get">
                    <input type="hidden" name="rowId" value="<%= row1.get(0) %>" />
    <button type="submit" name="supp" value="delete" class="btn-delete" onclick="storeScrollPosition()">
        <img src="/Project/Bocor/Bocor/assets/img/delete.ico" style="height:30px;width:50px;padding-left:15px" alt="delete" />
    </button>                  </form>
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
    <form action="admin.jsp" >
      <button name="currentPage1" value="<%= currentPage1 - 1 %>" <% if (currentPage1 <= 1) out.print("disabled"); %> class="btn-previous" onclick="storeScrollPosition()">Précédent</button>
      <button name="currentPage1" value="<%= currentPage1 + 1 %>" <% if (end1 >= data1.size()) out.print("disabled"); %> class="btn-next" onclick="storeScrollPosition()">Suivant</button>
    </form>
  </div>
</div>
<hr>
<%
annonce_etudiant_dao et=new annonce_etudiant_dao();
ResultSet rs2=et.listAnnonce_etudiant();
String selectedNiveau = request.getParameter("niveau");
DBInteraction.connect();
if (selectedNiveau != null && !selectedNiveau.isEmpty()) {
    String query = "SELECT * FROM etudiant_annonce WHERE name_annonce = '" + selectedNiveau + "'";
	rs2 = DBInteraction.Select(query);

}
ResultSetMetaData m2 = rs2.getMetaData();
int n2 = m2.getColumnCount();

int currentPage2 = 1;
if (request.getParameter("currentPage2") != null) {
    currentPage2 = Integer.parseInt(request.getParameter("currentPage2"));
}
int recordsPerPage2 = 5; 

ArrayList<ArrayList<String>> data2 = new ArrayList<>();
while (rs2.next()) {
    ArrayList<String> row2 = new ArrayList<>();
    for (int j = 1; j <= n2; j++) {
        row2.add(rs2.getString(j));
    }
    data2.add(row2);
}

int start2 = (currentPage2 - 1) * recordsPerPage2;
int end2 = Math.min(start2 + recordsPerPage2, data2.size());

%>


<div class="container">
<form action="admin.jsp" method="post" style="">
<select name="niveau" class="btn btn-primary" name="search" style="background-color:white;color:black;" >
    <option value="">-Sélectionnez un cours -</option>
    <%
        DBInteraction.connect();
        ResultSet niveauxRS = DBInteraction.Select("SELECT DISTINCT name_annonce FROM etudiant_annonce");
        while (niveauxRS.next()) {
            String niveau = niveauxRS.getString("name_annonce");
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
  <div class="row">
  
    <div class="col-12" style="background-color: #ACACAC; border-radius: 15px;">
    
      <div class="card" style="background-color: #ACACAC; border-radius: 15px;">
        
        <div class="card-body text-center">
       
          <h5 class="card-title m-b-0" style="text-align: center; font-size: 24px; color: #333;margin-bottom: 50px;" >Tableau des etudiants-annonces</h5>
        </div>
        <div class="table-responsive" style="margin-left: 150px;">
      
          <table class="table">
            <thead class="thead-light">
              <tr>
                <%
                  for (int i = 1; i <= n2; i++) {
                %>
                <th scope="col" style="color: rgba(32,66,94,255);"><b><%= m2.getColumnName(i) %></b></th>
                <%
                  }
                %>
                <td></td>
              </tr>
            </thead>
            <tbody class="customtable">
              <%
                for (int i = start2; i < end2; i++) {
                    ArrayList<String> row2 = data2.get(i);
              %>
              <tr>
                <td><b><%= row2.get(0) %></b></td>
                <%
                  for (int j = 1; j < n2; j++) {
                %>
                <td><b><%= row2.get(j) %></b></td>
                <%
                  }
                %>
                <td>
                  <form action="gg" method="get">
                    <input type="hidden" name="rowIdan" value="<%= row2.get(0) %>" />
                     <input type="hidden" name="rowIdet" value="<%= row2.get(2) %>" />
<button type="submit" name="supp" value="delete" class="btn-delete" onclick="storeScrollPosition()">
        <img src="/Project/Bocor/Bocor/assets/img/delete.ico" style="height:30px;width:50px;padding-left:15px" alt="delete" />
    </button>                  </form>
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
    <form action="admin.jsp" >
      <button name="currentPage2" value="<%= currentPage2 - 1 %>" <% if (currentPage2 <= 1) out.print("disabled"); %> class="btn-previous" onclick="storeScrollPosition()">Précédent</button>
      <button name="currentPage2" value="<%= currentPage2 + 1 %>" <% if (end2 >= data2.size()) out.print("disabled"); %> class="btn-next" onclick="storeScrollPosition()">Suivant</button>
    </form>
  </div>
</div>
<hr>
<%
String selectedNiveau1 = request.getParameter("niveau1");
DBInteraction.connect();
ResultSet rs3=DBInteraction.Select("select * from absences");
if (selectedNiveau1 != null && !selectedNiveau1.isEmpty()) {
    String query1 = "SELECT * FROM absences WHERE Nom_Cours = '" + selectedNiveau1 + "'";
	 rs3 = DBInteraction.Select(query1);

}
ResultSetMetaData m3 = rs3.getMetaData();
int n3 = m3.getColumnCount();

int currentPage3 = 1;
if (request.getParameter("currentPage3") != null) {
    currentPage3 = Integer.parseInt(request.getParameter("currentPage3"));
}
int recordsPerPage3 = 5; 

ArrayList<ArrayList<String>> data3 = new ArrayList<>();
while (rs3.next()) {
    ArrayList<String> row3 = new ArrayList<>();
    for (int j = 1; j <= n3; j++) {
        row3.add(rs3.getString(j));
    }
    data3.add(row3);
}

int start3 = (currentPage3 - 1) * recordsPerPage3;
int end3 = Math.min(start3 + recordsPerPage3, data3.size());

%>


<div class="container">
<form action="admin.jsp" method="post" style="">
<select name="niveau1" class="btn btn-primary" name="search" style="background-color:white;color:black;" >
    <option value="">-Sélectionnez un cours -</option>
    <%
        DBInteraction.connect();
        ResultSet niveauxRS1 = DBInteraction.Select("SELECT DISTINCT Nom_Cours FROM absences");
        while (niveauxRS1.next()) {
            String niveau1 = niveauxRS1.getString("Nom_Cours");
    %>
    <option value="<%= niveau1 %>"><%= niveau1 %></option>
    <%
        }
        DBInteraction.disconnect();
    %>
</select>
    <!-- Vos autres champs de formulaire, y compris la balise <select> -->
  <button class="btn btn-primary" name="search" id="btnNavbarSearch" type="submit"><i class="fas fa-search"></i></button>
</form>
  <div class="row">
  
    <div class="col-12" style="background-color: #ACACAC; border-radius: 15px;">
    
      <div class="card" style="background-color: #ACACAC; border-radius: 15px;">
        
        <div class="card-body text-center">
       
          <h5 class="card-title m-b-0" style="text-align: center; font-size: 24px; color: #333;margin-bottom: 50px;" >Tableau des absences</h5>
        </div>
        <div class="table-responsive" style="margin-left: 150px;">
      
          <table class="table">
            <thead class="thead-light">
              <tr>
                <%
                  for (int i = 1; i <= n3; i++) {
                %>
                <th scope="col" style="color: rgba(32,66,94,255);"><b><%= m3.getColumnName(i) %></b></th>
                <%
                  }
                %>
                <td></td>
              </tr>
            </thead>
            <tbody class="customtable">
              <%
                for (int i = start3; i < end3; i++) {
                    ArrayList<String> row3 = data3.get(i);
              %>
              <tr>
                <td><b><%= row3.get(0) %></b></td>
                <%
                  for (int j = 1; j < n3; j++) {
                %>
                <td><b><%= row3.get(j) %></b></td>
                <%
                  }
                %>
                <td>
                  <form action="abs" method="get">
                    <input type="hidden" value="<%=row3.get(1) %>" name="rowId"  />
                     <input type="hidden" value="<%=row3.get(2) %>" name="rowId2"  />
                    
<button type="submit" name="supp" value="delete" class="btn-delete" onclick="storeScrollPosition()">
        <img src="/Project/Bocor/Bocor/assets/img/delete.ico" style="height:30px;width:50px;padding-left:15px" alt="delete" />
    </button>                  </form>
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
    <form action="admin.jsp" >
      <button name="currentPage3" value="<%= currentPage3 - 1 %>" <% if (currentPage3 <= 1) out.print("disabled"); %> class="btn-previous" onclick="storeScrollPosition()">Précédent</button>
      <button name="currentPage3" value="<%= currentPage3 + 1 %>" <% if (end3 >= data3.size()) out.print("disabled"); %> class="btn-next" onclick="storeScrollPosition()">Suivant</button>
    </form>
  </div>
</div>
</body>
</html>
