$(function(){
  // Load the sidebar
  $("#sidebar .content").load("/projects?embed=true");
  
  // Set up editing
  $("li.task").each(function(){
    bind_task_actions($(this));
  });
  
  // Toggle status filters
  $("#filter span.status").toggle( function(){ $(this).addClass('selected') },
                                   function(){ $(this).removeClass('selected') });
  $("#filter span.type").toggle( function(){ $(this).css('border-color', '#000');
                                             $("#filter").find("."+$(this).text()+"_type span.status").addClass('selected_type');
                                            },
                                 function(){ $(this).css('border-color', '#eee');
                                             $("#filter").find("."+$(this).text()+"_type span.status").removeClass('selected_type');
                                            });
  $("#filter span.chain").toggle( function(){ $(this).css('border-color', '#000');
                                              $("#filter").find("."+$(this).text()+"_chain span.status").addClass('selected_chain');
                                             },
                                  function(){ $(this).css('border-color', '#eee');
                                              $("#filter").find("."+$(this).text()+"_chain span.status").removeClass('selected_chain');
                                             });
});

function bind_task_actions( what ){
  var task_id = what.attr('id');
  what.children(".text,.status,.controls").hover( function(){$(this).parent().addClass('hover')}, function(){$(this).parent().removeClass('hover')} );
  
  what.children(".controls").children("a.edit").each(function(){
    $(this).click(function(){
      // Swap in form for editing
      $(this).parent().parent().load('/tasks/'+task_id+'/edit', function(){
        $("form").ajaxForm({ success: function( data, textStatus){
          $("li.task#"+task_id).replaceWith(data);
          bind_task_actions($("li.task#"+task_id));
          $("li.task#"+task_id).find("li.task").each(function(){
            bind_task_actions($(this));
          });
        }});
        
        // Form button actions
        $("#task_expand").click(function(){
          var input = $(this).siblings("#task_text");
          var value = input.val();
          input.replaceWith( "<textarea name='task[text]' id='task_text'>"+value+"</textarea>" );
          $(this).remove();
        });
      });
    });
    $(this).hide();
  });
  
  // Successor status
  what.children(".task div.status").click(function(){ 
    $(this).load('/tasks/'+task_id+'/edit', { 'task[status]': 'succ' }, function(value){ $(this).parent().attr('class', 'task '+value); });
  });
}

function add_and_bind_form( to, project_id ) {
  to.load("/projects/"+project_id+"/tasks/new?embed=true", function() { 
    $("form").ajaxForm({ success: function(data, textStatus){
      //$(this).parent().parent().siblings("ul.task_list").prepend( data );
      //bind_task_actions( $(this).parent().parent().siblings("ul.task_list").children("li.task:last") )
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
  
