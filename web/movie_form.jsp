<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <div id="dialog-form" title="Add New Movie"> 
            <form>
                <fieldset>
                    <label for="title">Movie Title</label>
                    <input type="text" name="title" id="title" class="text ui-widget-content ui-corner-all" required>
                    <label for="year">Release</label>
                    <input type="text" name="year" id="year" class="text ui-widget-content ui-corner-all" required>
                    <label for="copies">Number of copies</label>
                    <input type="text" name="copies" id="copies" class="text ui-widget-content" required>
                    <label for="poster">Poster URL</label>
                    <input type="text" name="poster" id="poster" class="text ui-widget-content" required>
                    <label for="price">Rental Price</label>
                    <input type="text" name="price" id="price" class="text ui-widget-content" required>
                    <label for="director">Director</label>
                    <input type="text" name="director" id="director" class="text ui-widget-content" required>
                    <label for="actor">Lead Actor</label>
                    <input type="text" name="actor" id="actor" class="text ui-widget-content" required>
                    <label for="actress">Lead Actress</label>
                    <input type="text" name="actress" id="actress" class="text ui-widget-content" required>
                    <label for="rating">Rating</label>
                    <input type="number" min="1" max="10" name="rating" 
                        id="rating" class="text ui-widget-content" required>       
                    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
                </fieldset>
            </form>
        </div>
        <script>
        $(function() {  
            var dialog;
            var form = document.forms[1];
            dialog = $("#dialog-form").dialog({
                autoOpen: false,
                height: 500,
                width: 400,
                modal: true,
                buttons: {
                    "Add Movie": function() {
                        jxRequest('POST', 'utilities', prepareAddMovie, addMovieHandle);
                    },
                    Cancel: function() {
                        dialog.dialog("close");
                    }
                },
                close: function() {
                    form.reset();
                },
                position: {
                    my: "center",
                    at: "center center+20",
                    of: window                
                }
            });
            
            $("#add-movie").on("click", function() {
                dialog.dialog("open");
            });
        });
        </script>
