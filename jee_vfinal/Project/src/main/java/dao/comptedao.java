package dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.cj.protocol.Resultset;

import model.compte;
import tools.DBInteraction;

public class comptedao implements Icompt {

	public comptedao() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public compte findbyId(int a) {
     DBInteraction.connect();
		ResultSet rs=DBInteraction.Select("select * from comptes where ID="+a);
       compte c=null;
       try {
		while(rs.next()) {
			   c=new compte( rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
			   
		   }
	} catch (SQLException e) {
		e.printStackTrace();
	}
       
	return c;
	}

	@Override
	public void updatecompte(compte c) {
	     DBInteraction.connect();
         int a=DBInteraction.Maj("update comptes  set Name='"+c.getName()+"',Email='"+c.getEmail()+"',password='"+c.getPassword()+"',Phone='"+c.getPhone()+"',Role='"+c.getRole()+"'   where ID="+c.getId());
	     DBInteraction.disconnect();

		
	}

	@Override
	public void adduser(compte c) {
DBInteraction.connect();
DBInteraction.Maj("INSERT INTO `comptes`( `Name`, `Email`, `password`, `Phone`, `Role`) VALUES ('"+c.getName()+"','"+c.getEmail()+"','"+c.getPassword()+"','"+c.getPhone()+"','"+c.getRole()+"')");
DBInteraction.disconnect();
	}

	@Override
	public  boolean check(String a, String b) {
     DBInteraction.connect();
     ResultSet rs=null;
     rs=DBInteraction.Select("select * from comptes where Email='"+a+"' and password='"+b+"'");
     try {
		if(rs.next()) {
			 return true;
			 
			 
		 }else {return false;}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return false;
     	}

	@Override
	public compte findbyEmail(String a,String b) {
     DBInteraction.connect();
	ResultSet rs=DBInteraction.Select("select * from comptes where Email='"+a+"' and password='"+b+"' ");
       compte c=null;
       try {
		while(rs.next()) {
			   c=new compte(Integer.parseInt(rs.getString(1)), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
			   
		   }
	} catch (SQLException e) {
		e.printStackTrace();
	}
    DBInteraction.disconnect();
	return c;
	}

	@Override
	public void deleteuser(int ids) {
		 DBInteraction.connect();
		 DBInteraction.Maj("delete from comptes where id="+ids);	
		 DBInteraction.disconnect();
		 
	}
}
