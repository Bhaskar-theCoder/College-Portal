<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            #admin{
                display : none;
            }
            #faculty{
                display: none;
            }
            #student{
                display: none;
            }
            #msg{
                display: none;
            }
            .type{
                display: none;
            }
        </style>
    </head>
    <body>
        
        
        
        <%
            if (session.getAttribute("userMail") != null && session.getAttribute("userType") != null) {
                if(session.getAttribute("userType").equals("student"))
                    response.sendRedirect("studentPortal.jsp");
                else if(session.getAttribute("userType").equals("faculty"))
                    response.sendRedirect("facultyPortal.jsp");
                else if(session.getAttribute("userType").equals("admin"))
                    response.sendRedirect("adminPortal.jsp");
            }
        %>
        
        
        
        
        
        
        
        
        
        <input type="button" value="Admin Login" onclick="admin()">
        <input type="button" value="Faculty Login" onclick="faculty()">
        <input type="button" value="Student Login" onclick="student()"><br><br>

        <form id="admin" action="userCheck" method="post">

            <h1 id="header">Admin Portal Login</h1><br>

            <input type="text" value="admin" name="type" class="type">
            <input type="email" placeholder="Enter Your Email" name="email"><br>
            <input type="password" placeholder="Enter Your Password" name="password"><br>
            <input type="submit" value="Login">
            <a href="forgot.jsp">Forgot Password</a>

        </form>
        <form id="faculty" action="userCheck" method="post">

            <h1 id="header">Faculty Portal Login</h1><br>

            <input type="text" value="faculty" name="type" class="type">
            <input type="email" placeholder="Enter Your Email" name="email"><br>
            <input type="password" placeholder="Enter Your Password" name="password"><br>
            <input type="submit" value="Login">
            <a href="forgot.jsp">Forgot Password</a>

        </form>
        <form id="student" action="userCheck" method="post">

            <h1 id="header">Student Portal Login</h1><br>

            <input type="text" value="student" name="type" class="type">
            <input type="email" placeholder="Enter Your Email" name="email"><br>
            <input type="password" placeholder="Enter Your Password" name="password"><br>
            <input type="submit" value="Login">
            <a href="forgot.jsp">Forgot Password</a>

        </form>

        <p id="msg"><b></b></p>


        <script
            src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
            crossorigin="anonymous">
        </script>
        
        <script>
           
           var adminPortal = document.getElementById("admin");
           var facultyPortal = document.getElementById("faculty");
           var studentPortal = document.getElementById("student");
           
           function admin(){
               
               facultyPortal.style.display = "none";
               studentPortal.style.display = "none";
               adminPortal.style.display = "block";
           }
           
           function faculty(){
               
               adminPortal.style.display = "none";
               studentPortal.style.display = "none";
               facultyPortal.style.display = "block";
           }
           
           function student(){
               
               adminPortal.style.display = "none";
               facultyPortal.style.display = "none";
               studentPortal.style.display = "block";
           }

           
            function logInto() {


                var mailId = $("#userMail").val();
                var pswd = $("#userPswd").val();
                
                console.log(mailId);
                console.log(pswd);
                console.log("Check1");
                $.ajax({

                    url: "userCheck",
                    method: "post",
                    data: {Type: type,email: mailId, password: pswd},
                    success: function (data) {
                        console.log(data);
                        if (data) {
                            // 3.
                            // 4. is -> linking of chat with the portal
                            if (type === 1) {

                                //redirect to admin portal
                                console.log("Successfully logged in Admin");

                            } else if (type === 2) {

                                //redirect to faculty portal
                                console.log("Successfully logged in Faculty");

                            } else if (type === 3) {

                                //rediect to student portal
                                console.log("Successfully logged in Student");
                                
                            }

                        } else {
                            $("#msg").html("Your Credentials doesn't exists");
                            var error = document.getElementById("msg");
                            error.style.display = "block";
                            console.log("Unsuccessfully logged in");
                        }

                    }

                });
            }

        </script>
    </body>
</html>
