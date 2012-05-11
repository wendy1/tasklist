// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// $.update('/tasks/36', { complete: "true"}, function(response) { alert("response was: " + response);});

$(function($) {
	$('#tasklist .complete').on('change input',
		function(event) {
			// alert ("taskid = " + event.target.id);
               $.ajax({
                      type: "POST",
                      url: '/tasks/' + event.target.id + '.json',
                      data: { _method:'PUT', task : {complete: event.target.checked}},
                      dataType: 'json',
                      success: function(msg) {
                        alert( "Data Saved: " + msg );
                      }
            });
	    } 
	)
});

$(function($) {
	$('#tasklist .title').on('change input',
		function(event) {
             $.ajax({
                      type: "POST",
                      url: '/tasks/' + event.target.id + '.json',
                      data: { _method:'PUT', task : {title: event.target.value}},
                      dataType: 'json',
                      success: function(msg) {
                        alert( "Data Saved: " + msg );
                      }
            });
	    } 
	)
});

$(function($) {
	$('#tasklist .description').on('change input',
		function(event) {
             $.ajax({
                      type: "POST",
                      url: '/tasks/' + event.target.id + '.json',
                      data: { _method:'PUT', task : {description: event.target.value}},
                      dataType: 'json',
                      success: function(msg) {
                        alert( "Data Saved: " + msg );
                      }
            });
	    } 
	)
});

