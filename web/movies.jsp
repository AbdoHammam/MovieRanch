<%-- 
    Document   : movies
    Created on : Dec 21, 2016, 5:32:28 PM
    Author     : andre
--%>

<%@page import="java.util.Random"%>
<%@page import="ranch.models.Movie"%>
<%@page import="ranch.db.DatabaseModule"%>
<%@page import="ranch.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>movies</title>
        <link rel="stylesheet" href="styles/base.css?v=1">
        <link rel="stylesheet" href="styles/bootstrap.min.css">
        <link rel="stylesheet" href="styles/jquery-ui.css" />
        <link rel="stylesheet" href="styles/main.css">
        <script src="scripts/jquery.min.js"></script>
        <script src="scripts/bootstrap.min.js"></script>
        <script src="scripts/jquery-1.12.1.min.js"></script>
        <script src="scripts/jquery-ui.min.js"></script>
        <script src="scripts/utilities.js?version=<%=new Random().nextInt(1000)%>"></script>
        
        <script>
            var isClicked = false;
            $(document).ready(function () {
                $("#buttonX").click(function () {
                    debugger;
                    if (isClicked)
                        $("#checkdiv").slideUp("slow");
                    else
                        $("#checkdiv").slideDown("slow");
                    isClicked = !isClicked;
                })
            })
            
            function check(){
             //   var userId = getCookie("id");
                var duration = document.getElementById("duration").value;
                if(duration.length == 0){
                    debugger;
                    document.getElementById("duration").focus();
                    alert("you must enter a value");
                    return;
                }
                var request = new XMLHttpRequest();
                request.onreadystatechange = function(){
                    if(request.readyState == 4 && this.status == 200){
                        var response = this.responseText;
                        debugger;
                        if(response.charAt(0) == 'e')
                            alert("you don't have enough balance");
                        else
                        {
                            alert("rented !, your current balance is " + response);
                            
                            //location.reload(true);
                            window.location.assign("home.jsp");
                        } 
                    }
                }
                request.open("POST","utilities" , true);
                var id = getCookie("token");
                request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                var movieId = window.location.search.substring(window.location.search.indexOf("id=") + 3);
                var requestStr = "token=" + id + "&duration="+duration+"&option=rentMovie&xid=" + movieId;
                debugger;
                request.send(requestStr);
                
            }
        </script>
        <style>

            body {
                background-color: #f2f5f9
            }
            #checkdiv{
                display: none;
                padding: 50px;
            }
        </style>
    </head>

    <body>
        <%@include file="navbar.jsp" %>
        <%
            int id = -1;
            Cookie[] cookies = request.getCookies();
            for (int i = 0; cookies != null && i < cookies.length; i++) {
                if (cookies[i].getName().equals("id")) {
                    id = Integer.parseInt(cookies[i].getValue());
                    break;
                }
            }
            User user = User.getUser(id);// to be used in the top bar, after it's added !
            id = Integer.parseInt(request.getParameter("id"));
            Movie movie = Movie.getMovie(id);
        %>
        <div id="checkdiv">
            <h4>please enter the number of dates to rent</h4>
                <div class="input-group col-md-3">
                    <input type="number" id="duration" class="form-control" required="true">
                </div>
            <input type="submit" onclick="check()" value="check" class="btn btn-primary btn-md" >
        </div>
        <div class=" row">
            <div class="col-md-6">
                <img src="<%=movie.getPosterPath()%>" alt="<%=movie.getTitle() + " movie image\""%>">
                     </div>
                     <div class="col-md-6">
                     <div class="text-center">
                    <h1 class="display-1"><%=movie.getTitle()%></h1>
                </div>
                <h3>Description</h3>
                <p><%=movie.getDescription()%></p>
                <hr>
                <h3>Details</h3>
                <p><b>Released: </b><%=movie.getYearOfRelease()%></p>
                <p><b>Genre: </b><%=movie.getGenre()%></p>
                <p><b>Rating: </b><%=movie.getRating()%></p>
                <p><b>Lead 

                        <%if (movie.getLeadActor() == null) {
                                out.print("Actress: </b>: " + movie.getLeadActress());

                            } else {
                                out.print("Actor: </b>: " + movie.getLeadActor());
                            }

                        %></p>

                <p><b>Cost per day </b><%= movie.getRentalPrice()%></p>
                <p><b>Available copies: </b><%= movie.getNumberOfAvailableCopies()%></p>

                <button type="button" id="buttonX" class="btn btn-primary btn-md" <% if (movie.getNumberOfAvailableCopies() == 0) {
                        out.print(" disabled");
                    }%>>Rent</button>
            </div>
        </div>

    </body>
</html>
