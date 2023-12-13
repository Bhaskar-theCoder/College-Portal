<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
        <style>
            #otpForm{
                display: none;
            }
            #loader{
                display: none;
            }
            #createPassword{
                display: none;
            }
        </style>
    </head>
    <body>
        <div id="forgot">

            <input type="text" placeholder="Enter Your ID" id="user_id"><br><br>
            <select id="user_type">
                <option value="default">--Select User Type--</option>
                <option value="admin">Admin</option>
                <option value="faculty">Faculty</option>
                <option value="student">Student</option>
            </select><br><br>
            <input type="button" value="Send OTP" onclick="forget()">

        </div>

        <div id="otpForm">

            <input type"text" placeholder="Enter Your OTP" id="otp">
            <input type="button" value="Verify OTP" onclick="verify()">
            <b><p id="sent"></p></b>
        </div>

        <div id="createPassword">

            <input type="password" placeholder="Create New Password" id="newPassword">
            <input type="button" value="Change Password" onclick="change()"> 

        </div>




        <b><div id="loader"></div></b>


        <script
            src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
            crossorigin="anonymous">
        </script>

        <script>
            var userType;
            var userId;
            var loader = document.getElementById("loader");
            var servletUserEmail;
            function forget() {


                //ajax call to verify the email record in database{
                // should return the userId and set it to servletUserId
                
                userType = $('#user_type').val();
                userId = $('#user_id').val();
                
                $.ajax({

                    url: "userForgot",
                    method: "post",
                    data: {Type: userType,Id: userId},
                    success: function (data) {

                        servletUserEmail = data;

                        if (servletUserEmail) {
                            
                            console.log(servletUserEmail);
                            sendOtp();
                            showOtpForm();
                            console.log("Success True User");
                        } else {

                            console.log("Something Went Wrong or Invalid User");

                        }

                    }

                }); 
            }

            function showOtpForm() {

                var forget = document.getElementById("forgot");
                var otp = document.getElementById("otpForm");

                forget.style.display = "none";
                otp.style.display = "block";
            }

            function verify() {

                //verify the otp by sending a ajax request to db
                //if true then -> allow user to create a new password
                //else deny the permission

                var userOtp = $('#otp').val();
                var sent = document.getElementById("sent");
                sent.style.display = "none";
                
                $.ajax({

                    url: "verifyOtp",
                    method: "post",
                    data: {user_id: userId, user: userType, user_otp: userOtp},
                    success: function (data) {

                        if (data) {

                            console.log(data);
                            console.log("OTP matched");
                            
                            
                            //Show Create New Password Form
                            var otpForm = document.getElementById("otpForm");
                            otpForm.style.display="none";
                            var newForm = document.getElementById("createPassword");
                            newForm.style.display = "block";
                        } else {
                            console.log("Invalid OTP");
                            
                            loader.innerHTML = "OTP Not Matched Successfully";
                            loader.style.display = "block";
                            
                            //ajax call to resend otp

                        }

                    }

                });

            }

            function sendOtp() {

                //ajax to a send servlet
                console.log(userType);
                $.ajax({
                    url: "sendOtp",
                    method: "post",
                    data: {email: servletUserEmail, user: userType, user_id: userId},
                    beforeSend: function () {
                        loader.innerHTML = "OTP is being generated.......Please Wait";
                        loader.style.display = "block";
                    },
                    success: function (data) {
                        loader.innerHTML = "";
                        loader.style.display = "none";
                        if (data) {
                            $('#sent').html("OTP sent Successfully!");
                            console.log("Sent");
                        } else {
                            $('#sent').html("Something Went wrong please try again later!");
                            console.log("Not Sent");
                            console.log(data);
                            console.log(typeof data);
                        }
                    }
                });

            }

            function  change() {

                //Change Password	
                var pswd = $('#newPassword').val();
                //ajax call to changePassword

                $.ajax({

                    url: "changePassword",
                    method: "post",
                    data: {Id:userId,user: userType,password: pswd},
                    success: function (data) {

                        if (data) {
                            
                            console.log(data);
                            console.log("Password Changed Successfully");
                            loader.innerHTML = "Password Changed Successfully!<br><a href='index.jsp'>Click Here to Login</a>";
                            loader.style.display = "block";
                            // ajax call to delete the generated otp

                        } else {

                            console.log("Something Went Wrong");
                        }
                    }

                });


            }

        </script>
    </body>
</html>
