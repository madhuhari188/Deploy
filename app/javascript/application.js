// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

//= require jquery

// import "@hotwired/turbo-rails"
import Rails from '@rails/ujs'
Rails.start()
// import JQuery from 'jquery';
// window.$ = window.JQuery = JQuery;

// $(window).load(function(){
//    let url_value = window.location.href
//    console.log(url_value)
//    $.ajax({
//       type: "POST",
//       url: url_value+"/readstatus",
//       // data: {topic_id:1,post_id:1},
//       success: function(resp){
//          $('.unread').html("read").addClass("bg-success").removeClass("bg-danger");
//          console.log(resp)
//       }
//       // dataType: dataType
//    })

$(document).ready(function() {
//    $("#post_btn").click(function () {
// //    $("#loader").css("display","block")
//       console.log("complete")
//    })


   console.log("Hello")
})
// $(document).ajaxStart(function() {
//    $("#loader").show();
// })
// $(document).ajaxStop(function() {
//    $("#loader").hide();
// });
   $(".open").click(function() {
   confirm("oi")

})
//
// console.log("Hai")