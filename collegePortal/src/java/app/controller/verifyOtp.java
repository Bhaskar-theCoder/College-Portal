package app.controller;

import app.helper.dbConnector;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Satya Bhaskar
 */
public class verifyOtp extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        try ( PrintWriter out = response.getWriter()) {
            
            dbConnector db = new dbConnector();
            Connection conn = db.connect();

            
            String userId = request.getParameter("user_id");
            String userType = request.getParameter("user");
            int Otp = Integer.parseInt(request.getParameter("user_otp"));
            
            
            String q = "select * from activeotps where userId=? and userType=? and Otp=?";
            
            //PreparedStatement
            
            PreparedStatement ps = conn.prepareStatement(q);
            
            ps.setString(1,userId);
            ps.setString(2,userType);
            ps.setInt(3,Otp);
            
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
            
            	out.println("True");
            	
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
