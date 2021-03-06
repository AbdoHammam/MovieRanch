<%-- 
    Document   : editprofile
    Created on : Dec 22, 2016, 9:52:31 PM
    Author     : andre
--%>

<%@page import="java.util.Random"%>
<%@page import="ranch.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>View Movie | Movie Ranch</title>
        <link rel="stylesheet" href="styles/bootstrap.min.css">
        <script src="scripts/jquery.min.js"></script>
        <script src="scripts/bootstrap.min.js"></script>
        <script src="scripts/utilities.js"></script>
        <link rel="stylesheet" href="styles/base.css">
        <link rel="stylesheet" href="styles/jquery-ui.css" />
        <link rel="stylesheet" href="styles/main.css">
        <script src="scripts/jquery-1.12.1.min.js"></script>
        <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
        <script src="scripts/utilities.js?version=<%=new Random().nextInt(1000)%>"></script>
        <script>
            var password = "";
            (function getPass(){
                var request = new XMLHttpRequest();
                request.onreadystatechange = function () {
                    if (request.readyState == 4 && this.status == 200) {
                        password = this.responseText;
                        debugger;
                    }
                }
                var token = getCookie("token");
                //debugger;
                request.open("POST", "utilities", true);
                request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                var requestStr = "token=" + token + "&option=getPassword";
                request.send(requestStr);
            })()
           
            function checkPass(form){
                if(password != form.oldPassword.value){
                    alert("your password doesn't match the saved one");
                    return false;
                }
                if (form.newPassword.value.length > 0) {
                    if (form.newPassword.value.length < 8) {
                        alert("new password can't be less than 8 characters");
                        return false;
                    }
                    if (form.newPassword.value != form.newPasswordVerification.value) {
                        alert("new password and it's verification doesn't match each other");
                        return false;
                   }
                }
                return true;
            }
        </script>
        <style>
            .rounded {
                border-radius: 20px;
                background-color: white;
                color: #64B5F6
            }

            body {
                background-color: #cadcf9
            }
        </style>
    </head>

    <body>
        <%@include file="navbar.jsp"%> 
        <%
            String sessionId = "token";
            Cookie[] cookies = request.getCookies();
            for (int i = 0; cookies != null && i < cookies.length; i++) {
                if (cookies[i].getName().equals("token")) {
                    sessionId = cookies[i].getValue();
                    break;
                }
            }
            int id = SessionControl.getId(sessionId, request);
            User user = User.getUser(id);
        %>
        <div class="jumbotron col-md-10 col-md-offset-1 rounded ">
            <div class=" text-center">
                <h2>User profile settings</h2>
            </div>
            <br>
            <hr>
            <form class="form-horizontal col-md-offset-1 " onsubmit= "return checkPass(this)" action="UpdateProfile" >
                <input type="hidden" value="<%=id%>" name="id">
                <div class="form-group">
                    <div class="input-group col-md-3">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input type="text" class="form-control" value="<%=user.getUsername()%>" name="name" required>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group col-md-3">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input type="password" name="oldPassword" class="form-control" placeholder="Enter old password" maxlength="16">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group col-md-3">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input type="password" name="newPassword" class="form-control" placeholder="Enter new password" maxlength="16">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group col-md-3">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input type="password" name="newPasswordVerification" class="form-control" placeholder="Verify new password" maxlength="16">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group col-md-3">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
                        <input name="registerDate" class="form-control" value="<%=user.getDateOfJoin()%>" readonly>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group col-md-3" style="clear: both;">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
                        <input type="number" value="<%=user.getBalance()%>" class="form-control" name="currentBalance" max="6000" required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group col-md-3">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                        <input type="email" name="email" class="form-control" value="<%=user.getEmail()%>" size="30" required>
                    </div>
                </div>



                <div class="form-group col-md-3">
                    <div class="form-group">
                        <label for="gender">Gender: </label>
                        <select class="form-control" name="gender">
                                <option value="male"<%if (user.getGender().equals("male")) 
                                        out.print(" selected");%>>male</option>
                            <option value="female"<%if (user.getGender().equals("female")) 
                                    out.print(" selected");
                                    %>>female</option>
                            <!--<option value="null">don't specify</option> --> <!-- i think this is useless--> 
                        </select>
                    </div>

                </div>

                <div class="form-group col-md-3" style="clear: both;">
                    <div class="form-group">
                        <label for=address>Address</label>
                        <input type="text" name="address" class="form-control" value="<%=user.getAddress()%>" required>
                    </div>

                </div>

                <div class="btn-group col-md-offset-8">
                    <button type="button" class="btn btn-default" formaction="">Cancel</button>
                    <input type="submit" class="btn btn-success" value="Save Changes">
                </div>
            </form>

        </div>


    </body>

</html>

