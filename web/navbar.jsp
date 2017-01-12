<%--
    Document   : navbar
    Created on : Dec 23, 2016, Dec 23, 2016 8:41:22 PM
    Author     : Giovanni
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="ranch.db.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="ranch.util.SessionControl"%>
<%@page import="ranch.models.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="ranch.util.Utilities"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <a class="navbar-brand" href="home.jsp">
                        <img title="home" id="site-min-logo" alt="Movie Ranch" src="data/images/site-logo.png">
                    </a>
                </div>
                <div id="user-menu" class="nav navbar-nav navbar-right">
                    <div class="dropdown" role="menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%=user.getUsername()%> <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="editprofile.jsp">Settings</a></li>
                            <li role="separator" class="divider"></li>
                            <li class="dropdown-header">Admin Options</li>
                            <li><a id="add-movie" href="javascript:void(0)">Add Movie</a></li>
                            <li><a href="viewEmails.jsp">View Emails</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="utilities?option=logout">Sign out</a></li>
                        </ul>
                    </div>
                </div>
                <div class="navbar-form navbar-right">
                    <form action="home.jsp">
                        <div class="form-group has-feedback">
                            <input id="search-bar" type="text" class="form-control" placeholder="Quick Search">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
            </div>
        </nav>
        <%@include file="movie_form.jsp"%>
        <%
                } else {
                    
        %>
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="containter-fluid"> <!-- occupy the entire page width -->
                <div class="navbar-header" style="width: 200px;">
                    <a class="navbar-brand" href="home.jsp">
                        <img title="home" id="site-min-logo" alt="Movie Ranch" src="data/images/site-logo.png">
                    </a>
                </div>
                <div id="user-menu" class="nav navbar-nav navbar-right">
                    <div class="dropdown" role="menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%=user.getUsername()%> <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="editprofile.jsp">Settings</a></li>
                            <li><a id="view-movie" href="javascript:void(0)">My Movies</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="utilities?option=logout">Sign out</a></li>
                        </ul>
                    </div>
                </div>
                <div class="navbar-form navbar-right">
                    <form action="search.jsp">
                        <div class="form-group has-feedback">
                            <input id="search-bar" type="text" class="form-control" placeholder="Quick Search">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
            </div>
        </nav>
        <div id="dialog-table" title="Your Movies"> 
            <table>
                <%
                    Connection con = DatabaseConnection.getActiveConnection();
                    PreparedStatement stmt = con.prepareStatement(
                            "SELECT * FROM movie WHERE id IN (SELECT movieId FROM renting WHERE userId = ?)");
                    stmt.setInt(1, user.getId());
                    ResultSet rs = stmt.executeQuery();
                    while(rs.next()) {
                %>
                <tr>
                    <td style="padding-bottom: 6px;"><image src="<%=rs.getString("posterLink")%>" alt="<%=rs.getString("name")%>" 
                               style="width: 100px; height: auto;"></td>
                    <td style="padding: 10px; text-align: left"><%=rs.getString("name")%><br>
                       <!-- <small>DUE DATE: <%-- new SimpleDateFormat("dd-MM-yyyy").format(new Date(rs.getDate("dueDate").getTime()))--%></small> --> </td>
                    <td style="padding: 10px;"><input id="<%= rs.getInt("id")%>-e" style ="width:150px; font-size: 12px" class="btn btn-default" 
                                                      type="button" value="Extend 1 Day"
                                                      onclick="
                                                        window.location.assign('utilities?option=extend&id=' + this.id.split('-')[0])"></td>
                    <td style="padding: 10px;"><input id="<%= rs.getInt("id")%>-r" style ="width:150px; font-size: 12px" class="btn btn-danger"
                                                      type="button" value="Return Movie"
                                                      onclick="
                                                        window.location.assign('utilities?option=return&id=' + this.id.split('-')[0])"></td>
                </tr>
                <% } 
                    con.close();
                %>
            </table>
        </div>
        <script>
        $(function() {  
            var dialog;
            dialog = $("#dialog-table").dialog({
                autoOpen: false,
                height: 500,
                width: 700,
                modal: true,
                buttons: {
                    Cancel: function() {
                        dialog.dialog("close");
                    }
                },
                position: {
                    my: "center",
                    at: "center center+20",
                    of: window                
                }
            });
            
            $("#view-movie").on("click", function() {
                dialog.dialog("open");
            });
        });
        </script>
        <%        
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
        %>
