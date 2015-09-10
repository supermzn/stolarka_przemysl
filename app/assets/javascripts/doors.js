jQuery(document).ready(function ($) {

  $('#checkbox').change(function(){
    setInterval(function () {
        moveRight();
    }, 3000);
  });
  
    var slideCount = $('#slider ul li').length;
    var slideWidth = $('#slider ul li').width();
    var slideHeight = $('#slider ul li').height();
    var sliderUlWidth = slideCount * slideWidth;
    
    $('#slider').css({ width: slideWidth, height: slideHeight });
    
    $('#slider ul').css({ width: sliderUlWidth, marginLeft: - slideWidth });
    
    $('#slider ul li:last-child').prependTo('#slider ul');

    function moveLeft() {
        $('#slider ul').animate({
            left: + slideWidth
        }, 200, function () {
            $('#slider ul li:last-child').prependTo('#slider ul');
            $('#slider ul').css('left', '');
        });
    };

    function moveRight() {
        $('#slider ul').animate({
            left: - slideWidth
        }, 200, function () {
            $('#slider ul li:first-child').appendTo('#slider ul');
            $('#slider ul').css('left', '');
        });
    };

    $('a.control_prev').click(function () {
        moveLeft();
    });

    $('a.control_next').click(function () {
        moveRight();
    });

});    

// //////////////////////////////////////////
////////////////////////////////////////////
///////////////////////////////////////////
jQuery(function($) { 

  // settings
  var $slider = $('.slider'); // class or id of carousel slider
  var $slide = 'li'; // could also use 'img' if you're not using a ul
  var $transition_time = 1000; // 1 second
  var $time_between_slides = 2000; // 4 seconds

  function slides(){
    return $slider.find($slide);
  }

  slides().fadeOut();

  // set active classes
  slides().first().addClass('active');
  slides().first().fadeIn($transition_time);

  $(".next").click(function(){
      var $i = $slider.find($slide + '.active').index();

      slides().eq($i).removeClass('active');
      slides().eq($i).fadeOut($transition_time);

      if (slides().length == $i + 1) $i = -1; // loop to start

      slides().eq($i + 1).fadeIn($transition_time);
      slides().eq($i + 1).addClass('active');
    });

    $(".prev").click(function(){
      var $i = $slider.find($slide + '.active').index();

      slides().eq($i).removeClass('active');
      slides().eq($i).fadeOut($transition_time);

      if (slides().length == $i + 1) $i = -1; // loop to start

      slides().eq($i - 1).fadeIn($transition_time);
      slides().eq($i - 1).addClass('active');
    });

});
    




// $('.next').click(function() {
//   clearInterval(autoSlide);
//   currentIndex += 1;
//   if (currentIndex > itemAmt - 1) {
//     currentIndex = 0;
//   }
//   cycleItems();
// });

// $('.prev').click(function() {
//   clearInterval(autoSlide);
//   currentIndex -= 1;
//   if (currentIndex < 0) {
//     currentIndex = itemAmt - 1;
//   }
//   cycleItems();
// });


// function slideSwitch() {
//     var $active = $('#slideshow IMG.active');

//     if ( $active.length == 0 ) $active = $('#slideshow IMG:last');

//     var $next =  $active.next().length ? $active.next()
//         : $('#slideshow IMG:first');

//     $active.addClass('last-active');
        
//     $next.css({opacity: 0.0})
//         .addClass('active')
//         .animate({opacity: 1.0}, 1000, function() {
//             $active.removeClass('active last-active');
//         });
// }

// $(function() {
//     setInterval( "slideSwitch()", 3000 );
// });