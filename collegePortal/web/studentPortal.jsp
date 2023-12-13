<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="app.helper.dbConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <style>
            
            #roomsForm{
                display: none;
            }
            
            
        </style>
 
    </head>
    <body>

        <%
            if (session.getAttribute("userMail") == null || session.getAttribute("userType")== null) {
                response.sendRedirect("index.jsp");
            }
        %>

        <%
          
            dbConnector db = new dbConnector();
            Connection conn = db.connect();
            
            String q = "select * from student where studentEmail=?";
            PreparedStatement ps = conn.prepareStatement(q);
            
            ps.setString(1, (String)session.getAttribute("userMail"));

            ResultSet rs = ps.executeQuery();
            
            rs.next();
            
            String name = rs.getString("studentName");
            
            int id = rs.getInt("studentId");

        %>
        
        <div id="Main">
            
        <h1>Student Portal</h1>
        
        <p>Hello <%= name %></p>
        
        <input type="submit" value="chat" onclick="chat()">

        </div>
        
        
        <form method="post" action="roomDispatcher" id="roomsForm">
            
            <%
              
                String q2 = "select * from studentrooms where studentId=?";
                
                PreparedStatement ps2 = conn.prepareStatement(q2);
         
                ps2.setInt(1, id);
                
                ResultSet rs2 = ps2.executeQuery();

            %>
            
            <select id="subject_select">
                
                <%
                  
                    out.println("<option value='default'>--Select the Subject--</option>");
                    
                    while(rs2.next()){
                        
                        String sub = rs2.getString("subject");
                        out.println("<option value='"+sub+"'>"+sub+"</option>");
                    
                    }
                %>
                
            </select>
                
            <input type="submit" value="Enter Chat">
            
        </form>
        
        
        <form action="logout" method="post">
            
            <input type="submit" value="Logout">
            
        </form>
        
        <script>
            
            var main = document.getElementById("Main");
            var rooms = document.getElementById("roomsForm");
            
            function chat(){
                
                main.style.display = "none";
                rooms.style.display = "block";
                
            }
            
        </script>
        
        
    </body>
</html>
