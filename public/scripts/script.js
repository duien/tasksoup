$(function(){
  $("#sidebar .content").load("/pages?embed=true");
});

function add_and_bind_form( to, page_id ) {
  to.load("/pages/" + page_id + "/tasks/new?embed=true", function() { 
    $(this).find("form").ajaxForm({ success: function(data, textStatus){
      $("#main .content").html( data );
    }});
    $(this).find("#task_expand").click(function(){
      var input = $(this).siblings("#task_text");
      var value = input.val();
      input.replaceWith( "<textarea name='task[text]' id='task_text'>"+value+"</textarea>" );
      $(this).remove();
    });
  });
};

function add_and_bind_page_form( to ) {
  to.load("/pages/new?embed=true", function() { 
    $(this).find("form").ajaxForm({ success: function(data, textStatus){
      // alert( data + "..." + textStatus );
      $("#sidebar .content").html( data );
    }});
  });
};
  
