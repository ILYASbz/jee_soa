package dao;

import java.sql.ResultSet;

public interface Iannonce {
	public ResultSet listAnnonce();
	public void deleteannonce(int id);
	public void add_annonce(String name,String Name,String prix,String date,String duree,String nbmax,int Id,String niveau);
    public void edit_annonce(String name,String prix,String date,String duree,String nbmax,String niveau,int id);
}
