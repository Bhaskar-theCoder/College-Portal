package app.controller;

import app.helper.dbConnector;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.Math;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Satya Bhaskar
 */
public class sendOtp extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        try ( PrintWriter out = response.getWriter()) {

            int max = 9999, min = 1000;
            int otpCode;

            dbConnector db = new dbConnector();
            Connection conn = db.connect();

            Statement stmt = conn.createStatement();
            String q = "select * from activeotps";
            ResultSet rs = stmt.executeQuery(q);

            //Checking whether the generated otp is already in active state
            
            while (true) {
                
                otpCode = (int) (Math.random() * (max - min + 1) + min);
                boolean flag = true;
                
                while (rs.next()) {
                    
                    if (rs.getInt("Otp") == otpCode) {
                        flag = false;
                    }
                    
                }
                if (flag) {
                    break;
                }
            }
            //out.println("True");
            
            //inserting the Otp into Database
            
            String to = request.getParameter("email");
            String userType = request.getParameter("user");
            String userId = request.getParameter("user_id");
            
            String q2 = "insert into activeotps values(?,?,?,current_timestamp())";
            PreparedStatement ps = conn.prepareStatement(q2);
            
            ps.setInt(1, otpCode);
            ps.setString(2, userId);
            ps.setString(3, userType);
            
            ps.executeUpdate();
            
            //out.println("True");
            
            
            String from = "emailspammer07@gmail.com";
            String subject = "Your Verification OTP";
            String msg = "Your OTP is: " + otpCode;

            String host = "smtp.gmail.com";

            Properties properties = System.getProperties();

            properties.put("mail.smtp.host", host);
            properties.put("mail.smtp.port", "465");
            properties.put("mail.smtp.ssl.enable", "true");
            properties.put("mail.smtp.auth", "true");

            Session s = Session.getInstance(properties, new Authenticator() {

                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("emailspammer07@gmail.com", "%^546rgFG56ger!duifYGvg3328r7e");
                }

            });

            s.setDebug(true);

            MimeMessage mMsg = new MimeMessage(s);

            try {

                mMsg.setFrom(new InternetAddress(from));
                mMsg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));

                mMsg.setSubject(subject);
                mMsg.setText(msg);

                Transport.send(mMsg);

                out.println("True");

            } catch (Exception e) {
                e.printStackTrace();
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
