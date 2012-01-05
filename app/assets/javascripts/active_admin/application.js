/* Active Admin JS */
$(function(){
  $(".datepicker").datepicker($.datepicker.regional[$('html').attr('lang')]);

  $(".clear_filters_btn").click(function(){
    window.location.search = "";
    return false;
  });
  
  // yeah I know... I will refactor it sometime
   $('.sidebar.modal form .filter_form_field').wrapAll('<div class="modal-body"/>');
   $('.sidebar.modal form .filter_form_field label').removeClass('label');
   
  // thumbnails on forms
  $('form .thumbnail').each(function(){
    var img = $(this).find('img');
    
    if (img.length) {
      img.appendTo($(this).find('div:first'));
      img.wrap('<figure/>');
      img.parent().append('<a class="remove">Remove</a>');
  
      var that= this;
      $(this).find('.remove').click(function(){
        $(that).find('figure').hide();
        $(that).find('input').show()
      });
      
      $(this).find('input').hide()
    }
  });
});
