
// editing door (edit and cancel)
$('#cancel_edit_door').click(function() {
  $('#door_description').show('slow');
  $('#edit_door').show('slow');
  $('#cancel_edit_door').hide();
  $('#form-edit').hide();
});

$('#edit_door').click(function() {
  $('#door_description').hide('slow');
  $('#form-edit').show('slow');
  $('#edit_door').hide();
  $('#cancel_edit_door').show();
});

// gallery
jQuery(function($) { 

  // settings
  var $slider = $('.slider'); 
  var $slide = 'li'; 
  var $transition_time = 1000; 
  var $time_between_slides = 2000;

  function slides(){
    return $slider.find($slide);
  }

  slides().fadeOut();

  // set active classes
  slides().first().addClass('active');
  slides().first().fadeIn($transition_time);

  $("#next").click(function(){
      var $i = $slider.find($slide + '.active').index();

      slides().eq($i).removeClass('active');
      slides().eq($i).fadeOut($transition_time);

      if (slides().length == $i + 1) $i = -1; // loop to start

      slides().eq($i + 1).fadeIn($transition_time);
      slides().eq($i + 1).addClass('active');
    });

    $("#prev").click(function(){
      var $i = $slider.find($slide + '.active').index();

      slides().eq($i).removeClass('active');
      slides().eq($i).fadeOut($transition_time);

      if (slides().length == $i + 1) $i = -1; // loop to start

      slides().eq($i - 1).fadeIn($transition_time);
      slides().eq($i - 1).addClass('active');
    });

});