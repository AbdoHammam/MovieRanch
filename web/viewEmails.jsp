<%-- 
    Document   : viewEmails
    Created on : Dec 26, 2016, 7:24:33 PM
    Author     : asus
--%>
<%@page import="ranch.db.DatabaseConnection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Sent Emails | Admin</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body>

        <%
            String line;
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;

            try {
                Con = DatabaseConnection.getActiveConnection();
                Stmt = Con.createStatement();
                line = "SELECT * FROM emails";
                RS = Stmt.executeQuery(line);
            } catch (Exception cnfe) {
                System.err.println("Exception: " + cnfe);
            }

        %>

        <div class="container">
            <h2>Your sent Emails are to </h2>

            <table class="table">
                <thead>
                    <tr>

                        <th>Email</th>
                        <th>Movie name</th>
                    </tr>
                </thead>
                <tbody>
                    <%            while (RS.next()) {%>
                    <tr>
                        <td>
						<%
                           String x = RS.getString("renterEmail");
                            out.print(x);
                            %></td>
                        <td>
                            <%
                                out.print(RS.getString("movieName"));
                            %>
                        </td>

                    </tr>
                    <% } %>

                </tbody>
            </table>
        </div>

    </body>
</html>
