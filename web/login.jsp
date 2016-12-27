<%-- 
    Document   : noneofyourbusiness
    Created on : Dec 23, 2016, Dec 23, 2016 8:41:22 PM
    Author     : Giovanni
--%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
    <head>
        <meta http-equiv="cache-control" content="no-cache" />
        <meta charset="utf-8">
        <meta name="author" content="Giovanni">
        <meta name="description" content="login and sign up page">
        <meta name="keywords" content="login, sign in, sign up, register, enter, create account">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login | Movie Ranch</title>
        <link rel="stylesheet" href="styles/bootstrap.min.css">
        <link rel="stylesheet" href="styles/jquery-ui.css" />
        <link rel="stylesheet" href="styles/base.css">
        <link rel="stylesheet" href="styles/main.css">
        <script src="scripts/jquery.min.js"></script>
        <script src="scripts/bootstrap.min.js"></script>
        <script src="scripts/jquery-ui.min.js"></script>
        <script src="scripts/utilities.js?version=<%=new Random().nextInt(1000)%>"></script>
        <script>
            $( function() {
                document.forms[0].reset();
                document.forms[1].reset();
                $( "#spinner" ).spinner({
                    classes: {
                        "ui-spinner": "ui-corner-tr ui-corner-br"
                    },
                    min: 10,
                    max: 999999,
                    step: 5,
                    start: 100,
                    numberFormat: "C",
                    culture: "us"
                });
            });
        </script>
    </head>
    <body>
        <div id="logo-section" class="ft-cg">
            <img  id="logo" src="data/images/site-logo.png"><br>
            <small>Rent Movies Online</small>
        </div>
        <h2 id="welcome" class="ft-cg">Welcome to Movie Ranch!</h2>
        
        <div class="container col-md-6 col-md-offset-3">
            <ul class="nav nav-tabs">
                <li class="active wide-tab ft-cg"><a data-toggle="tab" href="#login-tab" onclick="this.blur()">Login</a></li>
                <li class="wide-tab ft-cg"><a data-toggle="tab" href="#signup-tab" onclick="this.blur()">Sign up</a></li>
            </ul>
            
            <div class="tab-content">
                <div id="login-tab" class="tab-pane fade in active">
                    <form action="javascript:void(0)" method="post">
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="glyphicon glyphicon-user"></i></span>
                            <input class="form-control" type="text" name="user"
                                   placeholder="Username" onfocus="
                                       document.forms[0].querySelectorAll('p')[0].setAttribute('hidden', true);">
                        </div>
                        <p class="error-msg" hidden><p> <!-- 0 -->
                            
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="glyphicon glyphicon-lock"></i></span>
                            <input class="form-control" type="password" name="pass"
                                   placeholder="Password" onfocus="
                                       document.forms[0].querySelectorAll('p')[2].setAttribute('hidden', true);">
                        </div>
                        <p class="error-msg" hidden><p> <!-- 2 -->
                            
                        <div class="input-group">
                            <input class="btn btn-success ft-cg" type="button" value="Log in" name="login"
                                onclick="if(validateLogin()) {
                                    this.disabled = true;
                                    jxRequest('POST', 'utilities', prepareLogin, loginHandle);
                                }">
                        </div>
                    </form>
                </div>
                
                <div id="signup-tab" class="tab-pane fade">
                    <form action="javascript:void(0)" method="post">
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="glyphicon glyphicon-user"></i></span>
                            <input class="form-control" type="text" name="user"
                                    placeholder="Username (e.g. smith400)" onfocus="
                                       document.forms[1].querySelectorAll('p')[0].setAttribute('hidden', true);">
                        </div>
                        <p class="error-msg" hidden><p> <!-- 0 -->
                            
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="glyphicon glyphicon-lock"></i></span>
                            <input class="form-control" type="password" name="pass"
                                   placeholder="Password" onfocus="
                                       document.forms[1].querySelectorAll('p')[2].setAttribute('hidden', true);">
                        </div>
                        <p class="error-msg" hidden><p> <!-- 2 -->
                            
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="glyphicon glyphicon-lock"></i></span>
                            <input class="form-control" type="password" name="repass"
                                   placeholder="Confirm Password" onfocus="
                                       document.forms[1].querySelectorAll('p')[4].setAttribute('hidden', true);">
                        </div>
                        <p class="error-msg" hidden><p> <!-- 4 -->
                            
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="glyphicon glyphicon-envelope"></i></span>
                            <input class="form-control" type="email" name="email"
                                   placeholder="Email" onfocus="
                                       document.forms[1].querySelectorAll('p')[6].setAttribute('hidden', true);">
                        </div>
                        <p class="error-msg" hidden><p> <!-- 6 -->
                            
                        <div class="input-group">
                            <span class="input-group-addon">
                            <i class="glyphicon glyphicon-usd"></i></span>
                            <input id="spinner" class="cus-ph" name="balance" 
                                   placeholder="Credit amount" style="padding: 12px;
                                   font-size: 14px;
                                   color: #555555;" onfocus="
                                       document.forms[1].querySelectorAll('p')[8].setAttribute('hidden', true);">
                        </div>
                        <p class="error-msg" hidden><p> <!-- 8 -->
                            
                        <div class="input-group">
                            <input class="btn btn-info ft-cg" type="button" value="Sign up" name="signup"
                                   onclick="if(validateSignUp()) {
                                        this.disabled = true;
                                        jxRequest('POST', 'utilities', prepareSignUp, signUpHandle);
                                    }">
                        </div>
                    </form>
                </div>
            </div>
            <br><br><br><br>
        </div>
    </body>
</html>