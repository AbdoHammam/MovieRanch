<%-- 
    Document   : editmovie
    Created on : Dec 26, 2016, 3:45:30 PM
    Author     : andre
--%>

<%@page import="java.util.Random"%>
<%@page import="ranch.models.User"%>
<%@page import="ranch.models.Movie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Edit Movie | Movie Ranch</title>
        <link rel="stylesheet" href="styles/bootstrap.min.css">
        <script src="scripts/jquery.min.js"></script>
        <script src="scripts/bootstrap.min.js"></script>
        <link rel="stylesheet" href="http://jquery.com/jquery-wp-content/themes/jquery/css/base.css?v=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
        <link rel="stylesheet" href="styles/main.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.12.1.min.js"></script>
        <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
        <script src="scripts/utilities.js?version=<%=new Random().nextInt(1000)%>"></script>
        <script>
               function CancelButton(){
                   window.location.assign("home.jsp")
               }
        </script>
        <style>
            body {
                background-color: #f2f5f9
            }
        </style>
    </head>

    <body>
        <%@include file="navbar.jsp"%> 
        <%
            /*String token = "";
            Cookie[] cookies = request.getCookies();
            for (int i = 0; cookies != null && i < cookies.length; i++) {
                if (cookies[i].getName().equals("token")) {
                    token = cookies[i].getValue();
                    break;
                }
            }
            int id = SessionControl.getId(token, request);*/
            int id = Integer.parseInt(request.getParameter("id"));
            Movie movie = Movie.getMovie(id);
        %>
        <div class=" row">
            <div class="col-md-6">
                <img src="<%=movie.getPosterPath()%>" alt="<%=movie.getTitle() + " movie image\""%>" width="650" height="800">
            </div>
            <div class="col-md-6">
                <form action="UpdateMovie" class="form-group">
                    <input type="hidden" name="id" value="<%= movie.getId()%>">
                    <div class="text-center">
                        <h1 class="display-1"><%=movie.getTitle()%></h1>
                    </div>
                    <h3>Description</h3>
                    <div class="form-group col-md-11">
                        <textarea name="description" class="form-control" rows="3"><%=movie.getDescription()%></textarea>
                    </div>
                    <hr>
                    <h3>Details</h3>
                    <div class="input-group col-md-3">
                        <label for="msg">Released:</label>
                        <input id="msg" type="number" class="form-control" name="ReleasedDate" value="<%=movie.getYearOfRelease()%>">
                    </div>
                    <div class="input-group col-md-3">
                        <label for="msg1">Genre:</label>
                        <input id="msg1" type="text" class="form-control" name="genre" value="<%=movie.getGenre()%>">
                    </div>
                    <div class="input-group col-md-3">
                        <label for="msg5">Rating:</label>
                        <input id="msg5" type="number" class="form-control" name="rating" value="<%=movie.getRating()%>">
                    </div>
                    <div class="input-group col-md-3">
                            <label for="msg7">Lead <%if (movie.getLeadActor() == null) {
                        out.print("Actress");
                    } else 
                        out.print("Actor");%> </label>
                        <input id="msg7" type="text" class="form-control" name="<%if (movie.getLeadActor() == null) {
                                out.print("actress");
                            } else 
                                out.print("actor");%>" value="<%if (movie.getLeadActor() == null) {
                                        out.print(movie.getLeadActress());
                                   } else {
                                       out.print(movie.getLeadActor());
                                   }%>">
                    </div>


                    <div class="input-group col-md-3">
                        <label for="msg2">Cost per day:</label>
                        <input id="msg2" type="number" class="form-control" name="cost" value="<%= movie.getRentalPrice()%>">
                    </div>

                    <div class="input-group col-md-3">
                        <label for="msg3">Available copies:</label>
                        <input id="msg3" type="number" class="form-control" name="copies" value="<%= movie.getNumberOfAvailableCopies()%>">
                    </div>


                    <div class="btn-group col-md-offset-8">
                        <button type="button" class="btn btn-default" id="cancel" onclick="CancelButton()">Cancel</button>
                        <input type="submit" class="btn btn-success" value="Save" id="Save">
                    </div>
            </div>

        </form>

    </div>
</div>

</body>

</html>

