
// // editing door (edit and cancel)
jQuery(function($) {
  $('#cancel_edit_door').click(function() {
    $('#door_description').show('slow');
    $('#edit_door').show('slow');
    $('#cancel_edit_door').hide();
    $('#form-edit').hide();

  });
  
  $('#edit_door').click(function() {
        // $( "cancel_edit_door" ).remove();
    // $('#door_description').hide('slow');
    // $('#form-edit').show('slow');
    // $('#edit_door').hide();
    // $('#cancel_edit_door').show();
  });
})