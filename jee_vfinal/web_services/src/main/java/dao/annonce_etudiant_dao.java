package dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import tools.DBInteraction;

public class annonce_etudiant_dao implements Interface_annonce_etudiant {

	public annonce_etudiant_dao() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public ResultSet listAnnonce_etudiant() {
		DBInteraction.connect();
		ResultSet rs1 = DBInteraction.Select("select * from etudiant_annonce");
		return rs1;
	}

	@Override
	public void delete_etusiant_annonce(int rowIdet, int rowIdan) {
		 DBInteraction.connect();
		 int b=rowIdan;
		   ResultSet rs= DBInteraction.Select("select `nombre étudiants` from annonces where ID="+b);
            try {
    			if(rs.next()) {
    				int o=Integer.parseInt(rs.getString(1));
    			o-=1;
    			DBInteraction.Maj("UPDATE `annonces` SET `nombre étudiants`='"+o+"'  WHERE ID="+b);
    			
    			
    			}
    			
            }catch (SQLException e) {
    			e.printStackTrace();
    		}
		 DBInteraction.Maj("delete from etudiant_annonce where id_annonce="+rowIdan+" and id_etudiant="+rowIdet);
	      DBInteraction.disconnect();
	}

	@Override
	public void add_etudiant_annonce(int a, String c, int b, String n) {
		DBInteraction.connect();
        DBInteraction.Maj("INSERT INTO etudiant_annonce(id_annonce, name_annonce,id_etudiant,name_etudiant) VALUES("+a+",'"+c+"',"+b+",'"+n+"')");
       ResultSet rs= DBInteraction.Select("select `nombre étudiants` from annonces where ID="+a);
       try {
			if(rs.next()) {
				int o=Integer.parseInt(rs.getString(1));
			o+=1;
			DBInteraction.Maj("UPDATE `annonces` SET `nombre étudiants`='"+o+"'  WHERE ID="+a);
			
			
			}
			
       }catch (SQLException e) {
			e.printStackTrace();
		}
        DBInteraction.disconnect();		
	}
	

}
