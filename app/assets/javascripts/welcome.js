$(document).ready(function (){
  $("#welcome-signup").css("opacity", 0).animate({ opacity: 1}, 6000);
  $("#welcome-video").css("opacity", 0).animate({ opacity: 1}, 2000);

  // $("#box").css("opacity", 1).animate({opacity: 0}, 7000);
  // $("#box").css("width", 10000).animate({width: 0}, 7000);
  $("#box").animate({opacity:0},9000);
  // $("#box").css("height", 200px).animate({height: 0}, 6000);
  // $("#welcome-description").css("opacity", 0).animate({ opacity: 1}, 2000);
  // setTimeout(function() {
  //     $("#app-info").css("opacity", 0).animate({ opacity: 1}, 2000);
  // }, 0);
  $( "#rate-submit" ).click(function() {
    $( ".rating-form" ).fadeOut( "slow", function() {
      // Animation complete.
    });
  });


});
