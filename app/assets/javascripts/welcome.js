$(document).ready(function (){
  $("#welcome-signup").css("opacity", 0).animate({ opacity: 1}, 5000);
  $("#welcome-video").css("opacity", 0).animate({ opacity: 1}, 1000);
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
