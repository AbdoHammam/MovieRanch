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

$(function() {  
    var dialog, form;
    dialog = $("#dialog-form").dialog({
        autoOpen: false,
        height: 500,
        width: 400,
        modal: true,
        buttons: {
            "Add Movie": function() {},
            Cancel: function() {
                dialog.dialog("close");
            }
        },
        close: function() {
            form[0].reset();
        },
        position: {
            my: "center",
            at: "center center+20",
            of: window                
        }
    });
    
    form = dialog.find("form").on("submit", function(event) {
        //AJAX GOES HERE
    });
    
    $("#add-movie").on("click", function() {
        dialog.dialog("open");
    });
});

function jxRequest(url, handle) {
    var xhr = new XMLHttpRequest();
    xhr.open(url);
    xhr.onreadystatechange = function() {
        if(xhr.readyState === XMLHttpRequest.OK && xhr.status === HttpStatusCode.OK) {
            //do something
        }
    };
    xhr.send();
}
