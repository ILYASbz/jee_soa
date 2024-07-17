package dao;

import java.sql.ResultSet;

import tools.DBInteraction;

public class annoncedao implements Iannonce {
	public annoncedao() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public ResultSet listAnnonce() {
		DBInteraction.connect();
		ResultSet rs1 = DBInteraction.Select("select * from annonces");
		return rs1;
	}


	@Override
	public void deleteannonce(int id) {
		DBInteraction.connect();
		 DBInteraction.Maj("delete from annonces where id="+id);
        DBInteraction.Maj("delete from etudiant_annonce where id_annonce= " + id);
		DBInteraction.disconnect();
	}


	@Override
	public void add_annonce(String name, String Name, String prix, String date, String duree, String nbmax,
			int Id, String niveau) {
		DBInteraction.connect();
        DBInteraction.Maj("insert into `annonces`( `Name`, `professeur`, `prix`, `date`, `durée`, `nombre étudiants`, `nombre étudiants max`, `id_professeur`, `Niveau`) values('"+name+"','"+Name+"','"+prix+" dh','"+date+"','"+duree+"','"+0+"','"+nbmax+"','"+Id+"','"+niveau+"')");
          DBInteraction.disconnect();
	}


	@Override
	public void edit_annonce(String name, String prix, String date, String duree, String nbmax, String niveau, int id) {

		 DBInteraction.connect();
         DBInteraction.Maj("UPDATE `annonces` SET `Name`='"+name+"',`prix`='"+prix+" dh',`date`='"+date+"',`durée`='"+duree+"',`nombre étudiants max`='"+nbmax+"',`Niveau`='"+niveau+"' WHERE ID="+id);
		DBInteraction.disconnect();
	}
}
