package model;

public class Absence {

String Nom_Cours;
String Nom_etudiant;
String date;
public String getNom_Cours() {
	return Nom_Cours;
}
public void setNom_Cours(String nom_Cours) {
	Nom_Cours = nom_Cours;
}
public String getNom_etudiant() {
	return Nom_etudiant;
}
public void setNom_etudiant(String nom_etudiant) {
	Nom_etudiant = nom_etudiant;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public Absence(String nom_Cours, String nom_etudiant, String date) {
	super();
	Nom_Cours = nom_Cours;
	Nom_etudiant = nom_etudiant;
	this.date = date;
}
public Absence() {
	super();
	// TODO Auto-generated constructor stub
}

}
