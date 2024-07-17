package dao;

import java.sql.ResultSet;

public interface Interface_annonce_etudiant {
  public ResultSet listAnnonce_etudiant() ;
  public void delete_etusiant_annonce(int ide,int ida);
  public void add_etudiant_annonce(int a,String c,int b,String n);
}
