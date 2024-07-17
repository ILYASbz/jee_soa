package model;

public class annonce {
String Id,Name ,professeur,prix, date, duree, nombre_etudiants, nombre_etudiants_max,Niveau;

public annonce() {
	super();
}

public annonce(String id, String name, String professeur, String prix, String date, String duree,
		String nombre_etudiants, String nombre_etudiants_max,String Niveau) {
	super();
	Id = id;
	Name = name;
	this.professeur = professeur;
	this.prix = prix;
	this.date = date;
	this.duree = duree;
	this.nombre_etudiants = nombre_etudiants;
	this.nombre_etudiants_max = nombre_etudiants_max;
	this.Niveau=Niveau;
}
public annonce( String name, String prix, String date, String duree,String nombre_etudiants_max,String Niveau) {
	super();
	this.Name = name;
	this.prix = prix;
	this.date = date;
	this.duree = duree;
	this.nombre_etudiants_max = nombre_etudiants_max;
	this.Niveau=Niveau;
}
public annonce(String name, String professeur, String prix, String date, String duree, String nombre_etudiants,
		String nombre_etudiants_max,String Niveau) {
	super();
	Name = name;
	this.professeur = professeur;
	this.prix = prix;
	this.date = date;
	this.duree = duree;
	this.nombre_etudiants = nombre_etudiants;
	this.nombre_etudiants_max = nombre_etudiants_max;
	this.Niveau=Niveau;

}

public String getNiveau() {
	return Niveau;
}

public void setNiveau(String niveau) {
	Niveau = niveau;
}

public String getId() {
	return Id;
}

public void setId(String id) {
	Id = id;
}

public String getName() {
	return Name;
}

public void setName(String name) {
	Name = name;
}

public String getProfesseur() {
	return professeur;
}

public void setProfesseur(String professeur) {
	this.professeur = professeur;
}

public String getPrix() {
	return prix;
}

public void setPrix(String prix) {
	this.prix = prix;
}

public String getDate() {
	return date;
}

public void setDate(String date) {
	this.date = date;
}

public String getDuree() {
	return duree;
}

public void setDuree(String duree) {
	this.duree = duree;
}

public String getNombre_etudiants() {
	return nombre_etudiants;
}

public void setNombre_etudiants(String nombre_etudiants) {
	this.nombre_etudiants = nombre_etudiants;
}

public String getNombre_etudiants_max() {
	return nombre_etudiants_max;
}

public void setNombre_etudiants_max(String nombre_etudiants_max) {
	this.nombre_etudiants_max = nombre_etudiants_max;
}

}
