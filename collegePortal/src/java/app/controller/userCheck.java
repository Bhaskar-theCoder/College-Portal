package app.controller;

import app.helper.dbConnector;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Satya Bhaskar
 */
public class userCheck extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        try ( PrintWriter out = response.getWriter()) {

            dbConnector db = new dbConnector();
            try ( Connection conn = db.connect()) {
                
                String name = request.getParameter("type");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                String q = "select * from " + name + " where " + name + "Email=? and " + name + "Password=?";

                PreparedStatement ps = conn.prepareStatement(q);

                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    
                    HttpSession hs = request.getSession();
                    hs.setAttribute("userMail", email);
                    hs.setAttribute("userType", name);
                    
                    if(name.equals("admin")){
                        //Admin Portal
                    }
                    else if(name.equals("faculty")){
                        //Faculty Portal
                    }
                    else if(name.equals("student")){
                        //Student Portal

                        RequestDispatcher rd = request.getRequestDispatcher("studentPortal.jsp");
                        rd.forward(request,response);
                    }
                    
                }
                else{
                    
                    out.println("<p><b>Invalid Credentials Please Try Again!</b></p>");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.include(request,response);

                }

                db.stop();
            }

        } catch (Exception e) {
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
