/* Active Admin JS */
$(function(){
  $(".datepicker").datepicker($.datepicker.regional[$('html').attr('lang')]);

  $(".clear_filters_btn").click(function(){
    window.location.search = "";
    return false;
  });
  
  // yeah I know...
   $('.sidebar.modal form .filter_form_field').wrapAll('<div class="modal-body"/>');
   $('.sidebar.modal form .filter_form_field label').removeClass('label');
});
