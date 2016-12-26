<%-- 
    Document   : navbar
    Created on : Dec 23, 2016, Dec 23, 2016 8:41:22 PM
    Author     : Giovanni
--%>
<%@page import="ranch.util.SessionControl"%>
<%@page import="ranch.models.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="ranch.util.Utilities"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>no title</title>
    </head>
    <body>
        <%
            HashMap<String, HttpSession> sessionManager = 
                    (HashMap<String, HttpSession>)application.getAttribute("sessionManager");
            Cookie cookie = SessionControl.acquireCookie("token", request); //Check if user is logged in
            if(cookie != null) {
                User user = (User)(sessionManager.get(cookie.getValue()).getAttribute("user"));
                if(user.isIsAdmin()) {          
        %>
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="containter-fluid"> <!-- occupy the entire page width -->
                <div class="navbar-header" style="width: 200px;">
                    <a class="navbar-brand" href="home.html">
                        <img title="home" id="site-min-logo" alt="Movie Ranch" src="site-logo.png">
                    </a>
                </div>
            </div>
        </nav>
        <%
                } else {
                    
        %>
         <nav class="navbar navbar-default navbar-fixed-top">
            <div class="containter-fluid"> <!-- occupy the entire page width -->
                <div class="navbar-header" style="width: 200px;">
                    <a class="navbar-brand" href="home.html">
                        <img title="home" id="site-min-logo" alt="Movie Ranch" src="site-logo.png">
                    </a>
                </div>
            </div>
        </nav>
        <%        
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
        %>
    </body>
</html>
