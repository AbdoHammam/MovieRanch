<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="ranch.db.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
    <head>
        <meta charset="utf-8">
        <meta name="author" content="Giovanni">
        <meta name="description" content="login and sign up page">
        <meta name="keywords" content="login, sign in, sign up, register, enter, create account">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Home | Movie Ranch</title>
        <link rel="stylesheet" href="http://jquery.com/jquery-wp-content/themes/jquery/css/base.css?v=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
        <link rel="stylesheet" href="styles/main.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.12.1.min.js"></script>
        <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
        <script src="scripts/utilities.js?version=<%=new Random().nextInt(1000)%>"></script>
    </head>
    <body>
        <%@include file="navbar.jsp"%> 
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header ft-cg" style="text-align: center; text-shadow: 1px 1px gray">Movie Gallery</h1>
                </div>
                <%
                    Connection con = DatabaseConnection.getActiveConnection();
                    PreparedStatement stmt = con.prepareStatement("SELECT * FROM movie WHERE availableNumber > 0");
                    ResultSet rs = stmt.executeQuery();
                    while(rs.next()) {
                %>
                <div class="col-lg-3 col-md-4 col-xs-6 thumb">
                    <div class="thumbnail">
                        <a href="movies.jsp?id=<%=rs.getInt("id")%>"><img class="img-responsive" src="<%=rs.getString("posterLink")%>" alt=""></a>
                        <p class="movie-title"><%=rs.getString("name")%></p>
                        <input class="btn btn-info btn-rent" value="Rent" type="button" 
                               onclick="window.location.assign('movies.jsp?id=<%=rs.getInt("id")%>')">
                        <span class="price-label ft-cg"><%=rs.getString("rentingPrice")%>$/day</span>
                    </div>
                </div>
                <% } con.close(); %>
            </div> 
        </div>
    </body>
</html>