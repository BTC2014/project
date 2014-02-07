<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%--open connection code --%>
		<%@ page language="java" import="java.sql.*" %>

		<%
try {
    Class.forName ("org.postgresql.Driver");
  } catch (ClassNotFoundException e) {
    System.out.println ("Where is your PostgreSQL JDBC Driver? Include in your library path!");
    e.printStackTrace ();
    return;
  }
  System.out.println ("PostgreSQL JDBC Driver Registered!");
  Connection conn=  null;    
    try {      
      conn=  DriverManager.getConnection ("jdbc:postgresql://localhost:8080/132b", "postgres", "123");      
      //conn=  DriverManager.getConnection ("jdbc:postgresql://localhost:5432/" + args[0], args[1], args[2]);    
    } catch (SQLException ex) {      
      System.out.println ("Connection Failed! Check output console.");      
      return;
    }
%>
</body>
</html>