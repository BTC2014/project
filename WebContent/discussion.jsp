<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>discussions</title>
</head>
<body>


    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page import="java.sql.*"%>
    <%@ page import="java.text.SimpleDateFormat" %>
<%--open connection code --%>
		<%@ page language="java" import="java.util.Date" %>
		<%@ page language="java" import="java.text.ParseException" %>
		<%@ page language="java" import="java.sql.Time" %>
		<%@ page language="java" import="java.util.Locale" %>
		

		<%
		
		try {
		    Class.forName ("org.postgresql.Driver");
		  } catch (ClassNotFoundException e) {
		    System.out.println ("Where is your PostgreSQL JDBC Driver? Include in your library path!");
		    e.printStackTrace ();
		    return;
		  }
		  System.out.println ("PostgreSQL JDBC Driver Registered!");
		  Connection conn=null;    
		    try {      
		      conn=  DriverManager.getConnection ("jdbc:postgresql://localhost:5432/132b", "postgres", "123");      
		      //conn=  DriverManager.getConnection ("jdbc:postgresql://localhost:5432/" + args[0], args[1], args[2]);    
		    } catch (SQLException ex) {
		      ex.printStackTrace();
		      System.out.println ("Connection Failed! Check output console.");      
		      return;
		    }
		    
		   
		%>

            <%-- -------- INSERT Code -------- --%>
            <% 
            
            try{
                    String action = request.getParameter("action");
                    
                    
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO discussion(section_id, weekday, room, mandatory, starttime,endtime) VALUES ( ?, ?, ?, ?, ?, ?)");

      
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SECTION_ID")));                                        
                        pstmt.setString(2, request.getParameter("WEEKDAY"));
                        pstmt.setString(3, request.getParameter("ROOM"));
                        pstmt.setString(4, request.getParameter("MANDATORY"));                                            
                        
                         
                        
                        
                        String TIME_FORMAT = "HH:mm"; 
                        SimpleDateFormat timeFormat = new SimpleDateFormat(TIME_FORMAT, Locale.getDefault()); 
                       				
                        pstmt.setTime(5, new Time(timeFormat.parse(request.getParameter("starttime")).getTime()));
                        pstmt.setTime(6, new Time(timeFormat.parse(request.getParameter("endtime")).getTime())); 
                        pstmt.executeUpdate();
                        
                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>         

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM discussion");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SECTION_ID</th>                        
                        <th>WEEKDAY OF OFFER</th>
                        <th>ROOM</th>
						<th>MANDATORY</th>
                        <th>STARTTIME</th>
                        <th>ENDTIME</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="discussions.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SECTION_ID" ></th>                                                      
                            
                            <th><select value="" name="WEEKDAY">
			    				<option value="MONDAY">MONDAY</option>
			    				<option value="TUESDAY">TUESDAY</option>
			    				<option value="WEDNESDAY">WEDNESDAY</option>
			    				<option value="THURSDAY">THURSDAY</option>
			    				<option value="FRIDAY">FRIDAY</option>			    				
			    				</select>
			    			</th>
                            <th><input value="" name="ROOM"></th>

			    			<th><select value="" name="MANDATORY">
			    				<option value="YES">YES</option>
			    				<option value="NO">NO</option>
			    				</select>
			    			</th>
                            <th><input value="" name="STARTTIME" ></th>
                            <th><input value="" name="ENDTIME" ></th>
                           
                            			    			           
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="discussions.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SECTION_ID") %>" 
                                    name="SECTION_ID"  readonly>
                            </td>

                           
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("WEEKDAY") %>" 
                                    name="WEEKDAY" >
                            </td>    
                            <%-- Get the FIRSTNAME --%>
                            
                            <td>
                                <input value="<%= rs.getString("ROOM") %>"
                                    name="ROOM" >
                            </td>
    
    
			    			<%-- Get the LASTNAME --%>
                            <td><select name="MANDATORY" >
                            	<option value="YES" <%=rs.getString("MANDATORY").equals("YES") ? "selected" : ""%>>YES</option>
								<option value="NO" <%=rs.getString("MANDATORY").equals("NO") ? "selected" : ""%>>NO</option>						
								</select>
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getTime("STARTTIME") %>"
                                    name="STARTTIME" >
                            </td> 
                            
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getTime("ENDTIME")%>"
                                    name="ENDTIME" >
                            </td>                          
                        </form>
                       
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
