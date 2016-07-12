var page_title = ""
$(function(){
  page_title = $('title').text()
  $("#" + page_title).addClass("active");
});
