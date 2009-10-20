$(function(){
  $("#sidebar .content").load("/pages?embed=true");
});

function add_and_bind_form( to, page_id, type ) {
  to.load("/pages/" + page_id + "/contents/new?embed=true&type=" + type, function() { 
    $(this).find("form").ajaxForm({ success: function(data, textStatus){
      // alert( data + "..." + textStatus );
      $("#main .content").html( data );
    }});
    $(this).find("#"+type+"_expand").click(function(){
      var input = $(this).siblings("#"+type+"_text");
      var value = input.val();
      input.replaceWith( "<textarea name='"+type+"[text]' id='"+type+"_text'>"+value+"</textarea>" );
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
  
