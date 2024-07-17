package model;

public class annonce_etudiant {
int id_annonce;
String nom_annonce;
int id_etudiant;
String nom_etudiant;
public int getId_annonce() {
	return id_annonce;
}
public void setId_annonce(int id_annonce) {
	this.id_annonce = id_annonce;
}
public String getNom_annonce() {
	return nom_annonce;
}
public void setNom_annonce(String nom_annonce) {
	this.nom_annonce = nom_annonce;
}
public int getId_etudiant() {
	return id_etudiant;
}
public void setId_etudiant(int id_etudiant) {
	this.id_etudiant = id_etudiant;
}
public String getNom_etudiant() {
	return nom_etudiant;
}
public void setNom_etudiant(String nom_etudiant) {
	this.nom_etudiant = nom_etudiant;
}
public annonce_etudiant(int id_annonce, String nom_annonce, int id_etudiant, String nom_etudiant) {
	super();
	this.id_annonce = id_annonce;
	this.nom_annonce = nom_annonce;
	this.id_etudiant = id_etudiant;
	this.nom_etudiant = nom_etudiant;
}
public annonce_etudiant() {
	super();
	// TODO Auto-generated constructor stub
}
	
	
}
