package dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import tools.DBInteraction;

public class absence_dao implements  Iabsence {

	@Override
	public void delete_absence(String name,String date) {
		DBInteraction.connect();
		String q="delete from absences where  date='"+date+"' and `Nom_d'étudiant`='"+name+"' ";
        DBInteraction.Maj(q);
        DBInteraction.disconnect();
		
	}

	@Override
	public void add_absence(int b, String[] elements, String date) {
		DBInteraction.connect();
    	String query="select Name from annonces where ID="+b;
    	ResultSet rs=DBInteraction.Select(query);
    	String name="";
    	try {
			if(rs!=null && rs.next() ){
				name=rs.getString("Name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	for(String element : elements) {
    		DBInteraction.Maj("insert into absences values('"+name+"','"+element+"','"+date+"')");
    	}
    	DBInteraction.disconnect();
	}

}
