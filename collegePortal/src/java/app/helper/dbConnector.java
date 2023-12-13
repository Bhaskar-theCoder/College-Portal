package app.helper;

import java.sql.*;

/**
 *
 * @author Satya Bhaskar
 */
public class dbConnector {

    Connection conn;

    public Connection connect() {
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/collegeportal","root","#GnhW*!9g27$%tc#&%");
        }catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
    public void stop(){
        try{
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
