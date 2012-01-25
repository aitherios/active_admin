//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery-ui-i18n
//= require bootstrap/alerts
//= require bootstrap/buttons
//= require bootstrap/dropdown
//= require bootstrap/modal
//= require bootstrap/scrollspy
//= require bootstrap/tabs
//= require bootstrap/twipsy
//= require bootstrap/popover
//= require markitup/jquery.markitup
//= require markitup/sets/default/set
//= require chosen.jquery.min


/* Active Admin JS */
$(function(){
  // Chosen Applications
  $('select').chosen();
	
  // datepicker for filters ---------------------------------------------------
  $(".datepicker").datepicker($.datepicker.regional[$('html').attr('lang')]);

  // from active admin --------------------------------------------------------
  $(".clear_filters_btn").click(function(){
    window.location.search = "";
    return false;
  });
  
  // editor --------------------------------------------------------------------
  mySettings.previewTemplatePath =	'/admin/preview';
  mySettings.previewInWindow = 'width=800, height=600, resizable=yes, scrollbars=yes';
  $('.editor').markItUp(mySettings);
  
  // yeah I know... I will refactor it sometime -----------------------------------
   $('.sidebar.modal form .filter_form_field').wrapAll('<div class="modal-body"/>');
   $('.sidebar.modal form .filter_form_field label').removeClass('label');
   
  // thumbnails on forms-----------------------------------------------------------
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

