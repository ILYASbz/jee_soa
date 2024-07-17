package model;

public class compte {
int id;
String Name,Email,Password,Role,Phone;

public compte() {
	
	super();
	Name = null;
	Email = null;
	Password = null;
	Role = null;
	Phone = null;
}
public compte(String name, String email, String password,  String phone,String role) {
	super();
	Name = name;
	Email = email;
	Password = password;
	Role = role;
	Phone = phone;
}
public compte(int id, String name, String email, String password,  String phone,String role) {
	super();
	this.id = id;
	Name = name;
	Email = email;
	Password = password;
	Role = role;
	Phone = phone;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getName() {
	return Name;
}
public void setName(String name) {
	Name = name;
}
public String getEmail() {
	return Email;
}
public void setEmail(String email) {
	Email = email;
}
public String getPassword() {
	return Password;
}
public void setPassword(String password) {
	Password = password;
}
public String getRole() {
	return Role;
}
public void setRole(String role) {
	Role = role;
}
public String getPhone() {
	return Phone;
}
public void setPhone(String phone) {
	Phone = phone;
}


}
