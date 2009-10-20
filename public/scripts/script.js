function add_and_bind_form( to, page_id, type ) {
  to.load("/pages/" + page_id + "/contents/new?type=" + type, function() { 
    $(this).find("form").ajaxForm({ success: function(data, textStatus){ alert( data + "..." + textStatus );}});
  });
};
  
