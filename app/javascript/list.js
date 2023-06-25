$(document).on('turbolinks:load', function() {
  $(document).ready(function () {
    $('.see-more').on('click', function(){
      $('.untruncated').removeClass('hide')
      $('.truncated').addClass("hide")
      $('see-more').addClass("hide")
    });
  });
});