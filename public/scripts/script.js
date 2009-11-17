$(function(){
  // Load the sidebar
  $("#sidebar .content").load("/projects?embed=true");
  
  // Set up editing
  $("li.task").each(function(){
    var task_id = $(this).attr('id');
    
    // Editable text
    $("div.text", this).editable('/tasks/'+task_id+'/edit', {
      tooltip: 'Double-click to edit.',
      event: 'dblclick',
      name: 'task[text]',
      submit: 'Submit',
      type: 'textarea',
      width: 500,
      loadurl: '/tasks/'+task_id+'?only=text'
    });
    
    
    var timer;
    
    // Successor status
    // $("div.status", this).click(function(){ 
    //   timer = setTimeout( "$(this).load('/tasks/'"+task_id+"'/edit', { 'task[status]': 'succ' }, function(value){ $(this).parent().attr('class', 'task '+value); })", 500);
    // });
    // 
    // $("div.status", this).dblclick(function(){
    //   clearTimeout(timer);
    // });
    
    // Editable status
    $("div.status", this).editable('/tasks/'+task_id+'/edit', {
      event: 'dblclick',
      name: 'task[status_id]',
      type: 'select',
      loadurl: '/statuses/chained',
      onblur: 'submit',
      callback: function(value, options){ 
        $(this).parent().attr('class', 'task '+value);
      }
    });
  });
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
  
