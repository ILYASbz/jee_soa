package model;

public class Data {
    private String[] elements;
    private String date;
    private String userId;

    public Data(String[] elements2, String date2, String userId2) {
    	
    	this.date=date2;
    	this.elements=elements2;
    	this.userId=userId2;
    }

    public String[] getElements() {
        return elements;
    }

    public void setElements(String[] elements) {
        this.elements = elements;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
