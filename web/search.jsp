<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>search</title>
        
        <link rel="stylesheet" href="styles/bootstrap.min.css">
        <link rel="stylesheet" href="styles/bootstrap.min.css">
        <link rel="stylesheet" href="styles/jquery-ui.css" />
        <link rel="stylesheet" href="styles/main.css">
        <link rel="stylesheet" href="styles/base.css">
        <script src="scripts/jquery.min.js"></script>
        <script src="scripts/bootstrap.min.js"></script>
        <script src="scripts/jquery.min.js"></script>
        <script src="scripts/bootstrap.min.js"></script>
        <script src="scripts/jquery-1.12.1.min.js"></script>
        <script src="scripts/jquery-ui.min.js"></script>
        <script src="scripts/utilities.js?version=<%=new Random().nextInt(1000)%>"></script>
        <script>
            
            var firstStr = "<div class=\"col-md-4\">"
                    + "<div class=\"thumbnail\">"
                    + "<a href=\"";//reference of image(localhost
            var secondStr = "\"> <img src=\"";//image sourse
            var thirdStr = "\" class=\"myClass\" style=\"width:100%\">"
                            + "<div class=\"caption\">"
                            + "<p style=\"text-align:center\">";//movie name
            var forthStr = "</p> </div></a></div></div>";//finished :D
            var reference = "http://localhost:8080/movieranch/movies.jsp?id=";
            function search(){
                var form = document.getElementById("form");
                var value = form.searchval.value;
                var option = form.option.value;
                var outputPlace = document.getElementById("place");
                outputPlace.innerHTML = ""; // may need to be inner
                var request = new XMLHttpRequest();
                request.onreadystatechange = function (){
                    if (request.readyState == 4 && this.status == 200) {
                        var array = $.parseJSON(this.responseText);
                        debugger;
                        for(var i = 0;i < array.length;i++){
                            outputPlace.innerHTML += firstStr + reference + array[i].id + secondStr + array[i].imagePath
                            + thirdStr + array[i].name + forthStr;
                        }
                    }
                }
                request.open("POST", "utilities", true);
                request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                var requestStr = "option=search&value=" + value + "&key=" + option;
                request.send(requestStr);
            }
         </script>
        <style>

            body {
                background: -webkit-linear-gradient(to left, #003973 , #E5E5BE);
                background: linear-gradient(to left, #003973 , #E5E5BE);
                padding-top: 70px;
            }
            .myClass{
                border-radius: 10px;
                opacity: 0.8
            }
            .myClass:hover{
                opacity: 1
            }
        </style>
    </head>

    <body>
                <%@include file="navbar.jsp"%> 
        <form id="form">  
            <div class="row">
                <div class="form-group col-md-4">
                    <input type="text" name="searchval" placeholder="Search for..." class="form-control" required>
                </div> 
                <div class="form-group col-md-2">
                    <!--<label for="sel1">Select list (select one):</label>-->
                    <select class="form-control" name="option">
                        <option value="year">Release year</option>
                        <option value="name">Name</option>
                        <option value="actor">Lead Actor/Actress</option>
                    </select>
                </div>
                <div class="btn-group col-md-2">
                    <input type="button" class="btn btn-success" value="Search now" onclick="search()">
                </div>
            </div>
        </form>
        <div class="container">
            <div class="row" id="place">
                
            </div>
        </div>
    </body>
</html>
