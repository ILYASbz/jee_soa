package model;


public class Data {
	  private String[] elements;
      private String date;
      private String userId;

      public Data(String[] elements, String date2, String userId) {
          this.elements = elements;
          this.date = date2;
          this.userId = userId;
      }

      public String[] getElements() {
          return elements;
      }

      public String getDate() {
          return date;
      }

      public String getUserId() {
          return userId;
      }
  
}
