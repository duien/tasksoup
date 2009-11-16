$(function(){
  $("#sidebar .content").load("/projects?embed=true");
});

function add_and_bind_form( to, project_id ) {
  to.load("/projects/" + project_id + "/tasks/new?embed=true", function() { 
    $("form").ajaxForm({ success: function(data, textStatus){
      $("#main .content").html( data );
    }});
    $("#task_expand").click(function(){
      var input = $(this).siblings("#task_text");
      var value = input.val();
      input.replaceWith( "<textarea name='task[text]' id='task_text'>"+value+"</textarea>" );
      $(this).remove();
    });
    $("#task_cancel").click(function(){
      to.siblings('.add_link').css('display', 'inline');
      to.html( "" );
      to.css('display', 'none');
    });
    $(this).siblings('.add_link').css('display', 'none');
    $(this).css('display', 'block');
    $("#task_text").focus();
  });
};

function add_and_bind_project_form( to ) {
  to.load("/projects/new?embed=true", function() { 
    $(this).find("form").ajaxForm({ success: function(data, textStatus){
      // alert( data + "..." + textStatus );
      $("#sidebar .content").html( data );
    }});
  });
};
  
