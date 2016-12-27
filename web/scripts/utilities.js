var HttpStatusCode = {
    OK : 200,
    NO_CONTENT : 204,
    BAD_REQUEST: 400,
    FORBIDDEN: 403,
    NOT_FOUND : 404,
    TIME_OUT : 408,
    UNSUPPORTED_MEDIA_TYPE : 415,
    INTERNAL_SERVER_ERROR: 500,
    BAD_GATEWAY : 502,
    SERVICE_UNAVAILABLE : 503
};

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) === 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function validateLogin() {
    var form = document.forms[0];
    var info = form.user.value;
    var error;
    if(info.length === 0) {
        form.children[0].className += " has-error";
        error = form.querySelectorAll("p")[0];
        error.innerHTML = "*username cannot be empty";
        error.removeAttribute("hidden");
        return false;
    }
    
    info = form.pass.value;
    if(info.length === 0) {
        form.children[3].className += " has-error";
        error = form.querySelectorAll("p")[2];
        error.innerHTML = "*password cannot be empty";
        error.removeAttribute("hidden");
        return false;
    }
    return true;
    //document.forms[0].submit() -- Not Needed, not anymore .. R.I.P
}

function prepareLogin() {
    var params = {
        option: "login",
        user: document.getElementsByName("user")[0].value, 
        pass: document.getElementsByName("pass")[0].value
    };
    return jQuery.param(params); //Encode URL parameters
}

function loginHandle(response) {
    if(response === 'OK')
        window.location.assign("home");
    else {
        var form = document.forms[0];
        form.children[0].className += " has-error";
        form.children[3].className += " has-error";
        var error = form.querySelectorAll("p")[2];
        error.innerHTML = "*wrong username or password";
        error.removeAttribute("hidden");
        form.login.disabled = false;
    }
}
    
function validateSignUp() {
    var passwordVerifier = {
        minLength: 6,
        maxLength: 26,
        hasOneLowerCaseCharacter: /[a-z]/,
        hasOneUpperCaseCharacter: /[A-Z]/,
        hasOneDigit: /[0-9]/,
        errors: []
    };
    
    var form = document.forms[1];
    
    var info = form.user.value;
    var error = form.querySelectorAll("p")[0];
    if(info.length === 0) {
        form.children[0].className += " has-error";
        error.innerHTML = "*username is required";
        error.removeAttribute("hidden");
        return false;
    }
    
    info = form.pass.value;
    error = form.querySelectorAll("p")[2];
    if(info.length === 0)
        passwordVerifier.errors.push("*password is required");
    else {
        if(info.length < passwordVerifier.minLength)
            passwordVerifier.errors.push("*password has to be at least " + passwordVerifier.minLength + " characters");
        else if(info.length > passwordVerifier.maxLength)
            passwordVerifier.errors.push("*password has to be at most " + passwordVerifier.maxLength + " characters");
        if(info.search(passwordVerifier.hasOneDigit) < 0)
            passwordVerifier.errors.push("*password must contain at least one digit");
        if(info.search(passwordVerifier.hasOneLowerCaseCharacter) < 0)
            passwordVerifier.errors.push("*password must contain a lowercase letter");
        if(info.search(passwordVerifier.hasOneUpperCaseCharacter) < 0)
            passwordVerifier.errors.push("*password must contain an uppercase letter");
    }
    
    if(passwordVerifier.errors.length > 0) {
        error.innerHTML = passwordVerifier.errors.join("<br>");
        form.children[3].className += " has-error";
        error.removeAttribute("hidden");
        return false;
    }
    
    info = form.repass.value;
    error = form.querySelectorAll("p")[4];
    if(info !== form.pass.value) {
        error.innerHTML = "*the two passwords don't match";
        form.children[6].className += " has-error";
        error.removeAttribute("hidden");
        return false;
    }
    
    info = form.email.value;
    error = form.querySelectorAll("p")[6];
    if(info.search(/^(?!.*[\s])(.+)@(.+)\.(.+)/) < 0) {
        error.innerHTML = "*incorrect email format";
        form.children[9].className += " has-error";
        error.removeAttribute("hidden");
        return false;
    }
    return true;
}

function prepareSignUp() {
    var params = {
        option: "signup",
        user: document.getElementsByName("user")[1].value,
        pass: document.getElementsByName("pass")[1].value,
        repass: document.getElementsByName("repass")[0].value,
        email: document.getElementsByName("email")[0].value,
        balance: document.getElementsByName("balance")[0].value
    };
    return jQuery.param(params);
}

function signUpHandle(response) {
    if(response === 'OK')
        window.location.assign("home");
    else {
        var form = document.forms[1];
        form.children[0].className += " has-error";
        form.user.select();
        var error = form.querySelectorAll("p")[0];
        error.innerHTML = "*username is taken by someone else";
        error.removeAttribute("hidden");
        form.signup.disabled = false;
    }
}

function prepareAddMovie() {
    var form = document.forms[1];
    var params = {
        option: "addMovie",
        name: form.title.value,
        year: form.year.value,
        copies: form.copies.value,
        poster: form.poster.value,
        price: form.price.value,
        director: form.director.value,
        actor: form.actor.value,
        actress: form.actress.value,
        rating: form.rating.value
    };
    return jQuery.param(params);
}

function addMovieHandle(response) {
    if(response === 'OK')
        alert("Movie Added Successfully!");
    else
        alert("Error Adding Movie!");
}

function jxRequest(method, url, prepare, handle) {
    var xhr = new XMLHttpRequest();
    var params = prepare();
    xhr.open(method, url);
    xhr.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if(xhr.readyState === xhr.DONE && xhr.status === HttpStatusCode.OK) {
            console.log(xhr.responseText);
            handle(xhr.responseText);
        }
    };
    xhr.send(params);
}