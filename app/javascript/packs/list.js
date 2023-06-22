
('.see-more').click(function(){
  (this).closest(".content-body").find(".truncated").hide();
  (this).closest(".content-body").find(".untruncated").show();
})