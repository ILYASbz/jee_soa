package dao;
import java.sql.ResultSet;

import model.*;
public interface Icompt {
	compte findbyId(int a);
	void updatecompte(compte c);
	void adduser(compte c);
	boolean check(String a,String b);
	compte findbyEmail(String a,String b);
	void deleteuser(int ids );

}
